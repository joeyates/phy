defmodule Phy.Generate.ReplyHelpers do
  @phy_file Application.compile_env(:phy, :file, Phy.File)
  @phy_mix_project Application.compile_env(:phy, :mix_project, Phy.Mix.Project)
  @project_root Path.expand("../../..", __DIR__)
  @templates_path Path.join([@project_root, "priv", "templates"])
  for f <- ~w(reply_helpers.ex.eex reply_helpers_test.exs.eex) do
    @external_resource Path.join(@templates_path, f)
  end

  @callback run() :: :ok
  def run do
    app = @phy_mix_project.app()
    client_path = Path.join(["lib", "#{app}_web", "reply_helpers.ex"])
    @phy_file.write!(client_path, lib_content())
    test_path = Path.join(["test", "#{app}_web", "reply_helpers_test.exs"])
    @phy_file.write!(test_path, test_content())
    :ok
  end

  defp lib_content do
    web_module = @phy_mix_project.web_module()
    client_path = Path.join(@templates_path, "reply_helpers.ex.eex")
    EEx.eval_file(client_path, assigns: %{web_module: web_module})
  end

  def test_content do
    module = @phy_mix_project.module()
    web_module = @phy_mix_project.web_module()
    test_path = Path.join(@templates_path, "reply_helpers_test.exs.eex")
    EEx.eval_file(test_path, assigns: %{module: module, web_module: web_module})
  end
end
