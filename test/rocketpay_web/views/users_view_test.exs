defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.User
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      "name" => "nome",
      "email" => "teste1@email.com",
      "age" => 31,
      "password" => "123asd",
      "nickname" => "nick_test1"
    }

    {:ok, %User{} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "user created",
      user: %{
        account: %{
          balance: Decimal.new(0),
          id: user.account.id
        },
        id: user.id,
        name: "nome"
      }
    }

    assert expected_response == response
  end
end
