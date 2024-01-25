defmodule Phy.Mix do
  @callback shell() :: map()
  @callback shell(any()) :: map()
  def shell(mix \\ Mix) do
    mix.shell()
  end
end
