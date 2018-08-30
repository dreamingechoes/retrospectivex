defmodule Retrospectivex.Retrospectives.Queries.Card do
  import Ecto.Query, warn: false

  alias Retrospectivex.Retrospectives.Schemas.Card

  def default_order, do: from(c in Card, order_by: [asc: :inserted_at])

  def filter(nil), do: from(c in Card)

  def filter(filters) do
    Card
    |> filter_by_board(filters["board_id"])
    |> filter_by_string(filters["query"])
    |> order_cards_by(filters["order_by"])
  end

  defp filter_by_board(query, nil), do: query

  defp filter_by_board(query, board_id),
    do: from(c in query, where: c.board_id == ^board_id)

  defp filter_by_string(query, nil), do: query

  defp filter_by_string(query, string) do
    from(c in query,
      where: ilike(c.title, ^"%#{sanitize(string)}%"),
      or_where: ilike(c.body, ^"%#{sanitize(string)}%")
    )
  end

  defp order_cards_by(query, nil),
    do: from(c in query, order_by: [asc: :inserted_at])

  defp order_cards_by(query, field),
    do: from(c in query, order_by: [desc: ^:"#{field}", desc: :id])

  defp sanitize(string) do
    string
    |> String.replace(~r/\s+/, " ")
    |> String.trim()
  end
end
