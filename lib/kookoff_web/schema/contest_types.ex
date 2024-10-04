defmodule KookoffWeb.Schema.ContestTypes do
  use Absinthe.Schema.Notation

  object :contest do
    field :id, non_null(:id)
    field :state, non_null(:string)
    field :title, non_null(:string)
    field :description, :string
    field :start_time, non_null(:datetime)
    field :image_url, :string
  end

  input_object :contest_input do
    field :title, non_null(:string)
    field :description, :string
    field :start_time, non_null(:datetime)
    field :image, :upload
  end
end
