defmodule Viewplex.IodataTest do
  use ExUnit.Case

  alias Viewplex.HTML.ComponentData
  alias Viewplex.HTML.NamedSlotData

  import Phoenix.HTML
  import Viewplex.Helpers

  defmodule ComponentFixture do
    use Viewplex.Component
    def render(assigns), do: ~E"<%= assigns.content %>"
  end

  describe "ComponentData" do
    test "new/4 should return a built struct" do
      data = ComponentData.new(ComponentFixture, [], nil, [])
      assert %ComponentData{impl: ComponentFixture} = data
    end

    test "should output valid html" do
      data = ComponentData.new(ComponentFixture, [], ["Hello World"], [])
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello World"
    end
  end

  describe "NamedSlotData" do
    test "new/4 should return a built struct" do
      data = NamedSlotData.new(:greet, [])
      assert %NamedSlotData{name: greet} = data
    end

    test "should output valid html" do
      data = NamedSlotData.new(:greet, ["Hello World"])
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello World"
    end
  end
end
