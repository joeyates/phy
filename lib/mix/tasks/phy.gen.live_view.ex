defmodule Mix.Tasks.Phy.Gen.LiveView do
  @generate_live_view Application.compile_env(
                          :phy,
                          :generate_live_view,
                          Phy.Generate.LiveView
                        )
  def run(args) do
    @generate_live_view.run(args)
  end
end
