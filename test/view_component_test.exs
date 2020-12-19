defmodule ViewplexTest do
  use ExUnit.Case

  import Viewplex.Helpers

  alias Viewplex.Components.Title

  doctest Viewplex

  test "component/1" do
    html =
      Title
      |> component()
      |> Phoenix.HTML.safe_to_string()

    assert html == "<h1>Hi!</h1>\n"
  end
end
