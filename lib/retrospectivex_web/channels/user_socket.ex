defmodule RetrospectivexWeb.UserSocket do
  use Phoenix.Socket

  alias Retrospectivex.Accounts
  alias Retrospectivex.Accounts.Schemas.Administrator

  # Two weeks in seconds
  @max_age 1_209_600

  ## Channels
  channel("frankt:*", RetrospectivexWeb.FranktChannel)

  ## Transports
  transport(:websocket, Phoenix.Transports.WebSocket)
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"administrator_token" => administrator_token}, socket) do
    with {:ok, administrator_id} <-
           Phoenix.Token.verify(
             socket,
             "administrator socket",
             administrator_token,
             max_age: @max_age
           ),
         %Administrator{} = current_administrator <-
           Accounts.get_administrator!(administrator_id) do
      socket =
        socket
        |> assign(:current_admin, current_administrator)
        |> assign(:conn, %Plug.Conn{})

      {:ok, assign(socket, :conn, %Plug.Conn{assigns: socket.assigns})}
    else
      _ -> :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     RetrospectivexWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
