import Config

if config_env() == :test do
  config :phy, :generate_http_client, Phy.Generate.HTTPClientMock
end
