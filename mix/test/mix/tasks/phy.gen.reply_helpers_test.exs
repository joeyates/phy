defmodule Mix.Tasks.Phy.Gen.ReplyHelpersTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "it runs the generator" do
    expect(Phy.Generate.ReplyHelpersMock, :run, fn -> :ok end)

    Mix.Tasks.Phy.Gen.ReplyHelpers.run([])
  end
end
