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

import create_container from require "injection"
config = require "lapis.config"

container = create_container!
with container
  .put "config", ->
    c = config.get!
    setmetatable {},
      __index: (t, k) ->
        c[k] or error "config key #{k} is not set"

  .put "models", -> require "models"

  .put "http_client", -> require "lapis.nginx.resty_http"

  .put "crypto_service",
    (config, http_client) ->
      CryptoService = require "services.crypto"
      CryptoService http_client, config.crypto_host, config.crypto_port,
    { "config", "http_client" }

container
