defmodule EncryptedFieldTest do
  use ExUnit.Case
  doctest EncryptedStringField


  test ".cast converts a value to a string" do
    assert {:ok, "123"} == EncryptedStringField.cast(123)
  end

  test ".dump encrypts a value" do
    {:ok, ciphertext} = EncryptedStringField.dump("Secret value")

    assert ciphertext !=  "Secret value"
    assert String.length(ciphertext) != 0
  end

  test ".load decrypts a value" do
    {:ok, ciphertext} = EncryptedStringField.dump("Hello")
    assert {:ok, "Hello"} == EncryptedStringField.load(ciphertext)
  end
end
