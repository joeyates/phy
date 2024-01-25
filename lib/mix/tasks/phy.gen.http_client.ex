defmodule Mix.Tasks.Phy.Gen.HTTPClient do
  @generate_http_client Application.compile_env(
                          :phy,
                          :generate_http_client,
                          Phy.Generate.HTTPClient
                        )
  def run(args) do
    @generate_http_client.run(args)
  end
end
