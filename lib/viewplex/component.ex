defmodule Viewplex.Component do
  @moduledoc """
  This module provides the base implementation of all components.
  When `use`ing the module, you can pass a list of fields as you would for `Kernel.defstruct/1`...
  The struct fields will be used to filter/ cast the assigns passed to the directly to the template.
  Bear in mind that this module inner implementation relies heavily on `Phoenix.View`.

  ## Examples

    No assigns allowed:

    ```
    defmodule MyComponent do
      use Viewplex.Component
    end
    ```

    Allowing only the `:name` property:

    ```
    defmodule MyComponent do
      use Viewplex.Component, [:name]
    end
    ```

    Allowing the `:name` property and defining a default value:

    ```
    defmodule MyComponent do
      use Viewplex.Component, [name: "John"]
    end
    ```
  """

  defmacro __using__(fields \\ []) do
    quote do
      import Phoenix.HTML

      path = Application.get_env(:viewplex, :path)

      use Phoenix.View, root: path, namespace: __MODULE__, path: ""

      base_fields = [slots: %{}, content: nil]

      defstruct base_fields ++ unquote(fields)

      @doc false
      def __template__, do: "#{Phoenix.Naming.resource_name(__MODULE__)}.html"

      @doc """
      Mounts the component with the given assigns.
      This function can be used to override, compute or load necessary information for the component.
      It receives the assigns passed and expects a `{:ok | :error, assigns}` tuple to be returned.
      If `:ok` is returned, the component is mounted with the given assigns, otherwhise it won't mount.
      """
      @spec mount(assigns :: any()) :: {:ok | :error, assigns :: any()}
      def mount(assigns), do: {:ok, assigns}

      @doc """
      Renders the component with the given assigns. Relies on `Phoenix.View.render/3`.
      Expects a `{:safe, iodata}` to be returned.
      """
      @spec call(module:: any(), assigns:: any()) :: {:safe, iodata}
      def call(module, assigns) do
        render(module, module.__template__(), assigns)
      end

      defoverridable mount: 1
      defoverridable call: 2
    end
  end
end
