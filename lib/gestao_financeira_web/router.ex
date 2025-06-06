defmodule GestaoFinanceiraWeb.Router do
  use GestaoFinanceiraWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(GestaoFinanceiraWeb.Plugs.Authenticate)
  end

  scope "/api", GestaoFinanceiraWeb do
    pipe_through(:api)

    post("/users", UserController, :create)
    post("/login", SessionController, :create)
  end

  scope "/api", GestaoFinanceiraWeb do
    pipe_through([:api, :auth])

    get("/tags/transactions_by_tag", TagController, :transactions_by_tag)
    resources("/tags", TagController, except: [:new, :edit])
    resources("/users", UserController, except: [:new, :edit])
    resources("/transactions", TransactionController, except: [:new, :edit])
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:gestao_financeira, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: GestaoFinanceiraWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
