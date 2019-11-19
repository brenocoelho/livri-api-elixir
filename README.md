# LivriApp

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


mix phx.new livri-api --app livri_app --module LivriApp --no-html --no-webpack --binary-id

mix phx.gen.json Users User users \
document:string \
username:string \
first_name:string \
last_name:string \
email:string \
phone:string \
digital_hash:string

mix phx.gen.json Tasks Task tasks \
user_id:references:users \
name:string \
when:date \
frequency:string \
status:string
