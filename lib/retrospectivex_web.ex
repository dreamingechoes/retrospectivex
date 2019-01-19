defmodule RetrospectivexWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use RetrospectivexWeb, :controller
      use RetrospectivexWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: RetrospectivexWeb
      import Plug.Conn
      import RetrospectivexWeb.Gettext

      alias RetrospectivexWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/retrospectivex_web/templates",
        namespace: RetrospectivexWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import RetrospectivexWeb.ErrorHelpers
      import RetrospectivexWeb.Gettext

      alias RetrospectivexWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import RetrospectivexWeb.Gettext
    end
  end

  def frankt do
    quote do
      import Ecto
      import Ecto.Query
      import Phoenix.Channel
      import Phoenix.HTML, only: [safe_to_string: 1]
      import Phoenix.HTML.FormData, only: [to_form: 2]
      import RetrospectivexWeb.Frankt

      alias Phoenix.View
      alias Retrospectivex.Repo
      alias RetrospectivexWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
