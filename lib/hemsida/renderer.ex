defmodule Hemsida.Renderer do
  use Phoenix.Component

  embed_templates("templates/*")

  def post(assigns) do
    ~H"""
    <.layout title={@post.title} url={@post.output_path} build_timestamp={@build_timestamp}>
      <div class="container-reading py-8">
        <.full_article post={@post} />
      </div>
    </.layout>
    """
  end

  def page_title(assigns) do
    ~H"""
    <h1 class="text-4xl md:text-5xl font-bold tracking-tight text-slate-900"><%= render_slot @inner_block %></h1>
    """
  end

  # Helper function to format dates in Swedish
  def format_date(%Date{} = date) do
    months = %{
      1 => "januari",
      2 => "februari",
      3 => "mars",
      4 => "april",
      5 => "maj",
      6 => "juni",
      7 => "juli",
      8 => "augusti",
      9 => "september",
      10 => "oktober",
      11 => "november",
      12 => "december"
    }

    "#{date.day} #{months[date.month]} #{date.year}"
  end

  def format_date(_), do: ""

  # Helper to extract excerpt from content (first 150 chars)
  def excerpt(content) when is_binary(content) do
    content
    # Remove HTML tags
    |> String.replace(~r/<[^>]*>/, " ")
    # Normalize whitespace
    |> String.replace(~r/\s+/, " ")
    |> String.trim()
    |> String.slice(0, 150)
    |> Kernel.<>("...")
  end

  def excerpt(_), do: ""
end
