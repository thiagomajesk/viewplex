defmodule Viewplex.PagesTest do
  use ExUnit.Case

  test "should render inside page" do
    iodata = Phoenix.View.render_to_iodata(PageView, "page.html", [])

    assert IO.iodata_to_binary(iodata) ==
             "<div class=\"card\">\n  <h6 class=\"card-header\">    <strong>Hi John<strong>\n</h6>\n  <div class=\"card-body\">    <p>How are you?</p>\n</div>\n</div>\n"
  end
end
