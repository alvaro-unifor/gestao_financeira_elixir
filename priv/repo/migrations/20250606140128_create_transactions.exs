defmodule GestaoFinanceira.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :description, :string, null: false
      add :amount, :decimal, null: false
      add :type, :string, null: false
      add :date, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:transactions, [:user_id])
  end
end
