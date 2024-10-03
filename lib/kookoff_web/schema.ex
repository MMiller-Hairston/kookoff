defmodule KookoffWeb.Schema do
  alias KookoffWeb.Resolvers
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(KookoffWeb.Schema.ContestTypes)

  query do
    @desc "Get all contests"
    field :contests, list_of(:contest) do
      resolve(&Resolvers.Contest.list_contests/3)
    end
  end
end
