defmodule GestaoFinanceiraWeb.TagController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Finance
  alias GestaoFinanceira.Finance.Tag

  action_fallback(GestaoFinanceiraWeb.FallbackController)

  def index(conn, _params) do
    user_id = conn.assigns.current_user_id
    tags = Finance.list_tags_by_user(user_id)
    render(conn, :index, tags: tags)
  end

  def create(conn, tag_params) do
    with {:ok, %Tag{} = tag} <- Finance.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id} = params) do
    tag = Finance.get_tag!(id)
    tag_params = Map.drop(params, ["id"])

    with {:ok, %Tag{} = tag} <- Finance.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)

    with {:ok, %Tag{}} <- Finance.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
