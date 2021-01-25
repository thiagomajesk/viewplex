defmodule Viewplex.ComponentTest do
  use ExUnit.Case

  import Viewplex.Helpers
  import Phoenix.HTML, only: [safe_to_string: 1]

  alias Viewplex.Components.Title
  alias Viewplex.Components.TitleBlock
  alias Viewplex.Components.Label
  alias Viewplex.Components.LabelBlock
  alias Viewplex.Components.Fail
  alias Viewplex.Components.Mount

  doctest Viewplex

  describe "component/1" do
    test "without params and without block" do
      html = component(Title)

      assert safe_to_string(html) == "<h1>Hi!</h1>\n"
    end

    test "without params but with block" do
      html =
        component TitleBlock do
          "You"
        end

      assert safe_to_string(html) == "<h1>Hi! You</h1>\n"
    end

    test "with params and with block" do
      html =
        component LabelBlock, title: "Sir" do
          "John Doe"
        end

      assert safe_to_string(html) == "<span>\n  Hello!\nSir  <strong>John Doe</strong>\n</span>\n"
    end

    test "with params but without block" do
      html = component(Label, title: "Sir")

      assert safe_to_string(html) == "<span>\n  Hello!\nSir</span>\n"
    end

    test "should not render if mount failed" do
      assert component(Fail) == nil
    end

    test "should mount value" do
      html = component(Mount)
      assert safe_to_string(html) == "<strong>John</strong>\n"
    end
  end
end
