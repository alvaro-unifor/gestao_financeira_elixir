defmodule GestaoFinanceiraWeb.UserJSON do
  def index(%{users: users}) do
    %{data: Enum.map(users, &user_json/1)}
  end

  def show(%{user: user}) do
    user_json(user)
  end

  defp user_json(user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
