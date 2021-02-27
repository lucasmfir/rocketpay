defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  alias Rocketpay.Transactions.Response, as: TransactionResponse

  def deposit(conn, params) do
    with {:ok, account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, account} <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    # task = Task.async(fn -> Rocketpay.transaction(params) end)

    # with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

  # def transaction(conn, params) do
  #   task = Task.start(fn -> Rocketpay.transaction(params) end)

  #   conn
  #   |> put_status(:no_content)
  #   |> text("")
  # end
end
