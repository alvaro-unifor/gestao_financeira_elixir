defmodule GestaoFinanceiraWeb.TransactionJSON do
  def index(%{transactions: transactions}) do
    Enum.map(transactions, &transaction_json/1)
  end

  def show(%{transaction: transaction}) do
    transaction_json(transaction)
  end

  defp transaction_json(transaction) do
    %{
      id: transaction.id,
      description: transaction.description,
      amount: transaction.amount,
      type: transaction.type,
      date: transaction.date,
      user_id: transaction.user_id,
      inserted_at: transaction.inserted_at,
      updated_at: transaction.updated_at
    }
  end
end
