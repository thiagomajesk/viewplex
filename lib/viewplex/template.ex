defmodule Viewplex.Template do
  @moduledoc false

  import Phoenix.Naming, only: [unsuffix: 2, underscore: 1]
  import Phoenix.Template, only: [template_path_to_name: 2]

  def template_path(module, root) do
    module
    |> unsuffix("Component")
    |> Module.split()
    |> Enum.map(&underscore/1)
    |> Path.join()
    |> template_path_to_name(root)
  end
end
