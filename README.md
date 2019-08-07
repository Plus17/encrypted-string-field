# EncryptedField

**EncryptedFiled** is a custom ecto type field (over normal string field) for save encrypted text values.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `encrypted_field` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:encrypted_field, "~> 0.1.0"}
  ]
end
```

## Usage

### Generate Encryption Key

Open iex and paste the following line

```elixir
:crypto.strong_rand_bytes(32) |> :base64.encode
```

### Config

Add the next line in your environment config file (remember to use environment variables):

```elixir
config :encrypted_field, encryption_key: {{generated_encryption_key}}
```

### Use custom type

Use de `EncryptedField` instead of the normal `:string` type in your context module

**Before**
```elixir
use Ecto.Schema

schema "some_schema" do
    field :secret_field, :string
end
```

**After**
```elixir
use Ecto.Schema

schema "some_schema" do
    field :secret_field, EncryptedField
end
```

Reference: https://github.com/dwyl/phoenix-ecto-encryption-example

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/encrypted_field](https://hexdocs.pm/encrypted_field).
