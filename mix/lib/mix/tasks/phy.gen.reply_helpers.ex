defmodule Mix.Tasks.Phy.Gen.ReplyHelpers do
  @moduledoc "Generate reply helpers for the current project"

  use Mix.Task

  alias Phy.Generator

  @project_root Path.expand("../../..", __DIR__)
  @templates_path Path.join([@project_root, "priv", "templates"])
  @templates [
    %{path: "lib/<%= @ app %>_web/reply_helpers.ex", template: "reply_helpers.ex.eex"},
    %{
      path: "test/<%= @ app %>_web/reply_helpers_test.exs",
      template: "reply_helpers_test.exs.eex"
    }
  ]
  for %{template: template} <- @templates do
    @external_resource Path.join(@templates_path, template)
  end

  @shortdoc "Creates reply helpers"
  def run(_args) do
    context = %{
      app: Phy.Mix.Project.app(),
      web_module: Phy.Mix.Project.web_module()
    }

    @templates
    |> Enum.each(fn %{path: path, template: template} ->
      template_path = Path.join(@templates_path, template)
      Generator.from_templates(path, template_path, context)
    end)
  end
end
