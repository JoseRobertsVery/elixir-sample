defmodule CliTest do

    @moduledoc """
    Handle the command line parsing and the dispatch to​
    the various functions that end up generating a​
    table of the last _n_ issues in a github project
    """

    use ExUnit.Case
    doctest Issues

    import Issues.CLI, only: [parse_args: 1,
                              sort_into_descending_order: 1]

    test ":help returned by option pasing with -h and --help options" do
        assert parse_args(["-h", "anything"]) == :help
        assert parse_args(["--help", "anything"]) == :help
    end

    test "three values returned if three given" do
        assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
    end

    test "default count used if only two values given" do
        assert parse_args(["user", "project"]) == {"user", "project", 4}
    end

    test "sort descending order " do
        result = sort_into_descending_order(fake_created_at_list(["c", "b", "a"]))
        issues = for issue <- result, do: Map.get(issue, "created_at")
        assert issues == ~w{ c b a}
    end

    defp fake_created_at_list(values) do
        for value <- values, 
        do: %{"created_at" => value, "other_data" => "xxx"}
    end
end
