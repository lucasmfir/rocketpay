defmodule Rocketpay.Accounts.Withdraw do
  alias Rocketpay.Repo
  alias Rocketpay.Accounts.Operation

  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(transaction) do
    case Repo.transaction(transaction) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{withdraw: account}} ->
        {:ok, account}
    end
  end
end
