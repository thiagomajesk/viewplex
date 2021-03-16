defmodule Viewplex.Component do
  @moduledoc """
  This module provides the base implementation of all components.
  When `use`ing the module, you can pass a list of fields as you would for `Kernel.defstruct/1`...
  The struct fields will be used to filter/ cast the assigns passed directly to the template.

  ## Examples

    No assigns allowed:

    ```
    defmodule MyComponent do
      use Viewplex.Component
    end
    ```

    Allowing only the `:name` assign:

    ```
    defmodule MyComponent do
      use Viewplex.Component, [:name]
    end
    ```

    Allowing the `:name` assign and defining a default value:

    ```
    defmodule MyComponent do
      use Viewplex.Component, [name: "John"]
    end
    ```
  """

  @doc """
  Mounts the component with the given assigns.
  This function can be used to override, compute or load necessary information for the component.
  It receives the assigns passed and expects a `{:ok, assigns}` or `{:error, reason}` tuple to be returned.
  If `:ok` is returned, the component is mounted with the given assigns, otherwhise it won't mount.
  """
  @callback mount(assigns :: any()) :: any()

  @doc """
  Renders the component with the given assigns.
  Expects a `{:safe, iodata}` to be returned.
  """
  @callback render(assigns :: any()) :: {:safe, iodata}

  @optional_callbacks mount: 1, render: 1

  @doc """
  Use Viewplex.Component in the current module to mark it as a component.
  """
  defmacro __using__(fields \\ []) do
    quote do
      defstruct [slots: %{}, content: nil] ++ unquote(fields)

      import Phoenix.HTML

      @behaviour Viewplex.Component

      @before_compile Viewplex.Renderer

      @impl Viewplex.Component
      def mount(assigns), do: {:ok, assigns}

      defoverridable mount: 1
    end
  end
end
