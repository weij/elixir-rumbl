defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join("videos:" <> video_id, _params, socket) do
    case Integer.parse(video_id) do
      {int, _} -> {:ok, assign(socket, :video_id, int)}
      _ -> {:error}
    end
  end

  def handle_in("new_annotation", params, socket) do
    user = socket.assigns.current_user

    changeset =
    user
    |> build_assoc(:annotations, video_id: socket.assigns.video_id)
    |> Rumbl.Annotation.changeset(params)

    case Repo.insert(changeset) do
      {:ok, annotation} ->
        broadcast! socket, "new_annotation", %{
          user: Rumbl.UserView.render("user.json", %{user: user}),
          body: annotation.body,
          at: annotation.at
        }
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}  
    end
  end  
end