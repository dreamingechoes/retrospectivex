defmodule RetrospectivexWeb.Router do
  use RetrospectivexWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :browser_auth do
    plug(RetrospectivexWeb.Guardian.AuthPipeline)
    plug(RetrospectivexWeb.Plug.CurrentAdmin)
  end

  pipeline :browser_ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(RetrospectivexWeb.Plug.CurrentAdmin)
  end

  pipeline :admin_layout do
    plug(:put_layout, {RetrospectivexWeb.Admin.LayoutView, :admin})
  end

  scope "/", RetrospectivexWeb do
    # Admin scope
    scope "/admin", Admin, as: :admin do
      pipe_through([
        :browser,
        :browser_auth,
        :browser_ensure_auth,
        :admin_layout
      ])

      resources("/", DashboardController, only: [:index])
      resources("/administrators", AdministratorController)
      resources("/boards", BoardController)
      resources("/pages", PageController)
    end

    # Application unauthenticated scope
    scope "/" do
      pipe_through([:browser, :browser_auth])

      resources("/session", SessionController, only: [:new, :create])

      # Log out resource
      get("/logout", SessionController, :delete)

      resources(
        "/boards",
        BoardController,
        only: [:new, :create, :show],
        param: "slug"
      )

      resources("/cards", CardController)
      resources("/", PageController, only: [:index, :show], param: "slug")
    end
  end
end
