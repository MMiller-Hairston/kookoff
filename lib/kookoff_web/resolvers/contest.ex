defmodule KookoffWeb.Resolvers.Contest do
  require Logger

  alias Kookoff.Contests

  def list_contests(_parent, _args, _resolution) do
    {:ok, Contests.list_contests()}
  end

  def create_contest(_parent, args, _resolution) do
    Logger.info("Inserting new contest: #{inspect(args)}")

    Contests.create_contest(%{
      state: "Pending",
      description: args.contest.description,
      title: args.contest.title,
      start_time: args.contest.start_time,
      image_url: ""
    })
  end
end
