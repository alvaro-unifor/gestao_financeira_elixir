defmodule GestaoFinanceiraWeb.TransactionController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Finance
  alias GestaoFinanceira.Finance.Transaction

  action_fallback(GestaoFinanceiraWeb.FallbackController)

  def index(conn, _params) do
    user_id = conn.assigns.current_user_id
    transactions = Finance.list_transactions_by_user(user_id)
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"tag_ids" => tag_ids} = transaction_params) do
    tags = Finance.get_tags_by_ids(tag_ids)
    params = Map.delete(transaction_params, "tag_ids")

    with {:ok, %Transaction{} = transaction} <-
           Finance.create_transaction_with_tags(params, tags) do
      conn
      |> put_status(:created)
      |> render(:show, transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Finance.get_transaction!(id)
    tag_ids = Map.get(transaction_params, "tag_ids", [])
    tags = Finance.get_tags_by_ids(tag_ids)
    params = Map.delete(transaction_params, "tag_ids")

    with {:ok, %Transaction{} = transaction} <-
           Finance.update_transaction_with_tags(transaction, params, tags) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)

    with {:ok, %Transaction{}} <- Finance.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
