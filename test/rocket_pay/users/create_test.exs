defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when params are valid returns user" do
      params = %{
        "name" => "nome",
        "email" => "teste1@email.com",
        "age" => 31,
        "password" => "123asd",
        "nickname" => "nick_test1"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "nome", id: ^user_id} = user
    end

    test "when there are invalid params returns user" do
      params = %{
        "name" => "nome",
        "email" => "teste1@email.com",
        "age" => 12,
        "nickname" => "nick_test1"
      }

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      {:error, changeset} = Create.call(params)

      assert expected_response == errors_on(changeset)
    end
  end
end
