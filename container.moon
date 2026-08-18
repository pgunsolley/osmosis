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

container = create_container!
with container
  .put "config", ->
    config = require "lapis.config"
    c = config.get!
    setmetatable {},
      __index: (t, k) ->
        c[k] or error "config key #{k} is not set"

  .put "models", -> require "models"

  .put "http_service", ->
    resty_http = require "lapis.nginx.resty_http"
    HttpService = require "services.http_service"
    HttpService.create {
      :resty_http
    }

  .put "crypto_api_service",
    (config, http_service) ->
      host = config.crypto_host
      port = config.crypto_port
      CryptoApiService = require "services.crypto_api_service"
      CryptoApiService.create {
        :http_service
        :host
        :port
      },
    { "config", "http_service" }

  .put "user_service",
    (models) ->
      UserService = require "services.user_service"
      UserService.create {
        users_model: models.Users
      },
    { "models" }

container
