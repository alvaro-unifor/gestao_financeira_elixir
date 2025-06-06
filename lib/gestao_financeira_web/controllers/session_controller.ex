defmodule GestaoFinanceiraWeb.SessionController do
  use GestaoFinanceiraWeb, :controller
  alias GestaoFinanceira.Accounts.Auth
  alias GestaoFinanceiraWeb.Auth.JWT

  def create(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        signer = JWT.signer()
        {:ok, token, _claims} = JWT.generate_and_sign(%{"user_id" => user.id}, signer)
        json(conn, %{token: token, user_id: user.id})

      :error ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end
end
