defmodule Viewplex.View do
  import Phoenix.Naming, only: [resource_name: 1]

  defmacro __using__(_opts) do
    quote do
      path = Application.get_env(:viewplex, :path)

      use Phoenix.View, root: path, namespace: __MODULE__, path: ""

      def __template__, do: "#{resource_name(__MODULE__)}.html"
    end
  end
end
