defmodule Test.Support.Fixtures.SlotInlineComponent do
  use Viewplex.Component, name: "John"

  def call(_module, assigns),
    do: ~E"<%= assigns.slots.greet %> <%= assigns.name %>, <%= assigns.content %>"
end
