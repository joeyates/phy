defmodule Mix.Tasks.Phy.Gen.LiveViewTest do
  use ExUnit.Case, async: false

  import MixHelper
  alias Mix.Tasks.Phy.Gen.LiveView

  @moduletag :tmp_dir

  test "it creates the directory for the live_view", config do
    in_tmp_project(config, fn ->
      LiveView.run(["bar/name"])

      assert_dir "lib/my_app_web/live/bar"
    end)
  end

  test "it creates the live_view", config do
    in_tmp_project(config, fn ->
      LiveView.run(["bar/name"])

      assert_file "lib/my_app_web/live/bar/name_live.ex", ~r[defmodule MyAppWeb.Bar.NameLive do]
    end)
  end

  test "it creates the directory for the test", config do
    in_tmp_project(config, fn ->
      LiveView.run(["bar/name"])

      assert_dir "test/my_app_web/live/bar"
    end)
  end

  test "it creates the test", config do
    in_tmp_project(config, fn ->
      LiveView.run(["bar/name"])

      assert_file "test/my_app_web/live/bar/name_live_test.exs",
                  ~r[defmodule MyAppWeb.Bar.NameLiveTest do]
    end)
  end

  test "it tells the user to add the route", config do
    in_tmp_project(config, fn ->
      LiveView.run(["bar/name"])

      expected = """
      Add the following route to your router:

          live \"/bar/name\", Bar.NameLive, :index
      """

      assert_receive {:mix_shell, :info, [^expected]}
    end)
  end

  test "fails when no name is supplied" do
    assert_raise RuntimeError, ~r[Please supply a name for the LiveView], fn ->
      Mix.Tasks.Phy.Gen.LiveView.run([])
    end
  end
end
