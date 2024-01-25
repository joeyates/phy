defmodule Phy.Generate.LiveViewTest do
  use ExUnit.Case, async: true

  test "it returns ok" do
    assert Phy.Generate.LiveView.run(["args"]) == {:ok}
  end
end
