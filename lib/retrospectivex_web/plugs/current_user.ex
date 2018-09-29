defmodule RetrospectivexWeb.Plug.CurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
