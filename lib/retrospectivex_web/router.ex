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
    plug(RetrospectivexWeb.Plug.CurrentUser)
  end

  pipeline :browser_ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
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

      # OAuth resources
      scope "/oauth", OAuth, as: :oauth do
        delete("/", AuthController, :delete)
        get("/:provider", AuthController, :index)
        get("/:provider/callback", AuthController, :callback)
      end

      # Admin login resources
      get("/logout", SessionController, :delete)
      resources("/session", SessionController, only: [:new, :create])

      # Dashboard resources
      get("/dashboard", DashboardController, :index)

      # Retrospectives context resources
      resources("/boards", Retrospectives.BoardController, only: [:new, :create])

      resources("/for", Retrospectives.BoardController,
        only: [:show],
        param: "slug"
      )

      # Contents context resources
      resources("/", Contents.PageController,
        only: [:index, :show],
        param: "slug"
      )
    end
  end
end
