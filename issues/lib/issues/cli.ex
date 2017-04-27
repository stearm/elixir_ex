defmodule Issues.CLI do

  @default_count 4
  @id "#"
  @created_at "created_at"
  @title "title"

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generationg a
  table of the last _n_ issues in a github project
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Othervise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
      aliases: [ h: :help ])

      case parse do
        { [ help: true ], _, _ } -> :help
        { _, [ user, project, count], _ } -> { user, project, String.to_integer count }
        { _, [ user, project ], _ } -> { user, project, @default_count }
        _ -> :help
      end
   end

   def process(:help) do
     IO.puts """
     usage: issues <user> <project> <count> [ count | #{@default_count} ]
     """
     System.halt(0)
   end

   def process({user, project, count}) do
     Issues.GithubIssues.fetch(user, project)
     |> decode_response
     |> convert_to_list_of_maps
     |> sort_into_ascending_order
     |> Enum.take(count)
     |> filter_fields
     |> print_header
     |> print_issues
   end

   def decode_response({:ok, body}), do: body
   def decode_response({:error, error}) do
     {_, message} = List.keyfind(error, "message", 0)
     IO.puts "Error fetching from github: #{message}"
     System.halt(2)
   end

   def convert_to_list_of_maps(list) do
     list
     |> Enum.map(&Enum.into(&1, Map.new))
   end

   def sort_into_ascending_order(list_of_issues) do
     Enum.sort list_of_issues, fn i1, i2 -> i1["createdAt"] <= i2["createdAt"] end
   end

   def filter_fields(list_of_issues) do
     result = for issue <- list_of_issues, do: %{id: issue["id"], created_at: issue["created_at"], title: issue["title"]}
     result
   end

   def print_issues(list_of_issues) do
     for issue <- list_of_issues, do: IO.puts("#{issue.id}| #{issue.created_at}| #{issue.title}")
   end

   def print_header(list_of_issues) do
      list_of_issues
      |> get_header_length
      #|> (fn lengths -> IO.puts "#{String.pad_leading("", lengths["id"], "-")}+
      #                  #{String.pad_leading("", lengths["created_at"], "-")}+
      #                  #{String.pad_leading("", lengths["title"], "-")}"
      #                  end).()
      #list_of_issue
   end

   def get_header_length(list_of_issues) do
     lengths = %{
        id: Enum.max_by(list_of_issues, fn issue -> Map.get(issue, :id) |> Integer.to_string |> String.length end) |> Map.get(:id) |> String.length,
        created_at: Enum.max_by(list_of_issues, fn issue -> Map.get(issue, :created_at) |> String.length end) |> Map.get(:created_at) |> String.length,
        title: Enum.max_by(list_of_issues, fn issue -> Map.get(issue, :title) |> String.length end) |> Map.get(:title) |> String.length
     }
     IO.puts " #{@id}#{Map.get(lengths,:id) - String.length(@id)}"
   end

 end