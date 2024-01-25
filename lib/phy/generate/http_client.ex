defmodule Phy.Generate.HTTPClient do
  @callback run([String.t]) :: :ok
  def run(_args) do
    {:ok}
  end
end
