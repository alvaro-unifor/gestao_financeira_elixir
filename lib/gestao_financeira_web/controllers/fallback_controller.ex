defmodule GestaoFinanceiraWeb.FallbackController do
  use GestaoFinanceiraWeb, :controller

  # Trata erros de validação (changeset)
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: GestaoFinanceiraWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # Trata recursos não encontrados
  def call(conn, :not_found) do
    conn
    |> put_status(:not_found)
    |> put_view(json: GestaoFinanceiraWeb.ErrorJSON)
    |> render(:"404")
  end
end
