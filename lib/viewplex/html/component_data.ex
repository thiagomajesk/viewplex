alias Viewplex.HTML.ComponentData

defmodule Viewplex.HTML.ComponentData do
  @moduledoc """
  This module holds the internal representation of a component data.
  It implements the `Phoenix.HTML.Safe` protocol.
  """

  defstruct [:impl, :block, :slots, :assigns]

  require Logger

  @doc false
  def new(module, slots, block, assigns) do
    map =
      case module.mount(assigns) do
        {:ok, assigns} ->
          Logger.info("Component #{inspect(module)} mounted: #{inspect(assigns)}")
          %{block: block, assigns: Enum.into(assigns, %{})}

        {:error, reason} ->
          Logger.warn("Component #{inspect(module)} not mounted: #{inspect(reason)}")
          %{block: nil, assigns: nil}
      end

    fields = %{impl: module, slots: slots}
    fields = Map.merge(fields, map)

    struct(ComponentData, fields)
  end
end

defimpl Phoenix.HTML.Safe, for: ComponentData do
  def to_iodata(%ComponentData{block: nil, slots: []}), do: []

  def to_iodata(%ComponentData{impl: module, assigns: assigns, slots: slots, block: block}) do
    assigns =
      module
      |> struct(assigns)
      |> Map.put(:slots, map_named_slots(slots))
      |> Map.put(:content, block)
      |> Map.from_struct()

    Phoenix.HTML.Safe.to_iodata(module.render(assigns))
  end

  defp map_named_slots(nil), do: %{}
  defp map_named_slots([]), do: %{}

  defp map_named_slots(slots) do
    Map.new(slots, fn slot -> {slot.name, slot} end)
  end
end
