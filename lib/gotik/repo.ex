defmodule Gotik.Repo do
  use Ecto.Repo,
    otp_app: :gotik,
    adapter: Ecto.Adapters.Postgres
end
