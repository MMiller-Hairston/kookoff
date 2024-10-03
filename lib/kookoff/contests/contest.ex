defmodule Kookoff.Contests.Contest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "contests" do
    field :state, :string
    field :description, :string
    field :title, :string
    field :start_time, :utc_datetime
    field :image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contest, attrs) do
    contest
    |> cast(attrs, [:title, :description, :state, :start_time, :image_url])
    |> validate_required([:title, :state, :start_time])
  end
end
