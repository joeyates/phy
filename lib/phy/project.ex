defmodule Phy.Project do
  @callback config() :: map()
  @callback config(any()) :: map()
  def config(mix_project \\ Mix.Project) do
    mix_project.config()
  end
end
