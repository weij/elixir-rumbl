defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo

  def index(conn, _param) do
    users = Repo.all(Rumbl.User) 
    render conn, "index.html", users: users   
  end
end