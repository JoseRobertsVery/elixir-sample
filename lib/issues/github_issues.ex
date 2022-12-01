defmodule Issues.GithubIssues do

    @moduledoc """
    Handle the command line parsing and the dispatch to​
    the various functions that end up generating a​
    table of the last _n_ issues in a github project
    """

    @user_agent [{"User-Agent", "Elixir Issues"}]
    @github_url Application.get_env(:issues, :github_url)

    def fetch(user, project) do
        issues_url(user, project)
        |> HTTPoison.get(@user_agent)
        |> handle_response
    end

    def issues_url(user, project) do
        "#{@github_url}/repos/#{user}/#{project}/issues"
    end

    def handle_response({_, %{status_code: status_code, body: body}}) do
        {
            status_code |> check_for_error(),
            body |> Poison.Parser.parse!()
        }
    end

    # def handle_response({ _, %{ status_code: _, body: body} }) do
    #     {:error, body}
    # end

    defp check_for_error(200), do: :ok
    defp check_for_error(_), do: :error
end