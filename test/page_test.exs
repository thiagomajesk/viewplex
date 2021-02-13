defmodule Viewplex.PageTest do
  use ExUnit.Case

  test "should render inside page" do
    iodata = Phoenix.View.render_to_iodata(PageView, "page.html", [])
    assert IO.iodata_to_binary(iodata) == "<div>\n  <h1>    <strong>Hello!<strong>\n</h1>\n  <span>    <span>John</span>\n</span>\n  <p>  <p>How are you?</p>\n</p>\n</div>\n"
  end
end
