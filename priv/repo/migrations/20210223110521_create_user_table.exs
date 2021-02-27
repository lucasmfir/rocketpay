defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    # create table :users, primary_key: false  do
    #   add(:id, :bigserial, primary_key: true)
    create table(:users) do
      add(:name, :string)
      add(:age, :integer)
      add(:email, :string)
      add(:password_hash, :string)
      add(:nickname, :string)

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end

  # def change -> alteracao ja preparada para rollback
  # def up -> alteracao apenas
  # def down -> rollback
end
