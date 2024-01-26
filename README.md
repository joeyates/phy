# Phy

Phy provides a number of generators for Elixir Phoenix projects.

The generators are "opinionated" - you need to buy in to the library's approach
to use them.

For example, an `ok/1` helper is provided for live view returns,
allowing you to do this:

```ex
def mount(_params, _session, socket) do
  socket
  |> ok()
end
```

# Generators

* `phy.gen.live_view`

# Name

`phy` follows `phx`!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/phy>.