defmodule Mix.Tasks.Phy.Gen.HTTPClientTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "it runs the generator" do
    expect(Phy.Generate.HTTPClientMock, :run, fn -> {:ok} end)

    Mix.Tasks.Phy.Gen.HttpClient.run(["args"])
  end
end
