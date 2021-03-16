defmodule Viewplex.Builder do
  @moduledoc false

  def component_data(module, assigns, block) when is_list(assigns) do
    %{slots: slots, block: block} = map_slots(block)

    quote do
      Viewplex.HTML.ComponentData.new(
        unquote(module),
        unquote(slots),
        unquote(block),
        unquote(assigns)
      )
    end
  end

  def slot_data(name, block) do
    quote do
      Viewplex.HTML.NamedSlotData.new(unquote(name), unquote(block))
    end
  end

  defp map_slots({:__block__, _, list}) do
    result =
      Enum.reduce(list, %{slots: [], block: []}, fn
        {:slot, _, _} = slot, acc ->
          Map.update!(acc, :slots, &[slot | &1])

        block, acc ->
          Map.update!(acc, :block, &[block | &1])
      end)

    result
    |> Map.new(fn {k, v} -> {k, Enum.reverse(v)} end)
    |> Map.update!(:block, &{:__block__, [], &1})
  end

  defp map_slots(nil), do: %{slots: [], block: []}
  defp map_slots(block), do: %{slots: [], block: block}
end
