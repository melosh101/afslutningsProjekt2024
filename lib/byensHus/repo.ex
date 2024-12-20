defmodule ByensHus.Repo do
  use Ecto.Repo,
    otp_app: :byensHus,
    adapter: Ecto.Adapters.Postgres
end
