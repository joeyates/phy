defmodule Phy.Generate.ReplyHelpersTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  setup do
    stub(Phy.FileMock, :write!, fn _, _ -> :ok end)
    stub(Phy.Mix.ProjectMock, :app, fn -> :my_app end)
    stub(Phy.Mix.ProjectMock, :module, fn -> :MyApp end)
    stub(Phy.Mix.ProjectMock, :web_module, fn -> :MyAppWeb end)

    :ok
  end

  test "it returns ok" do
    assert Phy.Generate.ReplyHelpers.run() == :ok
  end

  test "it creates the client" do
    expect(
      Phy.FileMock,
      :write!,
      fn "lib/my_app_web/reply_helpers.ex", "defmodule MyAppWeb.ReplyHelpers" <> _rest ->
        :ok
      end
    )
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)

    Phy.Generate.ReplyHelpers.run()
  end

  test "it creates the test" do
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)
    expect(
      Phy.FileMock,
      :write!,
      fn "test/my_app_web/reply_helpers_test.exs", "defmodule MyAppWeb.ReplyHelpersTest" <> _rest ->
        :ok
      end
    )

    Phy.Generate.ReplyHelpers.run()
  end
end
