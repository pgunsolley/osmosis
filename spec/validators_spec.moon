validators = require "validators"

describe "validators.lua", ->
  describe "number() with default arguments", ->
    local number_validator
    before_each ->
      number_validator = validators.number!

    it "should return true when called with 42", ->
      result = number_validator 42
      assert.is_true result

    it "should return true when called with -42", ->
      result = number_validator -42
      assert.is_true result

    it "should return true when called with 42.4", ->
      result = number_validator 42.4
      assert.is_true result

    it "should return true when called with -42.4", ->
      result = number_validator -42.4
      assert.is_true result

    it "should return false when called with foobar", ->
      result = number_validator "foobar"
      assert.is_false result

    it "should return false when called with {}", ->
      result = number_validator {}
      assert.is_false result

  describe "number() with signed: false", ->
    local number_validator
    before_each ->
      number_validator = validators.number
        signed: false

    it "should return true when called with 42", ->
      result = number_validator 42
      assert.is_true result

    it "should return false when called with -42", ->
      result = number_validator -42
      assert.is_false result

    it "should return true when called with 42.4", ->
      result = number_validator 42.4
      assert.is_true result

    it "should return false when called with -42.4", ->
      result = number_validator -42.4
      assert.is_false result

    it "should return false when called with foobar", ->
      result = number_validator "foobar"
      assert.is_false result

    it "should return false when called with {}", ->
      result = number_validator {}
      assert.is_false result

  describe "number() with min_length: 1", ->
    -- TODO: Finish
