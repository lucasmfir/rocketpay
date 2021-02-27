defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Transactions.Response, as: TransactionResponse

  def call(params) do
    withdraw_params = build_params(params["from_id"], params["value"])
    deposit_params = build_params(params["to_id"], params["value"])

    IO.puts("# transaction #")

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(transaction) do
    case Repo.transaction(transaction) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, result} ->
        {:ok, TransactionResponse.build(result.withdraw, result.deposit)}
    end
  end
end
