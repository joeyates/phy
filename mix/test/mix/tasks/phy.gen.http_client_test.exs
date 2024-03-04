defmodule Mix.Tasks.Phy.Gen.HTTPClientTest do
  use ExUnit.Case, async: true

  import MixHelper
  alias Mix.Tasks.Phy.Gen.HTTPClient

  @moduletag :tmp_dir

  test "creates the client", config do
    in_tmp_project(config, fn ->
      HTTPClient.run([])

      assert_file("lib/my_app/http_client.ex", fn file ->
        assert file =~ "defmodule MyApp.HTTPClient"
      end)
    end)
  end

  test "it creates the test", config do
    in_tmp_project(config, fn ->
      HTTPClient.run([])

      assert_file("test/my_app/http_client_test.exs", fn file ->
        assert file =~ "defmodule MyApp.MockHTTPClient do"
      end)
    end)
  end
end
