defmodule AESTest do
  use ExUnit.Case

  alias AES

  test "encrypt/1 includes the random IV in the value" do
    <<init_vector::binary-16, ciphertext::binary>> = AES.encrypt("hello")

    assert String.length(init_vector) != 0
    assert String.length(ciphertext) != 0
    assert is_binary(ciphertext)
  end

  test "encrypt/1 does not produce the same ciphertext twice" do
    assert AES.encrypt("hello") != AES.encrypt("hello")
  end

  test "decrypt/1 ciphertext that was encrypted with default key" do
    plaintext = "hello" |> AES.encrypt |> AES.decrypt()
    assert plaintext == "hello"
  end

end
