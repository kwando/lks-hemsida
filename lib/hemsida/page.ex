defmodule Hemsida.Page do
  defstruct [:path, :content, :title, :output_path]

  def build(path, meta, content) do
    page_root = Application.app_dir(:hemsida, "priv/pages")

    %__MODULE__{
      path: path,
      title: meta[:title],
      content: content,
      output_path:
        Path.join(
          Path.relative_to(path, page_root)
          |> Path.dirname(),
          Path.basename(path, ".md") <> ".html"
        )
    }
  end
end
