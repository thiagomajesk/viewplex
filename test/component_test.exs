defmodule Viewplex.ComponentTest do
  use ExUnit.Case

  alias Test.Support.Components.MountError
  alias Test.Support.Components.Mount
  alias Test.Support.Components.OptsBlock
  alias Test.Support.Components.Opts
  alias Test.Support.Components.SimpleBlock
  alias Test.Support.Components.Simple
  alias Test.Support.Components.Slot
  alias Test.Support.Components.Grouped.Grouped

  import Viewplex.Helpers

  describe "renders component" do
    test "should not render when there's a mount error" do
      data = component(MountError)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert iodata == nil
    end

    test "should render passing custom opts when mounting" do
      data = component(Mount, name: "John")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "<strong>John</strong>\n"
    end

    test "should render passing custom opts using content block" do
      data =
        component OptsBlock, name: "John" do
          "How are you?"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "<h1>Hello John, How are you?</h1>\n"
    end

    test "should render passing custom opts" do
      data = component(Opts, name: "John")
      iodata = Phoenix.HTML.Safe.to_iodata(data)

      assert IO.iodata_to_binary(iodata) == "<h1>Hello John</h1>\n"
    end

    test "should render simple with block" do
      data =
        component SimpleBlock do
          "John"
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "<h1>Hello John</h1>\n"
    end

    test "should render simple" do
      data = component(Simple)
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "<h1>Hello World</h1>\n"
    end

    test "should render using slot" do
      data =
        component Slot do
          "Welcome!"

          slot :greet do
            "Hello Sir"
          end

          slot :name do
            "John"
          end
        end

      iodata = Phoenix.HTML.Safe.to_iodata(data)

      assert IO.iodata_to_binary(iodata) ==
               "<div>\n  <h1>Hello Sir</h1>\n  <span>John</span>\n  <p>Welcome!</p>\n</div>\n"
    end

    test "should render inside group" do
      data = component(Grouped, [], "Hello World")
      iodata = Phoenix.HTML.Safe.to_iodata(data)
      assert IO.iodata_to_binary(iodata) == "<h1>Hello World</h1>\n"
    end

  end
end
