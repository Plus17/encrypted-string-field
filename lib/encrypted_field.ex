defmodule EncryptedField do
  @moduledoc """
  Ecto.Type que genera un campo de texto cifrado
  """

  @behaviour Ecto.Type

  @doc """
  Define el tipo como string
  """
  @spec type() :: atom
  def type, do: :string

  @doc """
  Llama al método to_string sobre el valor y retorna una tupla
  """
  @spec cast(String.t)::{:ok, String.t}
  def cast(value) do
    {:ok, to_string(value)}
  end
  def cast(_), do: :error

  @doc """
  Cifra el texto antes de ser guardado en la base de datos
  """
  def dump(value) do
    ciphertext = value |> _encrypt()
    {:ok, ciphertext}
  end

  @doc """
  Cuando el campo es consultado lo retorna descifrado
  """
  def load(value) do
    plaintext = value |> _decrypt()
    {:ok, plaintext}
  end

  # Cifra un texto y lo transforma a base64 para guardarlo como string
  @spec _encrypt(String.t) :: String.t
  defp _encrypt(plaintext) when is_binary(plaintext) do
    plaintext |> AES.encrypt() |> :base64.encode()
  end
  defp _encrypt(_), do: nil

  # Hace decode de base64 y descifra el dato
  @spec _decrypt(String.t) :: String.t
  defp _decrypt(ciphertext) when is_binary(ciphertext) do
    ciphertext |> :base64.decode() |> AES.decrypt()
  end
  defp _decrypt(_), do: nil
end
