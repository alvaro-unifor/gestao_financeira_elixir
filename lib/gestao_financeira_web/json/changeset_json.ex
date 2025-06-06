defmodule GestaoFinanceiraWeb.ChangesetJSON do
  def error(%{changeset: changeset}) do
    # Retorna os erros do changeset em formato JSON
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp translate_error({msg, opts}) do
    # Tradução simples, pode customizar se quiser
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
