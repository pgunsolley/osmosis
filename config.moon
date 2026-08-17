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

config = require "lapis.config"

local port, db_host, db_user, db_password, db_database

port = os.getenv "PORT" or "8080"

print "Starting on port #{port}"

unless db_host = os.getenv "DB_HOST"
  print "DB_HOST is not set"
  os.exit 1
unless db_user = os.getenv "DB_USER"
  print "DB_USER is not set"
  os.exit 1
unless db_password = os.getenv "DB_PASSWORD"
  print "DB_PASSWORD is not set"
  os.exit 1
unless db_database = os.getenv "DB_DATABASE"
  print "DB_DATABASE is not set"
  os.exit 1

config "development",
  server: "nginx"
  :port
  code_cache: "off"
  num_workers: "1"
  mysql:
    host: db_host
    user: db_user
    password: db_password
    database: db_database
