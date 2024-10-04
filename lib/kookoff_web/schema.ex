defmodule KookoffWeb.Schema do
  alias KookoffWeb.Resolvers
  use Absinthe.Schema

  import_types(Absinthe.Plug.Types)
  import_types(Absinthe.Type.Custom)
  import_types(KookoffWeb.Schema.ContestTypes)

  query do
    @desc "Get all contests"
    field :contests, list_of(:contest) do
      resolve(&Resolvers.Contest.list_contests/3)
    end
  end

  mutation do
    # $ curl -X POST -F query='mutation { createContest(contest: "users_csv", metadata: "metadata_json") }' -F users_csv=@users.csv -F metadata_json=@metadata.json localhost:4000/graphql
    @desc "Create a contest"
    field :create_contest, :contest do
      arg(:contest, non_null(:contest_input))

      resolve(&Resolvers.Contest.create_contest/3)
    end
  end
end

# mutation { createContest(contest: { title: "First Try", description: "", startTime: "2024-10-05T00:00:00.000Z", image: "image" }) { id title description startTime imageUrl }}
