defmodule Viewplex.HelpersTest do
  use ExUnit.Case

  alias Viewplex.Fixtures.SimpleInlineComponent
  alias Viewplex.Fixtures.BlocklessInlineComponent
  alias Viewplex.Fixtures.BlockInlineComponent
  alias Viewplex.Fixtures.SlotInlineComponent

  import Viewplex.Helpers

  doctest Viewplex.Helpers

  describe "component/1" do
    test "renders compontent without any opts" do
      data = component(BlocklessInlineComponent)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello World"
    end

    test "renders component using default opts" do
      data = component(SimpleInlineComponent)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John"
    end
  end

  describe "component/2" do
    test "renders component using custom opts" do
      data = component(SimpleInlineComponent, name: "James")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James"
    end

    test "renders component using block content" do
      data =
        component BlockInlineComponent do
          "Welcome!"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, Welcome!"
    end

    test "renders component passing inline content" do
      data = component(BlockInlineComponent, "Welcome!")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, Welcome!"
    end
  end

  describe "component/3" do
    test "renders component using block and default opts" do
      data =
        component BlockInlineComponent do
          "Welcome!"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, Welcome!"
    end

    test "renders component using block content and custom opts" do
      data =
        component BlockInlineComponent, name: "James" do
          "Welcome!"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, Welcome!"
    end

    test "renders component passing inline content" do
      data = component(BlockInlineComponent, [name: "James"], "Welcome!")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, Welcome!"
    end
  end

  describe "renders component with slots" do
    test "using content block and default opts" do
      data =
        component SlotInlineComponent do
          slot :greet do
            "Hello"
          end

          "How Are You?"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello John, How Are You?"
    end

    test "using content block and custom opts" do
      data =
        component SlotInlineComponent, name: "James" do
          slot :greet do
            "Hello"
          end

          "How Are You?"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, How Are You?"
    end

    test "renders component passing inline content" do
      data = component SlotInlineComponent, name: "James" do
        slot(:greet, "Hello")
        "How Are You?"
      end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "Hello James, How Are You?"
    end
  end
end
