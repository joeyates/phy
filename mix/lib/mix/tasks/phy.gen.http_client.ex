defmodule Mix.Tasks.Phy.Gen.HTTPClient do
  @moduledoc "Generate an HTTP client module and accompanying tests"

  alias Phy.Generator
  use Mix.Task

  @templates_path Path.join([File.cwd!(), "priv", "templates"])
  @templates [
    %{path: "lib/<%= @ app %>/http_client.ex", template: "http_client.ex.eex"},
    %{path: "test/<%= @ app %>/http_client_test.exs", template: "http_client_test.exs.eex"}
  ]
  for %{template: template} <- @templates do
    @external_resource Path.join(@templates_path, template)
  end

  @doc false
  def run(_args) do
    context = %{
      app: Phy.Mix.Project.app(),
      module: Phy.Mix.Project.module()
    }

    @templates
    |> Enum.each(fn %{path: path, template: template} ->
      template_path = Path.join(@templates_path, template)
      Generator.from_templates(path, template_path, context)
    end)

    :ok
  end
end
