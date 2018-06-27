defmodule Retrospectivex.Accounts.Queries.Administrator do
  import Ecto.Query, warn: false

  alias Retrospectivex.Accounts.Schemas.Administrator

  def by_email(email) do
    from(a in Administrator, where: a.email == ^email)
  end
end
