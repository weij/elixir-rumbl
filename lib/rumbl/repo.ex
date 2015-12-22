defmodule Rumbl.Repo do
  # use Ecto.Repo, otp_app: :rumbl
  
  @moudledoc """
  In memonry repository 
  separate data concerns from database concerns
  """

  def all(Rumbl.User) do
    [%Rumbl.User{id: "1", name: "Jose", username: "josevalim", password: "elixir"},
     %Rumbl.User{id: "2", name: "Weijun", username: "yinweijun", password: "jane"},
     %Rumbl.User{id: "3", name: "Bruce", username: "redrapids", password: "71angs"},
     %Rumbl.User{id: "4", name: "Chris", username: "chrismccord", password: "phx"}]
  end

  def all(_other) do
    []
  end

  def get(module, id) do
    Enum.find all(module), fn item -> 
      item.id == id
    end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key,val} -> Map.get(map, key) == val end)
    end
  end
end
