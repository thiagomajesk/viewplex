defmodule AssignfullComponentFixture do
  use Viewplex.Component, name: "John", greet: "Hello"

  def render(assigns), do: ~E"<%= assigns.greet %> <%= assigns.name %>"
end
