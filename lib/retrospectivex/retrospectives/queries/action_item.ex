defmodule Retrospectivex.Retrospectives.Queries.ActionItem do
  import Ecto.Query, warn: false

  def by_board(query, board) do
    from(a in query,
      join: c in assoc(a, :card),
      join: b in assoc(c, :board),
      where: b.id == ^board.id,
      order_by: [asc: :inserted_at]
    )
  end
end
