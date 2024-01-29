defmodule Mix.Tasks.Phy.Gen.HttpClient do
  @moduledoc "Generate an HTTP client module and accompanying tests"

  use Mix.Task

  @generate_http_client Application.compile_env(
                          :phy,
                          :generate_http_client,
                          Phy.Generate.HTTPClient
                        )

  @shortdoc "Creates a mockable HTTP client"
  def run(_args) do
    @generate_http_client.run()
  end
end
