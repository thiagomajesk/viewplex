defmodule AssignlessComponentFixture do
  use Viewplex.Component

  def render(_assigns), do: ~E"Hello World"
end
