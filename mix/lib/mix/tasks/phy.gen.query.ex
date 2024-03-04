defmodule Mix.Tasks.Phy.Gen.Query do
  @moduledoc "Generate a Phoenix Query module"

  use Mix.Task

  alias Phy.Generator

  @project_root Path.expand("../../..", __DIR__)
  @templates_path Path.join([@project_root, "priv", "templates"])
  @templates [
    %{path: "lib/<%= @ app %>/<%= @downcased_context %>/validators/<%= @name %>_validator.ex", template: "query.ex.eex"},
    %{
      path: "test/<%= @ app %>/<%= @downcased_context %>/validators/<%= @name %>_validator_test.exs",
      template: "query_test.exs.eex"
    }
  ]
  for %{template: template} <- @templates do
    @external_resource Path.join(@templates_path, template)
  end

  @shortdoc "Creates a new Phoenix Query module"
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

    @templates
    |> Enum.each(fn %{path: path, template: template} ->
      template_path = Path.join(@templates_path, template)
      Generator.from_templates(path, template_path, assigns)
    end)

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
      As you have date fields in your query, date validations have been added.

      Add this to mix.exs:

      defp deps do
        [
          ...
          {:ecto_commons, "~> 0.3.5"}
        ]
      end
      """)
    end
  end

  def run(_args) do
    raise "Please supply a Context, a name and at least one field for the Query"
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
