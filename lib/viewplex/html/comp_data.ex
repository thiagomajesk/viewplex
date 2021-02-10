alias Viewplex.HTML.CompData

defmodule Viewplex.HTML.CompData do
  @moduledoc """
  This module holds the internal representation of a component data.
  It implements the `Phoenix.HTML.Safe` protocol.
  """

  defstruct [:impl, :block, :slots, :assigns]

  @doc false
  def new(module, slots, block, assigns) do
    map = %{impl: module, slots: slots}

    opts =
      case module.mount(assigns) do
        {:ok, assigns} ->
          %{block: block, assigns: assigns}

        {:error, _reason} ->
          %{block: nil, assigns: assigns}
      end

    struct(CompData, Map.merge(map, opts))
  end
end

defimpl Phoenix.HTML.Safe, for: CompData do
  def to_iodata(%CompData{block: nil}), do: nil

  def to_iodata(%CompData{impl: module, assigns: assigns, slots: slots, block: block}) do
    assigns =
      module
      |> struct(assigns)
      |> Map.put(:slots, map_named_slots(slots))
      |> Map.put(:content, block)
      |> Map.from_struct()

    Phoenix.HTML.Safe.to_iodata(module.call(module, assigns))
  end

  defp map_named_slots(nil), do: %{}
  defp map_named_slots([]), do: %{}

  defp map_named_slots(slots) do
    Map.new(slots, fn slot -> {slot.name, slot} end)
  end
end
