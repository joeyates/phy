defmodule Mix.Tasks.Phy.Gen.HttpClientTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "it runs the generator" do
    expect(Phy.Generate.HTTPClientMock, :run, fn ["args"] -> {:ok} end)

    Mix.Tasks.Phy.Gen.HTTPClient.run(["args"])
  end
end
