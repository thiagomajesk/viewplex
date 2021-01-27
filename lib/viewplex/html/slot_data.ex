alias Viewplex.HTML.SlotData

defmodule Viewplex.HTML.SlotData do
  @moduledoc """
  This module holds the internal representation of a slot data.
  It implements the `Phoenix.HTML.Safe` protocol.
  """

  defstruct [:name, :block]

  @doc false
  def new(name, block) do
    %SlotData{name: name, block: block}
  end
end

defimpl Phoenix.HTML.Safe, for: SlotData do
  def to_iodata(%SlotData{block: block}), do: Phoenix.HTML.Safe.to_iodata(block)
end
