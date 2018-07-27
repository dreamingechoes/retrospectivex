defmodule RetrospectivexWeb.FranktChannel do
  use RetrospectivexWeb, :channel
  use Frankt

  def join("frankt:" <> _administrator_hash, _params, socket), do: {:ok, socket}

  def handlers do
    %{}
  end

  def topic_name(administrator_id) do
    client_hash =
      :md5
      |> :crypto.hash("#{administrator_id}")
      |> Base.encode16()

    "frankt:#{client_hash}"
  end
end
