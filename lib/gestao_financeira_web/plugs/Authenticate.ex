defmodule GestaoFinanceiraWeb.Plugs.Authenticate do
  import Plug.Conn
  alias GestaoFinanceiraWeb.Auth.JWT

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, claims} <- JWT.verify_and_validate(token, JWT.signer()),
         user_id when is_integer(user_id) <- claims["user_id"] do
      assign(conn, :current_user_id, user_id)
    else
      _ ->
        conn
        |> send_resp(:unauthorized, "Unauthorized")
        |> halt()
    end
  end
end
