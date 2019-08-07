defmodule AES do
  @moduledoc """
  Módulo para manejar cifrado
  """

  @aad "AES256GCM" # Usa una llave AES 256 Bit para cifrar.

  @doc """
  Cifra un texto
  """
  @spec encrypt(String.t) :: binary
  def encrypt(plaintext) do
    init_vector = :crypto.strong_rand_bytes(16)
    key = get_key()
    {ciphertext, tag} =
      :crypto.block_encrypt(:aes_gcm, key, init_vector, {@aad, to_string(plaintext), 16})
    init_vector <> tag <> ciphertext
  end

  @doc """
  Descifra un dato binary a texto plano
  """
  @spec decrypt(binary) :: String.t
  def decrypt(ciphertext) do
    <<init_vector::binary-16, tag::binary-16, ciphertext::binary>> = ciphertext
    :crypto.block_decrypt(:aes_gcm, get_key(), init_vector, {@aad, ciphertext, tag})
  end

  # Retorna la llave para cifrar y descifrar
  @spec get_key() :: binary
  defp get_key() do
    base64_key = Application.get_env(:encrypted_string_field, :encryption_key)
    :base64.decode(base64_key)
  end

end
