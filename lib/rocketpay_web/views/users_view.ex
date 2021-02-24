defmodule RocketpayWeb.UsersView do

  def render("create.json", %{user: user}) do
    %{
      message: "user created",
      user: %{
        id: user.id,
        name: user.name
      }
    }
  end
end
