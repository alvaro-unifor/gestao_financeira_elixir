defmodule GestaoFinanceira.Repo.Migrations.RemoveTimestampsFromTransactionsTags do
  use Ecto.Migration

  def change do
    alter table(:transactions_tags) do
      remove(:inserted_at)
      remove(:updated_at)
    end
  end
end
