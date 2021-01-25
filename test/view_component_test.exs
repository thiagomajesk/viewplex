defmodule ViewplexTest do
  use ExUnit.Case

  import Viewplex.Helpers
  import Phoenix.HTML, only: [safe_to_string: 1]

  alias Viewplex.Components.Title
  alias Viewplex.Components.TitleBlock

  doctest Viewplex

  test "component/1 without block" do
    html =
      Title
      |> component()
      |> Phoenix.HTML.safe_to_string()

    assert html == "<h1>Hi!</h1>\n"
  end

  test "component/1 with block" do
    html =
      component TitleBlock do
        "You"
      end

    assert safe_to_string(html) == "<h1>Hi! You</h1>\n"
  end
end
