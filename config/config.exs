import Config

# import_config "#{Mix.env}.exs"

config :issues,
  github_url: "https://api.github.com",
  github_token: System.get_env("GITHUB_TOKEN")

config :logger,
  compile_time_purge_level: :info