defmodule Issues.GithubIssues do
  @moduledoc """
  Handle the command line parsing and the dispatch to​
  the various functions that end up generating a​
  table of the last _n_ issues in a github project
  """

  require Logger

  @user_agent [{"User-Agent", "Elixir Issues"}]
  @github_url Application.compile_env(:issues, :github_url, :error)

  def fetch(user, project) do
    Logger.info("Fetching issues for #{user}/#{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Response status code: #{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
