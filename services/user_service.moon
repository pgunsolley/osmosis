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

import Users from require "models.users"
import is_instance_of from require "moon"

validators = require "validators"

email_validator = validators.email!
password_validator = validators.password!
id_validator = validators.id!

class UserService
  new: ({ :users_model }) =>
    unless is_instance_of users_model, Users
      error "users_model must be an instance of Users"
    @Users = users_model

  create: ({ :email, :password }) =>
    valid_email, email_validator_err = email_validator email
    unless valid_email
      return valid_email, email_validator_err
    valid_password, password_validator_err = password_validator password
    unless password_valid
      return valid_password, password_validator_err
    @Users\create
      :email
      :password
  
  get: ({ :id }) =>
    valid_id, id_validator_err = id_validator id
    unless valid_id
      return valid_id, id_validator_err
    @Users\find :id

{ :UserService }
