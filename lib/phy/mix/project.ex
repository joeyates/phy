defmodule Phy.Mix.Project do
  @callback config() :: map()
  @callback config(any()) :: map()
  def config(mix_project \\ Mix.Project) do
    mix_project.config()
  end

  @callback app() :: atom()
  def app do
    config()[:app]
  end

  @callback module() :: atom()
  def module do
    app()
    |> Atom.to_string()
    |> Macro.camelize()
  end

  @callback web_module() :: atom()
  def web_module do
    app()
    |> tap(&"#{&1}_web")
    |> Macro.camelize()
  end
end
