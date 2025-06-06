defmodule GestaoFinanceira.Accounts do
  import Ecto.Query, warn: false
  alias GestaoFinanceira.Repo
  alias GestaoFinanceira.Accounts.User
  alias Bcrypt

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    attrs = hash_password(attrs)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp hash_password(%{"password_hash" => password} = attrs) do
    Map.put(attrs, "password_hash", Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(attrs), do: attrs

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
