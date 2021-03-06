alias Viewplex.HTML.NamedSlotData

defmodule Viewplex.HTML.NamedSlotData do
  @moduledoc """
  This module holds the internal representation of a slot data.
  It implements the `Phoenix.HTML.Safe` protocol.
  """

  defstruct [:name, :block]

  @doc false
  def new(name, block) do
    %NamedSlotData{name: name, block: block}
  end
end

defimpl Phoenix.HTML.Safe, for: NamedSlotData do
  def to_iodata(%NamedSlotData{block: block}), do: Phoenix.HTML.Safe.to_iodata(block)
end
