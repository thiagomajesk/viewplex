defmodule ConditionalComponent do
  use Viewplex.Component, [:name]

  def mount(assigns) do
    case assigns[:enabled] do
      true -> {:ok, %{name: "John"}}
      _ -> {:error, "component disabled"}
    end
  end
end
