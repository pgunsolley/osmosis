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

import from_json from require "lapis.util"

-- Attempts to parse body into table or returns string body
body_parser = (body, headers) ->
  switch headers['Content-Type']
    when 'application/json'
      from_json body
    else body

http_client = {}

-- Wrap lapis.nginx.resty_http
http_client.from_resty_http = (resty_http) ->
  request: (req) ->
    body, status, headers = resty_http.request req
    body = body_parser body, headers
    { :body, :status, :headers }

http_client
