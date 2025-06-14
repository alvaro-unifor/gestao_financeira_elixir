FROM elixir:1.14

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

COPY . .

CMD ["sh", "-c", "mix deps.get && mix ecto.migrate && mix phx.server"]