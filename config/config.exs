use Mix.Config

# import_config "#{Mix.env}.exs"

config :issues,
  github_url: "https://api.github.com/repos",
  github_token: System.get_env("GITHUB_TOKEN")