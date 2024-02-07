defmodule Hemsida.Renderer do
  use Phoenix.Component

  embed_templates("templates/*")

  def post(assigns) do
    ~H"""
    <.layout title={@post.title} url={@post.output_path}>
      <.article post={@post} />
    </.layout>
    """
  end

  def page_title(assigns) do
    ~H"""
    <h1 class="text-4xl font-bold tracking-tighter"><%= render_slot @inner_block %></h1>
    """
  end
end
