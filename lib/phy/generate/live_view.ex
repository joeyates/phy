defmodule Phy.Generate.LiveView do
  require Logger

  @phy_file Application.compile_env(:phy, :file, Phy.File)
  @phy_mix Application.compile_env(:phy, :mix, Phy.Mix)
  @phy_mix_project Application.compile_env(:phy, :mix_project, Phy.Mix.Project)
  @project_root Path.expand("../../..", __DIR__)
  @templates_path Path.join([@project_root, "priv", "templates"])
  for f <- ~w(live_view.ex.eex live_view_test.exs.eex) do
    @external_resource Path.join(@templates_path, f)
  end

  @callback run(String.t()) :: :ok
  def run(name) do
    app = @phy_mix_project.app()
    view_path = Path.join(["lib", "#{app}_web", "live", "#{name}_live.ex"])
    view_directory = Path.dirname(view_path)
    @phy_file.mkdir_p(view_directory)
    @phy_file.write!(view_path, live_view_content(name))
    test_path = Path.join(["test", "#{app}_web", "live", "#{name}_live_test.exs"])
    test_directory = Path.dirname(test_path)
    @phy_file.mkdir_p(test_directory)
    @phy_file.write!(test_path, live_view_test_content(name))
    shell = @phy_mix.shell()
    shell.info(
      """
      Add the following route to your router:

          live "/#{name}", #{live_view_name(name)}, :index
      """
    )
    :ok
  end

  defp live_view_content(name) do
    module = @phy_mix_project.module()
    web_module = @phy_mix_project.web_module()
    live_view_name = live_view_name(name)
    live_view_path = Path.join(@templates_path, "live_view.ex.eex")
    EEx.eval_file(live_view_path, assigns: %{module: module, web_module: web_module, live_view_name: live_view_name})
  end

  defp live_view_test_content(name) do
    module = @phy_mix_project.module()
    web_module = @phy_mix_project.web_module()
    test_name = test_name(name)
    test_path = Path.join(@templates_path, "live_view_test.exs.eex")
    EEx.eval_file(test_path, assigns: %{module: module, web_module: web_module, test_name: test_name})
  end

  defp live_view_name(name) do
    "#{Macro.camelize(name)}Live"
  end

  defp test_name(name) do
    "#{Macro.camelize(name)}LiveTest"
  end
end
