defmodule Phy.GeneratorTest do
  use ExUnit.Case, async: true

  import MixHelper

  @moduletag :tmp_dir

  describe "build/3" do
    test "it returns ok", config do
      in_tmp_project(config, fn ->
        assert Phy.Generator.build("path", "template", %{}) == :ok
      end)
    end

    test "it saves the file", config do
      in_tmp_project(config, fn ->
        Phy.Generator.build("path", "template", %{})

        assert_file "path", "template"
      end)
    end

    test "it creates the file's directory", config do
      in_tmp_project(config, fn ->
        Phy.Generator.build("path/to/file", "template", %{})

        assert_dir "path/to"
      end)
    end

    test "it processes the template via EEx", config do
      in_tmp_project(config, fn ->
        Phy.Generator.build("path", "<%= 1 + 1 %>", %{})

        assert_file "path", "2"
      end)
    end
  end
end
