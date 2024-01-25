defmodule MixProjectMock do
  def config do
    %{the: :config}
  end
end

defmodule Phy.Mix.ProjectTest do
  use ExUnit.Case, async: true

  describe "config/0" do
    test "it reads the config" do
      assert Phy.Mix.Project.config(MixProjectMock) == %{the: :config}
    end
  end
end
