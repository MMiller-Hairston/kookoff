defmodule Kookoff.Repo do
  use Ecto.Repo,
    otp_app: :kookoff,
    adapter: Ecto.Adapters.Postgres
end
