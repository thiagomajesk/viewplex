defmodule Viewplex.Helpers do
  import Phoenix.View, only: [render: 3]

  def component(module) do
    render_component(module, %{})
  end

  def component(module, do: block) do
    render_component(module, content: block)
  end

  def component(module, params) when is_list(params) do
    render_component(module, params)
  end

  def component(module, params, do: block) when is_list(params) do
    render_component(module, Keyword.put(params, :content, block))
  end

  defp render_component(module, assigns) do
    render(module, module.__template__(), assigns)
  end
end
