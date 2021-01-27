defmodule Viewplex.SlotDataTest do
  use ExUnit.Case

  alias Viewplex.HTML.SlotData

  import Phoenix.HTML, only: [safe_to_string: 1]

  test "%SlotData{} should render html" do
    data = SlotData.new(:title, ["Hello World"])
    iodata = Phoenix.HTML.Safe.to_iodata(data)
    safe = Phoenix.HTML.html_escape(iodata)
    assert safe_to_string(safe) == "Hello World"
  end
end
