defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def index(conn, _param) do
    users = Repo.all(User) 
    render conn, "index.html", users: users   
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end
end