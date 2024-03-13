defmodule Mix.Tasks.Phy.Gen.LiveView do
  @moduledoc "Generate a Phoenix LiveView module"

  use Mix.Task

  use Phy.Generator,
    templates: [
      %{path: "lib/<%= @ app %>_web/live/<%= @name %>_live.ex", template: "live_view.ex.eex"},
      %{
        path: "test/<%= @ app %>_web/live/<%= @name %>_live_test.exs",
        template: "live_view_test.exs.eex"
      }
    ]

  @shortdoc "Creates a new Phoenix LiveView module"
  def run([name]) do
    context = %{
      app: Phy.Mix.Project.app(),
      live_view_module: live_view_module(name),
      web_module: Phy.Mix.Project.web_module(),
      name: name
    }

    generate(context)

    Mix.shell().info("""
    Add the following route to your router:

        live "/#{name}", #{live_view_module(name)}, :index
    """)

    :ok
  end

  def run(_args) do
    raise "Please supply a name for the LiveView"
  end

  defp live_view_module(name) do
    "#{Macro.camelize(name)}Live"
  end
end
