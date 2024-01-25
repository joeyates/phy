defmodule Mix.Tasks.Phy.Gen.LiveView do
  @generate_live_view Application.compile_env(
                          :phy,
                          :generate_live_view,
                          Phy.Generate.LiveView
                        )
  def run([name]) do
    @generate_live_view.run(name)
  end

  def run(_args) do
    raise "Please supply a name for the LiveView"
  end
end
