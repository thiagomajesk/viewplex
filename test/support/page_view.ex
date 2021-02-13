defmodule PageView do
  use Phoenix.View, root: "test/support", namespace: __MODULE__, path: ""

  import Viewplex.Helpers
  alias Test.Support.Components.Slot

end
