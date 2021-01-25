defmodule Viewplex.ComponentTest do
  use ExUnit.Case

  import Viewplex.Helpers
  import Phoenix.HTML, only: [safe_to_string: 1]

  alias Viewplex.Components.Title
  alias Viewplex.Components.TitleBlock

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
  end
end
