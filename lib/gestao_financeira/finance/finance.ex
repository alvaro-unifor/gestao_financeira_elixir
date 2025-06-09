defmodule GestaoFinanceira.Finance do
  import Ecto.Query, warn: false
  alias GestaoFinanceira.Repo
  alias GestaoFinanceira.Finance.Tag
  alias GestaoFinanceira.Finance.Transaction

  # Lista todas as tags
  def list_tags do
    Repo.all(Tag)
  end

  # Busca uma tag por ID
  def get_tag!(id), do: Repo.get!(Tag, id)

  # Cria uma tag
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  # Atualiza uma tag
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  # Deleta uma tag
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  # Retorna um changeset para validação
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  # Transactions
  def list_transactions do
    Repo.all(Transaction)
  end

  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  def get_tags_by_ids(ids) do
    Repo.all(from(t in Tag, where: t.id in ^ids))
  end

  def create_transaction_with_tags(attrs, tags) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:tags, tags)
    |> Repo.insert()
  end

  def update_transaction_with_tags(transaction, attrs, tags) do
    transaction
    |> Transaction.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:tags, tags)
    |> Repo.update()
  end

  def list_transactions_by_user(user_id) do
    Repo.all(from(t in Transaction, where: t.user_id == ^user_id))
  end

  def list_tags_by_user(user_id) do
    Repo.all(from(tag in Tag, where: tag.user_id == ^user_id))
  end

  def list_tags_with_transactions_by_user(user_id) do
    Repo.all(
      from(tag in Tag,
        where: tag.user_id == ^user_id,
        preload: [:transactions]
      )
    )
  end

  def get_transaction(id) do
    Repo.get(Transaction, id)
  end
end
