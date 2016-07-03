# Mayo

[![Build Status](https://travis-ci.org/tommy351/mayo.svg?branch=master)](https://travis-ci.org/tommy351/mayo) [![Hex pm](http://img.shields.io/hexpm/v/mayo.svg?style=flat)](https://hex.pm/packages/mayo) [![Coverage Status](https://coveralls.io/repos/tommy351/mayo/badge.svg?branch=master)](https://coveralls.io/r/tommy351/mayo?branch=master) [![Inline docs](http://inch-ci.org/github/tommy351/mayo.svg)](http://inch-ci.org/github/tommy351/mayo)

Schema validator inspired by [Joi].

## Installation

Add mayo to `mix.exs` dependencies.

``` elixir
defp deps do
  [{:mayo, "~> 0.1.0"}]
end
```

Download the dependencies.

```
$ mix deps.get
```

## Usage

``` elixir
defmodule MyModule do
  require Mayo

  def call do
    Mayo.validate %{
      username: "John",
      password: "1234"
    }, %{
      username: Mayo.Any.string |> Mayo.String.min(4),
      password: Mayo.Any.string |> Mayo.String.min(6)
    }
    # {:error, %Mayo.Error{type: "string.min", path: "password"}}
  end
end
```

[Joi]: https://github.com/hapijs/joi
