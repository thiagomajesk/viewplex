defmodule SlotfullComponentFixture do
  use Viewplex.Component

  def render(assigns) do
    ~E"<%= assigns.slots.greet %> <%= assigns.slots.name %>"
  end
end
