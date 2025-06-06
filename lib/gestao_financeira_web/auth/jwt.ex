defmodule GestaoFinanceiraWeb.Auth.JWT do
  use Joken.Config

  @impl true
  def token_config do
    default_claims()
  end

  # Define o signer explicitamente
  def signer do
    Joken.Signer.create("HS256", "sua_chave_secreta_aqui")
  end
end
