defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def index(conn, _param) do
    case authenticate(conn) do
      %Plug.Conn{halted: true} ->
        conn
      _ ->
        users = Repo.all(User) 
        render conn, "index.html", users: users 
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} -> 
        conn
          |> put_flash(:info, "#{user.name} created!")
          |> redirect(to: user_path(conn, :index))
      {:error, changeset} -> 
        render(conn, "new.html", changeset: changeset)        
    end
  end

  defp authenticate(conn) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end