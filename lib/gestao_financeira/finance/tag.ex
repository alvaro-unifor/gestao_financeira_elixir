defmodule GestaoFinanceira.Finance.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field(:name, :string)
    belongs_to(:user, GestaoFinanceira.Accounts.User)

    many_to_many(:transactions, GestaoFinanceira.Finance.Transaction,
      join_through: "transactions_tags"
    )

    timestamps(type: :utc_datetime)
  end

  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
