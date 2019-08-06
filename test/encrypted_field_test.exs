defmodule EncryptedFieldTest do
  use ExUnit.Case
  doctest EncryptedField


  test ".cast converts a value to a string" do
    assert {:ok, "123"} == EncryptedField.cast(123)
  end

  test ".dump encrypts a value" do
    {:ok, ciphertext} = EncryptedField.dump("Secret value")

    assert ciphertext !=  "Secret value"
    assert String.length(ciphertext) != 0
  end

  test ".load decrypts a value" do
    {:ok, ciphertext} = EncryptedField.dump("Hello")
    assert {:ok, "Hello"} == EncryptedField.load(ciphertext)
  end
end
