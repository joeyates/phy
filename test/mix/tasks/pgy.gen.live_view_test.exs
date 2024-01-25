defmodule Mix.Tasks.Phy.Gen.LiveViewTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "it runs the generator" do
    expect(Phy.Generate.LiveViewMock, :run, fn "name" -> {:ok} end)

    Mix.Tasks.Phy.Gen.LiveView.run(["name"])
  end

  test "when no name is supplied" do
    assert_raise RuntimeError, ~r[Please supply a name for the LiveView], fn ->
      Mix.Tasks.Phy.Gen.LiveView.run([])
    end
  end
end
