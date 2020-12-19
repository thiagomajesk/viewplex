defmodule Viewplex.Helpers do
  import Phoenix.View, only: [render: 3]

  def component(module) do
    render(module, module.__template__, %{})
  end
end
