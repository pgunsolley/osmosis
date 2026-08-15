config = require "lapis.config"

local db_host, db_user, db_password, db_database

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
  code_cache: "off"
  num_workers: "1"
  mysql:
    host: db_host
    user: db_user
    password: db_password
    database: db_database
