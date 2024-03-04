import Config

if config_env() == :test do
  config :phy,
    file: Phy.FileMock,
    generate_reply_helpers: Phy.Generate.ReplyHelpersMock,
    mix: Phy.MixMock,
    mix_project: Phy.Mix.ProjectMock
end
