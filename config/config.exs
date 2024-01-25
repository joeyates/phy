import Config

if config_env() == :test do
  config :phy,
    file: Phy.FileMock,
    generate_http_client: Phy.Generate.HTTPClientMock,
    generate_live_view: Phy.Generate.LiveViewMock,
    mix_project: Phy.Mix.ProjectMock
end
