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

config = require "config"
import create_container from require "injection"

container = create_container!

with container
  .put "models",
    ->
      require "models"
  
  .put "http_client",
    ->
      require "lapis.nginx.resty_http"

  .put "crypto_service", 
    (http_client) ->
      base_url = config.get "crypto_base_url"
      CryptoService = require "services.crypto"
      CryptoService base_url, http_client, 
    { "http_client" }

container
