defmodule Viewplex.Components.MountError do
  use Viewplex.Component

  def mount(_opts) do
    {:error, "could not mount"}
  end
end
