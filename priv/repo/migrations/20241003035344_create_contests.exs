defmodule Kookoff.Repo.Migrations.CreateContests do
  use Ecto.Migration

  def change do
    create table(:contests, primary_key: false) do
      add :id, :binary_id, primary_key: true, null: false
      add :title, :string
      add :description, :text
      add :state, :string
      add :start_time, :utc_datetime
      add :image_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
