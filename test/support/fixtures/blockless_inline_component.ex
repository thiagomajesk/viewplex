defmodule Test.Support.Fixtures.BlocklessInlineComponent do
  use Viewplex.Component

  def call(_module, _assigns), do: ~E"Hello World"
end
