defmodule Viewplex.SamplesTest do
  use ExUnit.Case

  import Viewplex.Helpers

  test "label component" do
    data = component(LabelComponent, [], "Hello World")
    iodata = Phoenix.HTML.Safe.to_iodata(data)
    assert IO.iodata_to_binary(iodata) == "<label>Hello World</label>\n"
  end

  test "conditional component" do
    data = component(ConditionalComponent, enabled: true)
    iodata = Phoenix.HTML.Safe.to_iodata(data)
    assert IO.iodata_to_binary(iodata) == "<h1>Hello World John<h1>\n"

    data = component(ConditionalComponent, enabled: false)
    iodata = Phoenix.HTML.Safe.to_iodata(data)
    assert IO.iodata_to_binary(iodata) == ""
  end
end
