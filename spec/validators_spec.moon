validators = require "validators"

describe "validators.lua", ->
  describe "number() with no arguments", ->
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

    it "should return false when called with nil", ->
      result = number_validator nil
      assert.is_false result

    it "should return false when called with false", ->
      result = number_validator false
      assert.is_false result

    it "should return false when called with true", ->
      result = number_validator true
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

  describe "number() with min_length: 42.4", ->
    local number_validator
    before_each ->
      number_validator = validators.number
        min_length: 42.4

    it "should return false when called with 42", ->
      result = number_validator 42
      assert.is_false result

    it "should return true when called with 42.4", ->
      result = number_validator 42.4
      assert.is_true result

  describe "number() with max_length: 42", ->
    local number_validator
    before_each ->
      number_validator = validators.number
        max_length: 42

    it "should return true when called with 42", ->
      result = number_validator 42
      assert.is_true result

    it "should return false when called with 42.1", ->
      result = number_validator 42.1
      assert.is_false result

  describe "int() with no arguments", ->
    local int_validator
    before_each ->
      int_validator = validators.int!

    it "should return true when called with 42", ->
      result = int_validator 42
      assert.is_true result

    it "should return true when called with -42", ->
      result = int_validator -42
      assert.is_true result

    it "should return false when called with 42.0", ->
      result = int_validator 42.0
      assert.is_true result

  describe "int() with min_length: 42", ->
    local int_validator
    before_each ->
      int_validator = validators.int
        min_length: 42

    it "should return true with called with 42", ->
      result = int_validator 42
      assert.is_true result

    it "should return true when called with 43", ->
      result = int_validator 43
      assert.is_true result

    it "should return false when called with 41", ->
      result = int_validator 41
      assert.is_false result

  describe "id() with no arguments", ->
    local id_validator
    before_each ->
      id_validator = validators.id!

    it "should return true when called with 1", ->
      result = id_validator 1
      assert.is_true result

    it "should return false when called with 0", ->
      result = id_validator 0
      assert.is_false result

    it "should return false when called with {}", ->
      result = id_validator {}
      assert.is_false result

  describe "string() with no arguments", ->
    local string_validator
    before_each ->
      string_validator = validators.string!
    
    it "should return true when called with 'foobar'", ->
      result = string_validator "foobar"
      assert.is_true result

    it "should return false when called with 1", ->
      result = string_validator 1
      assert.is_false result

    it "should return false when called with {}", ->
      result = string_validator {}
      assert.is_false result

    it "should return false when called with nil", ->
      result = string_validator nil
      assert.is_false result

    it "should return false when called with false", ->
      result = string_validator false
      assert.is_false result

    it "should return false when called with true", ->
      result = string_validator true
      assert.is_false result

  describe "email() with no arguments", ->
    local email_validator
    before_each ->
      email_validator = validators.email!

    it "should return true when called with 'foobar420@mail.com'", ->
      result = email_validator "foobar420@mail.com"
      assert.is_true result

    it "should return true when called with 'foo.bar420@mail.com'", ->
      result = email_validator "foo.bar420@mail.com"
      assert.is_true result

    it "should return true when called with 'foo+bar420@e-mail.com'", ->
      result = email_validator "foo+bar420@e-mail.com"
      assert.is_true result

    it "should return true when called with 'foo_bar420@mail.com'", ->
      result = email_validator "foo_bar420@mail.com"
      assert.is_true result

    it "should return true when called with 'foo.bar.baz@mail.com'", ->
      result = email_validator "foo.bar.baz@mail.com"
      assert.is_true result

    it "should return true when called with 'e@mail.com", ->
      result = email_validator "e@mail.com"
      assert.is_true result

    it "should return false when called with 'foo..bar@mail.com'", ->
      result = email_validator "foo..bar@mail.com"
      assert.is_false result

    it "should return false when called with 'foobar'", ->
      result = email_validator "foobar"
      assert.is_false result

    it "should return false when called with 'foobar.com'", ->
      result = email_validator "foobar.com"
      assert.is_false result
