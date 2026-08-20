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

validators = require "validators"

ipv4_validator = validators.ipv4!
port_validator = validators.port!

CryptoApiService = {}

CryptoApiService.create = ({ :http_service, :host, :port }) ->
  valid_ipv4, ipv4_validator_err = ipv4_validator host
  unless valid_ipv4
    error ipv4_validator_err

  valid_port, port_validator_err = port_validator port
  unless valid_port
    error port_validator_err

  argon2_hash_encoded: ({ :value }) ->
    req =
      method: "POST"
      headers: 
        ["Content-Type"]: 'application/json'
        Accept: 'application/json'
      url: "#{host}:#{port}/argon2/hash-encoded"
      body: :value
    res = http_service.request req
    unless res.status == 200
      return nil, res.body.reason or "Response not 200"
    res.body

CryptoApiService
