defmodule GestaoFinanceira.Accounts.Auth do
  alias GestaoFinanceira.Accounts

  alias Bcrypt

  def authenticate_user(email, password) do
    user = Accounts.get_user_by_email(email)

    cond do
      user && Bcrypt.verify_pass(password, user.password_hash) ->
        {:ok, user}

      true ->
        :error
    end
  end
end
