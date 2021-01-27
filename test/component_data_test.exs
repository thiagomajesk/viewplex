defmodule Viewplex.CompDataTest do
  use ExUnit.Case

  alias Viewplex.HTML.CompData
  alias Viewplex.Fixtures.BlocklessInlineComponent

  import Viewplex.Helpers

  test "new/4 should return a built %CompData{}" do
    data = CompData.new(BlocklessInlineComponent, [], nil, [])

    assert %CompData{
             impl: BlocklessInlineComponent,
             block: nil,
             slots: [],
             assigns: []
           } = data
  end

  test "%CompData{} should render html" do
    data = component(BlocklessInlineComponent)
    iodata = Phoenix.HTML.Safe.to_iodata(data)
    assert IO.iodata_to_binary(iodata) == "Hello World"
  end
end
