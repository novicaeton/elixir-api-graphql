defmodule MojApi.Repo do
  use Ecto.Repo,
    otp_app: :moj_api,
    adapter: Ecto.Adapters.Postgres
end
