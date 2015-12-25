defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo

  def new(conn, _) do
    render conn, "new.html"   
  end

  def create(conn, %{"session" => %{"password" => pass, "username" => username}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, username, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "invalid username/password combination")
        |> render "new.html"  
    end
  end

  # def create(conn, _) do
  #   conn
  #   |> put_flash(:error, "invalid username/password combination")
  #   |> render "new.html"
  # end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout
    |> put_flash(:info, "you're successfully logout")
    |> redirect(to: page_path(conn, :index))
  end
end