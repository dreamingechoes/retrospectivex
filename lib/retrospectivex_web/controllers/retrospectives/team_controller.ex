defmodule RetrospectivexWeb.Retrospectives.TeamController do
  use RetrospectivexWeb, :controller

  alias Retrospectivex.Retrospectives
  alias Retrospectivex.Retrospectives.Schemas.Team

  def new(conn, _params) do
    changeset = Retrospectives.change_team(%Team{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn = %{assigns: %{current_user: current_user}}, %{
        "team" => team_params
      }) do
    team_params = Map.put(team_params, "user_id", current_user.id)

    case Retrospectives.create_team(team_params) do
      {:ok, _team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    team = Retrospectives.get_team!(id)
    changeset = Retrospectives.change_team(team)
    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Retrospectives.get_team!(id)

    case Retrospectives.update_team(team, team_params) do
      {:ok, _team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Retrospectives.get_team!(id)
    {:ok, _team} = Retrospectives.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: dashboard_path(conn, :index))
  end
end
