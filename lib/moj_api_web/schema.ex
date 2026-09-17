defmodule MojApiWeb.Schema do
  use Absinthe.Schema

  alias MojApi.Accounts

  # Definisanje GraphQL tipa za korisnika
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  # Čitanje podataka iz baze (Query)
  query do
    field :users, list_of(:user) do
      resolve(fn _, _, _ ->
        {:ok, Accounts.list_users()}
      end)
    end
  end

  # Upisivanje podataka u bazu (Mutation)
  mutation do
    field :create_user, :user do
      arg :name, non_null(:string)
      arg :email, non_null(:string)

      resolve(fn _, args, _ ->
        case Accounts.create_user(args) do
          {:ok, user} ->
            {:ok, user}
          {:error, _changeset} ->
            {:error, "Neuspešno kreiranje korisnika. Proverite podatke."}
        end
      end)
    end
  end
end
