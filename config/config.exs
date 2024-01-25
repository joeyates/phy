import Config

if config_env() == :test do
  config :phy,
    generate_http_client: Phy.Generate.HTTPClientMock,
    generate_live_view: Phy.Generate.LiveViewMock
end
