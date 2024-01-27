defmodule Phy.Generate.HTTPClient do
  @phy_file Application.compile_env(:phy, :file, Phy.File)
  @phy_mix_project Application.compile_env(:phy, :mix_project, Phy.Mix.Project)
  @project_root Path.expand("../../..", __DIR__)
  @templates_path Path.join([@project_root, "priv", "templates"])
  for f <- ~w(http_client.ex.eex http_client_test.exs.eex) do
    @external_resource Path.join(@templates_path, f)
  end

  @callback run() :: :ok
  def run do
    app = @phy_mix_project.app()
    client_path = Path.join(["lib", "#{app}", "http_client.ex"])
    @phy_file.write!(client_path, client_content())
    test_path = Path.join(["test", "#{app}", "http_client_test.exs"])
    @phy_file.write!(test_path, test_content())
    :ok
  end

  defp client_content do
    module = @phy_mix_project.module()
    client_path = Path.join(@templates_path, "http_client.ex.eex")
    EEx.eval_file(client_path, assigns: %{module: module})
  end

  def test_content do
    module = @phy_mix_project.module()
    test_path = Path.join(@templates_path, "http_client_test.exs.eex")
    EEx.eval_file(test_path, assigns: %{module: module})
  end
end
