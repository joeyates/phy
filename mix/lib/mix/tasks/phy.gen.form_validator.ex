defmodule Mix.Tasks.Phy.Gen.FormValidator do
  @moduledoc "Generate a Phoenix form validator module"

  use Mix.Task

  use Phy.Generator,
    templates: [
      %{
        path: "lib/<%= @ app %>/<%= @downcased_context %>/validators/<%= @name %>_validator.ex",
        template: "form_validator.ex.eex"
      },
      %{
        path:
          "test/<%= @ app %>/<%= @downcased_context %>/validators/<%= @name %>_validator_test.exs",
        template: "form_validator_test.exs.eex"
      }
    ]

  @shortdoc "Creates a new Phoenix form validator module"
  def run([context, name | raw_fields] = args) when length(args) >= 3 do
    fields = parse_fields(raw_fields)

    app = Phy.Mix.Project.app()
    downcased_context = Macro.underscore(context)
    has_dates = has_date_field?(fields)
    module = Phy.Mix.Project.module()
    validator_module = "#{Macro.camelize(name)}Validator"

    assigns = %{
      app: app,
      context: context,
      downcased_context: downcased_context,
      fields: fields,
      has_dates: has_dates,
      module: module,
      name: name,
      validator_module: validator_module
    }

    generate(assigns)

    Mix.shell().info("""
    Add the following to 'lib/app/#{downcased_context}.ex':

    alias #{module}.#{context}.#{validator_module}

    @doc \"\"\"
    Validates user-supplied parameters for #{name}
    \"\"\"
    def validate_#{name}(params) do
      case #{validator_module}.changeset(%#{validator_module}{}, params) do
        %Changeset{valid?: true} = changeset ->
          {:ok, changeset}

        changeset ->
          {:error, changeset}
      end
    end
    """)

    if has_dates do
      Mix.shell().info("""
      As there are date fields, date validations have been added.

      Add this to mix.exs:

      defp deps do
        [
          ...
          {:ecto_commons, "~> 0.3.5"}
        ]
      end
      """)
    end

    :ok
  end

  def run(_args) do
    raise "Please supply a Context, a name and at least one field"
  end

  defp parse_fields(fields) do
    fields
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(fn
      [name, type] ->
        {name, type}

      _ ->
        raise """
        Fields should be in the format name:type
        """
    end)
  end

  defp has_date_field?(fields) do
    fields
    |> Enum.any?(fn {_, type} -> type == "date" end)
  end
end
