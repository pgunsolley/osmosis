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

import validate_email, validate_password from require "validators"

email_validator = validate_email!
password_validator = validate_password!

UserService = {}

UserService.create = ({ :Users }) ->
  create: ({ :email, :password }) ->
    email_valid, email_err = email_validator email
    unless email_valid
      return email_valid, email_err
    password_valid, password_err = password_validator password
    unless password_valid
      return password_valid, password_err
    Users\create
      :email
      :password

UserService
