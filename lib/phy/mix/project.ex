defmodule Phy.Mix.Project do
  @moduledoc """
  This module wraps access to Mix.Project,
  allowing for easier mocking elsewhere in the project.
  While the rest of the project uses Mox, this wrapper uses
  dependency injection as its testing/mocking approach.
  """
  @callback config() :: map()
  @callback config(mix_project :: Mix.Project) :: map()
  def config(mix_project \\ Mix.Project) do
    mix_project.config()
  end

  @callback app() :: atom()
  @callback app(mix_project :: Mix.Project) :: atom()
  def app(mix_project \\ Mix.Project) do
    Keyword.fetch!(config(mix_project), :app)
  end

  @callback module() :: String.t()
  @callback module(mix_project :: Mix.Project) :: String.t()
  def module(mix_project \\ Mix.Project) do
    app(mix_project)
    |> Atom.to_string()
    |> Macro.camelize()
  end

  @callback web_module() :: String.t()
  @callback web_module(mix_project :: Mix.Project) :: String.t()
  def web_module(mix_project \\ Mix.Project) do
    app(mix_project)
    |> then(&"#{&1}_web")
    |> Macro.camelize()
  end
end
