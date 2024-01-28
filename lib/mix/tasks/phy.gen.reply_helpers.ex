defmodule Mix.Tasks.Phy.Gen.ReplyHelpers do
  @moduledoc "Generate reply helpers for the current project"

  use Mix.Task

  @generate_reply_helpers Application.compile_env(
                            :phy,
                            :generate_reply_helpers,
                            Phy.Generate.ReplyHelpers
                          )

  @shortdoc "Creates reply helpers"
  def run(_args) do
    @generate_reply_helpers.run()
  end
end
