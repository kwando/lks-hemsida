defmodule Hemsida do
  use NimblePublisher,
    build: Hemsida.Post,
    from: Application.app_dir(:hemsida, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  use NimblePublisher,
    build: Hemsida.Page,
    from: Application.app_dir(:hemsida, "priv/pages/**/*.md"),
    as: :pages,
    highlighters: [:makeup_elixir, :makeup_erlang]

  def posts() do
    @posts
  end

  def latest_posts() do
    @posts
    |> Enum.reverse()
    |> Enum.take(5)
  end

  @output_dir "./output"
  def build() do
    File.mkdir_p!(@output_dir)

    render_file(
      "index.html",
      Hemsida.Renderer.index(%{
        posts: latest_posts()
      })
    )

    for post <- @posts do
      dir = Path.dirname(post.output_path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.output_path, Hemsida.Renderer.post(%{post: post}))
    end

    build_pages()
    copy_assets()
  end

  def page_root() do
    Application.app_dir(:hemsida, "priv/pages")
  end

  def pages() do
    @pages
  end

  defp build_pages() do
    for page <- pages() do
      IO.puts("building #{page.output_path}")
      dir = Path.dirname(page.output_path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(page.output_path, Hemsida.Renderer.page(%{page: page}))
    end
  end

  defp copy_assets() do
    File.cp_r!(Application.app_dir(:hemsida, "priv/static"), @output_dir)
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end
end
