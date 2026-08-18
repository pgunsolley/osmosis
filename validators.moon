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

validators = {}

validators.validate_str_length = ({ :min_length, :max_length }) ->
  (value) ->
    if type(value) ~= "string"
      return false, "Must be a valid string"
    len = #value
    if len < min_length
      return false, "Must have more than #{min_length} characters"
    if len > max_length
      return false, "Must have fewer than #{max_length} characters"
    true

validators.validate_email = ({ :min_length, :max_length }) ->
  str_length_validator = validators.validate_str_length
    min_length: min_length or 3
    max_length: max_length or 254
  (value) ->
    str_length_valid, err_msg = str_length_validator value
    unless str_len_valid
      return str_length_valid, err_msg
    if not string.match(value, "^[%w._%%+-]+@[%w.-]+%.%a%a+$") or 
      string.find(value, "%.%.") or 
      string.find(value, "^%.") or 
      string.find(value, "%.@") or 
      string.find(value, "@%.")
      return false, "Not a valid email"
    true

validators.validate_password = ({ :min_length, :max_length }) ->
  str_length_validator = validators.validate_str_length
    min_length: min_length or 6
    max_length: max_length or 254
  (value) ->
    str_length_valid, err_msg = str_length_validator value
    unless str_len_valid
      return str_len_valid, err_msg
    true

validators
