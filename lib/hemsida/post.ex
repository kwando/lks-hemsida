defmodule Hemsida.Post do
  defstruct [:path, :content, :title, :date, :output_path, :author]

  def build(path, meta, content) do
    [year, slug] =
      Path.rootname(path)
      |> String.split("/")
      |> Enum.take(-2)

    [month, day | _] = String.split(slug, "-", parts: 3)

    {:ok, post_date} =
      Date.from_erl({
        String.to_integer(year),
        String.to_integer(month),
        String.to_integer(day)
      })

    IO.inspect(meta)

    %__MODULE__{
      path: path,
      title: meta.title,
      date: post_date,
      content: content,
      output_path: Path.join(["posts", year, "#{slug}.html"]),
      author: meta[:author] || "Okänd"
    }
  end
end
