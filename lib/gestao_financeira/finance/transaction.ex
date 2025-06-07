defmodule GestaoFinanceira.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field(:description, :string)
    field(:amount, :decimal)
    field(:type, :string)
    field(:date, :utc_datetime)
    belongs_to(:user, GestaoFinanceira.Accounts.User)

    many_to_many :tags, GestaoFinanceira.Finance.Tag, join_through: "transactions_tags", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:description, :amount, :type, :date, :user_id])
    |> validate_required([:description, :amount, :type, :date, :user_id])
    |> validate_inclusion(:type, ["RECEITA", "DESPESA"])
  end
end
