defmodule Viewplex.Fixtures.BlockInlineComponent do
  use Viewplex.Component, name: "John"

  def call(_module, assigns), do: ~E"Hello <%= assigns.name %>, <%= assigns.content %>"
end
