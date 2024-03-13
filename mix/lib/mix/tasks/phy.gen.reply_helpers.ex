defmodule Mix.Tasks.Phy.Gen.ReplyHelpers do
  @moduledoc "Generate reply helpers for the current project"

  use Mix.Task

  use Phy.Generator,
    templates: [
      %{path: "lib/<%= @ app %>_web/reply_helpers.ex", template: "reply_helpers.ex.eex"},
      %{
        path: "test/<%= @ app %>_web/reply_helpers_test.exs",
        template: "reply_helpers_test.exs.eex"
      }
    ]

  @shortdoc "Creates reply helpers"
  def run(_args) do
    context = %{
      app: Phy.Mix.Project.app(),
      web_module: Phy.Mix.Project.web_module()
    }

    generate(context)
  end
end
