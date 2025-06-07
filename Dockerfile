FROM elixir:1.14

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

# NÃO rode mix deps.get aqui!

COPY . .

# NÃO rode mix compile aqui!

CMD ["sh", "-c", "mix deps.get && mix ecto.migrate && mix phx.server"]