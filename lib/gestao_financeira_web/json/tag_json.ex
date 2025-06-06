defmodule GestaoFinanceiraWeb.TagJSON do
  def index(%{tags: tags}) do
    %{data: Enum.map(tags, &tag_json/1)}
  end

  def show(%{tag: tag}) do
    tag_json(tag)
  end

  defp tag_json(tag) do
    %{
      id: tag.id,
      name: tag.name,
      user_id: tag.user_id,
      inserted_at: tag.inserted_at,
      updated_at: tag.updated_at
    }
  end
end
