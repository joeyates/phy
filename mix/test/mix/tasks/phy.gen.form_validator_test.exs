defmodule Mix.Tasks.Phy.Gen.FormValidatorTest do
  use ExUnit.Case, async: true

  import MixHelper
  alias Mix.Tasks.Phy.Gen.FormValidator

  @moduletag :tmp_dir

  test "it creates the directory for the validator", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string"])

      assert_dir("lib/my_app/my_context/validators")
    end)
  end

  test "it creates the validator", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string"])

      assert_file(
        "lib/my_app/my_context/validators/name_validator.ex",
        ~r[defmodule MyApp.MyContext.NameValidator do]
      )
    end)
  end

  test "it creates the directory for the test", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string"])

      assert_dir("test/my_app/my_context/validators")
    end)
  end

  test "it creates the test", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string"])

      assert_file(
        "test/my_app/my_context/validators/name_validator_test.exs",
        ~r[defmodule MyApp.MyContext.NameValidatorTest do]
      )
    end)
  end

  test "it tells the user to add a function to the context", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string"])

      assert_receive {:mix_shell, :info,
                      [<<"Add the following to 'lib/app/my_context.ex'", _rest::binary>>]}
    end)
  end

  test "when date fields are present, it tells the user to add a dependency", config do
    in_tmp_project(config, fn ->
      FormValidator.run(["MyContext", "name", "field1:string", "field2:date"])

      expected = """
      As there are date fields, date validations have been added.

      Add this to mix.exs:

      defp deps do
        [
          ...
          {:ecto_commons, \"~> 0.3.5\"}
        ]
      end
      """

      assert_receive {:mix_shell, :info, [^expected]}
    end)
  end

  test "when no name is supplied" do
    assert_raise RuntimeError,
                 ~r[Please supply a Context, a name and at least one field],
                 fn ->
                   FormValidator.run([])
                 end
  end
end
