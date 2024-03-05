defmodule Mix.Tasks.Phy.Gen.HTTPClient do
  @moduledoc "Generate an HTTP client module and accompanying tests"

  use Mix.Task

  use Phy.Generator,
    templates: [
    %{path: "lib/<%= @ app %>/http_client.ex", template: "http_client.ex.eex"},
    %{path: "test/<%= @ app %>/http_client_test.exs", template: "http_client_test.exs.eex"}
  ]

  @doc false
  def run(_args) do
    context = %{
      app: Phy.Mix.Project.app(),
      module: Phy.Mix.Project.module()
    }

    generate(context)
  end
end
