defmodule Mix.Tasks.Phy.Gen.ReplyHelpersTest do
  use ExUnit.Case, async: false

  import MixHelper
  alias Mix.Tasks.Phy.Gen.ReplyHelpers

  @moduletag :tmp_dir

  test "it creates the helper", config do
    in_tmp_project(config, fn ->
      ReplyHelpers.run([])

      assert_file "lib/my_app_web/reply_helpers.ex", ~r/defmodule MyAppWeb.ReplyHelpers/
    end)
  end

  test "it creates the test", config do
    in_tmp_project(config, fn ->
      ReplyHelpers.run([])

      assert_file "test/my_app_web/reply_helpers_test.exs",
                  ~r/defmodule MyAppWeb.ReplyHelpersTest/
    end)
  end
end
