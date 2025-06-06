defmodule GestaoFinanceira.Repo do
  use Ecto.Repo,
    otp_app: :gestao_financeira,
    adapter: Ecto.Adapters.Postgres
end
