defmodule Phy.Generate.HttpClientTest do
  use ExUnit.Case, async: true

  test "it returns ok" do
    assert Phy.Generate.HTTPClient.run(["args"]) == {:ok}
  end
end
