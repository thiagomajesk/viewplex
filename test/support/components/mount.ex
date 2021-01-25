defmodule Viewplex.Components.Mount do
  use Viewplex.Component

  def mount(_params) do
    {:ok, [name: "John"]}
  end
end
