defmodule Viewplex.HelpersTest do
  use ExUnit.Case

  import Viewplex.Helpers

  doctest Viewplex.Helpers

  describe "component/1" do
    test "renders compontent without assigns" do
      data = component(AssignlessComponentFixture)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello World"
    end

    test "renders component with default assigns" do
      data = component(AssignfullComponentFixture)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John"
    end
  end

  describe "component/2" do
    test "renders component with assigns" do
      data = component(AssignfullComponentFixture, name: "James")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James"
    end

    test "renders component with inline content" do
      data = component(BlockfullComponentFixture, "How Are You?")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, How Are You?"
    end

    test "renders component with content block" do
      data = component(BlockfullComponentFixture, do: "How Are You?")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, How Are You?"
    end
  end

  describe "component/3" do
    test "renders component with assigns and content block" do
      data = component(BlockfullComponentFixture, [name: "James"], do: "How Are You?")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, How Are You?"
    end

    test "renders component with assigns and inline content" do
      data = component(BlockfullComponentFixture, [name: "James"], "How Are You?")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, How Are You?"
    end
  end

  describe "renders component with slots" do
    test "using content block and content block slots" do
      data =
        component SlotfullComponentFixture do
          slot(:greet, do: "Hello")
          slot(:name, do: "John")
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John"
    end

    test "using content block and inline content slots" do
      data =
        component SlotfullComponentFixture do
          slot(:greet, "Hello")
          slot(:name, "John")
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John"
    end
  end
end
