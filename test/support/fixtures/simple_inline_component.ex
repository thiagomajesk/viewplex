defmodule Test.Support.Fixtures.SimpleInlineComponent do
  use Viewplex.Component, name: "John"

  def call(_module, assigns), do: ~E"Hello <%= assigns.name %>"
end
