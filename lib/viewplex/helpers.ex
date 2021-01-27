defmodule Viewplex.Helpers do
  @moduledoc """
  Helper functions to create components and slots.
  """

  alias Viewplex.Builder

  defmacro component(module) do
    Builder.comp_data(module, [], nil)
  end

  defmacro component(module, do: block) do
    Builder.comp_data(module, [], block)
  end

  defmacro component(module, assigns) when is_list(assigns) do
    Builder.comp_data(module, assigns, nil)
  end

  defmacro component(module, content) do
    Builder.comp_data(module, [], Phoenix.HTML.html_escape(content))
  end

  defmacro component(module, assigns, do: block) when is_list(assigns) do
    Builder.comp_data(module, assigns, block)
  end

  defmacro component(module, assigns, content) when is_list(assigns) do
    Builder.comp_data(module, assigns, Phoenix.HTML.html_escape(content))
  end

  defmacro slot(name, do: block) do
    Builder.slot_data(name, block)
  end

  defmacro slot(name, content) do
    Builder.slot_data(name, Phoenix.HTML.html_escape(content))
  end
end
