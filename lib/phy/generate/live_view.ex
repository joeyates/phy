defmodule Phy.Generate.LiveView do
  @callback run([String.t]) :: :ok
  def run(_args) do
    {:ok}
  end
end
