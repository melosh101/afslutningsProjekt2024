defmodule ByensHus.Repo do
  use Ecto.Repo,
    otp_app: :byens_hus,
    adapter: Ecto.Adapters.Postgres
end
