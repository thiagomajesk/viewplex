defmodule Viewplex.Components.Fail do
  use Viewplex.Component

  def mount(_params) do
    {:error, "could not mount"}
  end
end
