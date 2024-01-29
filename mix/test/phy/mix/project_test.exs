defmodule MixProjectMock do
  def config do
    [app: :my_app]
  end
end

defmodule Phy.Mix.ProjectTest do
  use ExUnit.Case, async: true

  describe "config/0" do
    test "it reads the config" do
      assert Phy.Mix.Project.config(MixProjectMock) == [app: :my_app]
    end
  end

  describe "app/0" do
    test "it returns the app name" do
      assert Phy.Mix.Project.app(MixProjectMock) == :my_app
    end
  end

  describe "module/0" do
    test "it camelizes the app name" do
      assert Phy.Mix.Project.module(MixProjectMock) == "MyApp"
    end
  end

  describe "web_module/0" do
    test "it adds 'Web' to the module" do
      assert Phy.Mix.Project.web_module(MixProjectMock) == "MyAppWeb"
    end
  end
end
