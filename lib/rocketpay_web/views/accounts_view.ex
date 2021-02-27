defmodule RocketpayWeb.AccountsView do
  def render("update.json", %{account: account}) do
    %{
      message: "balance changed successfully",
      account: %{
        id: account.id,
        balance: account.balance
      }
    }
  end

  def render("transaction.json", %{
        transaction: %{from_account: from_account, to_account: to_account}
      }) do
    %{
      message: "transaction done successfully",
      transaction: %{
        from_account: %{
          account_id: from_account.id,
          balance: from_account.balance
        },
        to_account: %{
          account_id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
