defmodule RetrospectivexWeb.LayoutView do
  use RetrospectivexWeb, :view

  alias RetrospectivexWeb.FranktChannel

  def current_admin_token(conn) do
    Phoenix.Token.sign(
      conn,
      "administrator socket",
      conn.assigns.current_admin.id
    )
  end
end
