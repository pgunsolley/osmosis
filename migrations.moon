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

db = require "lapis.db"
import create_table, create_index, types from require "lapis.db.schema"

{
  [1786833964]: =>
    create_table "users", {
      { "id", types.id },
      { "email", types.varchar },
      { "password", types.varchar },
      { "created_at", types.datetime },
      { "updated_at", types.datetime },
    }
    create_index "users", "email", unique: true
}
