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

body_parser = (body, headers) ->
  switch headers['Content-Type']
    when 'application/json'
      from_json body
    else error "Unable to parse body"

class HttpService
  new: ({ :resty_http }) =>
    unless type(resty_http) == "table"
      error "Invalid type for resty_http"
    @resty_http = resty_http

  handle_request: ({ :req }) =>
    body, status, headers = @resty_http.request req
    body = body_parser body, headers
    { :body, :status, :headers }

{ :HttpService }
