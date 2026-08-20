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

import CryptoApiService from require "services.crypto_api_service"
import HttpService from require "services.http_service"

describe "CryptoApiService", ->
  local crypto_api_service
  before_each ->
    host = "127.0.0.1"
    port = "8000"
    resty_http_mock = mock({}, true)
    http_service_mock = mock(HttpService(resty_http: resty_http_mock), true)
    crypto_api_service = CryptoApiService
      http_service: http_service_mock
      :host
      :port

  describe "argon2_hash_encoded()", ->
    it "should call http_service.request once with value: 'foo'", ->
      crypto_api_service.argon2_hash_encoded
        value: "foo"

