defmodule Phy.GeneratorTest do
  use ExUnit.Case, async: true

  import MixHelper

  @moduletag :tmp_dir

  describe "build/3" do
    test "it returns ok", config do
      in_tmp_project(config, fn ->
        assert Phy.Generator.build("path", "template content", %{}) == :ok
      end)
    end

    test "it saves the file", config do
      in_tmp_project(config, fn ->
        Phy.Generator.build("path", "template content", %{})

        assert_file "path", "template content"
      end)
    end

    test "it creates the file's directory", config do
      in_tmp_project(config, fn ->
        Phy.Generator.build("path/to/file", "template content", %{})

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

  describe "from_templates/3" do
    test "it returns ok", config do
      in_tmp_project(config, fn ->
        File.write!("template_path", "template content")
        assert Phy.Generator.from_templates("output_path", "template_path", %{}) == :ok
      end)
    end

    test "it uses the template", config do
      in_tmp_project(config, fn ->
        File.write!("template_path", "template content")
        Phy.Generator.from_templates("output_path", "template_path", %{})

        assert_file "output_path", "template content"
      end)
    end

    test "it processes the output path via EEx", config do
      in_tmp_project(config, fn ->
        File.write!("template_path", "template content")
        Phy.Generator.from_templates("output_<%= @suffix %>", "template_path", %{suffix: "ciao"})

        assert_file "output_ciao", "template content"
      end)
    end

    test "it processes the template via EEx", config do
      in_tmp_project(config, fn ->
        File.write!("template_path", "<%= 1 + 1 %>")
        Phy.Generator.from_templates("output_path", "template_path", %{})

        assert_file "output_path", "2"
      end)
    end
  end
end
