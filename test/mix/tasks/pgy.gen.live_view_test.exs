defmodule Mix.Tasks.Phy.Gen.LiveViewTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "it runs the generator" do
    expect(Phy.Generate.LiveViewMock, :run, fn ["args"] -> {:ok} end)

    Mix.Tasks.Phy.Gen.LiveView.run(["args"])
  end
end
