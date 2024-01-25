defmodule Phy.Generate.LiveViewTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  setup do
    stub(Phy.FileMock, :mkdir_p, fn _ -> :ok end)
    stub(Phy.FileMock, :write!, fn _, _ -> :ok end)
    stub(Phy.ProjectMock, :config, fn -> %{app: :my_app} end)

    :ok
  end

  test "it returns ok" do
    assert Phy.Generate.LiveView.run("name") == :ok
  end

  test "it creates the directory for the live_view" do
    expect(Phy.FileMock, :mkdir_p, fn "lib/my_app_web/live/bar" -> :ok end)
    expect(Phy.FileMock, :mkdir_p, fn _ -> :ok end)

    Phy.Generate.LiveView.run("bar/name")
  end

  test "it creates the live_view" do
    expect(Phy.FileMock, :write!, fn "lib/my_app_web/live/bar/name_live.ex", _ -> :ok end)
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)

    Phy.Generate.LiveView.run("bar/name")
  end

  test "it creates the directory for the test" do
    expect(Phy.FileMock, :mkdir_p, fn _ -> :ok end)
    expect(Phy.FileMock, :mkdir_p, fn "test/my_app_web/live/bar" -> :ok end)

    Phy.Generate.LiveView.run("bar/name")
  end

  test "it creates the test" do
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)
    expect(Phy.FileMock, :write!, fn "test/my_app_web/live/bar/name_live_test.exs", _ -> :ok end)

    Phy.Generate.LiveView.run("bar/name")
  end
end
