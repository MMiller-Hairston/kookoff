defmodule KookoffWeb.Resolvers.Contest do
  alias Kookoff.Contests

  def list_contests(_parent, _args, _resolution) do
    {:ok, Contests.list_contests()}
  end
end
