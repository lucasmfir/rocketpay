defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.User

  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        "name" => "nome",
        "email" => "teste1@email.com",
        "age" => 31,
        "password" => "123asd",
        "nickname" => "nick_test1"
      }

      {:ok, %User{account: account}} = Rocketpay.create_user(user_params)

      conn = put_req_header(conn, "authorization", "Basic cm9ja2V0cGF5OjEyMzQ=")

      {:ok, conn: conn, account_id: account.id}
    end

    test "when params valid, make depoist", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
               "account" => %{
                 "balance" => "50.00",
                 "id" => _id
               },
               "message" => "balance changed successfully"
             } = response
    end

    test "when params are invalid returns error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "invalid value"} = response
    end
  end
end
