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

validators.number = ({ :signed, :min_length, :max_length }) ->
  (value) ->
    unless (type(value) == "number"
      return false, "Must be a number"
    if signed == false and value < 0
        return false, "Must not be signed"
    if type(min_length) == "number" and value < min_length
      return false, "Must not be less than #{min_length}"
    if type(max_length) == "number" and value > max_length
      return false, "Must not be greater than #{max_length}"

validators.int = ({ :signed, :min_length, :max_length }) ->
  number_validator = validators.number
    :signed
    min_length: math.floor min_length
    max_length: math.floor max_length
  (value) ->
    valid_number, number_validator_err = number_validator value
    unless valid_number
      return valid_number, number_validator_err
    unless value % 1 == 0
      return false, "Must be an integer"
    true

validators.id = ->
  int_validator = validators.int {
    signed: false
    max_length: 2147483647
  }
  (value) ->
    int_validator value

validators.string = ({ :min_length, :max_length }) ->
  (value) ->
    unless type(value) == "string"
      return false, "Must be a string"
    len = #value
    if type(min_length) == "number" and len < min_length
      return false, "Must be greater than #{min_length} characters"
    if type(max_length) == "number" and len > max_length
      return false, "Must be fewer than #{max_length} characters"
    true

validators.email = ({ :min_length, :max_length }) ->
  string_validator = validators.string
    min_length: min_length or 3
    max_length: max_length or 254
  (value) ->
    valid_string, string_validator_err = string_validator value
    unless valid_string
      return valid_string, string_validator_err
    if not string.match(value, "^[%w._%%+-]+@[%w.-]+%.%a%a+$") or
      string.find(value, "%.%.") or
      string.find(value, "^%.") or
      string.find(value, "%.@") or
      string.find(value, "@%.")
      return false, "Not a valid email"
    true

validators.password = ({ :min_length, :max_length }) ->
  string_validator = validators.string
    min_length: min_length or 6
    max_length: max_length or 254
  (value) ->
    string_validator value

validators
