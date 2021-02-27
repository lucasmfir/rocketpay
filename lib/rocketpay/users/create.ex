defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo, User}

  def call(params) do
    # params
    # |> User.changeset()
    # |> Repo.insert()

    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(user.id, repo)
    end)
    |> run_transaction
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: 0}

    Account.changeset(params)
  end

  defp insert_account(user_id, repo) do
    user_id
    |> account_changeset()
    |> repo.insert()
  end

  defp run_transaction(transaction) do
    case Repo.transaction(transaction) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{create_user: user}} ->
        user_with_account = Repo.preload(user, :account)
        {:ok, user_with_account}
    end
  end
end

# params = %{name: "nome", email: "teste@email.com", age: 31, password: "123asd", nickname: "nick_test"}
