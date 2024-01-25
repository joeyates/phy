defmodule MixMock do
  def shell do
    Mix.Shell.IO
  end
end

defmodule Phy.Mix.Test do
  use ExUnit.Case, async: true

  describe "config/0" do
    test "it reads the config" do
      assert Phy.Mix.shell(MixMock) == Mix.Shell.IO
    end
  end
end
