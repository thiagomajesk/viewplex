defmodule Test.Support.Components.Mount do
  use Viewplex.Component, [:name]

  def mount(_opts) do
    {:ok, [name: "John"]}
  end
end
