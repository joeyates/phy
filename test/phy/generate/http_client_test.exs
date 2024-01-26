defmodule Phy.Generate.HTTPClientTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  setup do
    stub(Phy.FileMock, :write!, fn _, _ -> :ok end)
    stub(Phy.Mix.ProjectMock, :app, fn -> :my_app end)
    stub(Phy.Mix.ProjectMock, :module, fn -> :MyApp end)

    :ok
  end

  test "it returns ok" do
    assert Phy.Generate.HTTPClient.run() == :ok
  end

  test "it creates the client" do
    expect(
      Phy.FileMock,
      :write!,
      fn "lib/my_app/http_client.ex", "defmodule MyApp.HTTPClient" <> _rest ->
        :ok
      end
    )
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)

    Phy.Generate.HTTPClient.run()
  end

  test "it creates the test" do
    expect(Phy.FileMock, :write!, fn _, _ -> :ok end)
    expect(
      Phy.FileMock,
      :write!,
      fn "test/my_app/http_client_test.exs", "defmodule MockHTTPClient" <> _rest ->
        :ok
      end
    )

    Phy.Generate.HTTPClient.run()
  end
end
