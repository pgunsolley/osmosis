-- Copyright (C) 2026 Patrick Gunsolley [patrick.gunsolley@outlook.com](mailto:patrick.gunsolley@outlook.com) 
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version. 
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details. 
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

-- Define all consumable env vars
-- Definition:
--  env - The env var
--  ?default - The default value if unset
--  ?on_fail - A function that is called when an env var is unset and has no default
--  ?on_success - A function that is called with the value when an env var is loaded 
env_config = {
  {
    env: "PORT"
    default: "8080"
    on_success: (port) ->
      print "Using port #{port}"
  },
  {
    env: "DB_HOST"
  },
  {
    env: "DB_USER"
  },
  {
    env: "DB_PASSWORD"
  },
  {
    env: "DB_DATABASE"
  },
  {
    env: "CRYPTO_HOST"
  },
  {
    env: "CRYPTO_PORT"
  }
}

env = {}
for conf in *env_config
  val = os.getenv(conf.env) or conf.default
  if val == nil
    if type(conf.on_fail) == "function"
      conf.on_fail!
    else
      print "#{conf.env} is not set"
    print "Exiting"
    os.exit 1
  if type(conf.on_success) == "function"
    conf.on_success val
  env[string.lower conf.env] = val

config = require "lapis.config"

config "development",
  server: "nginx"
  code_cache: "off"
  num_workers: "1"
  :env
  mysql:
    host: db_host
    user: db_user
    password: db_password
    database: db_database
