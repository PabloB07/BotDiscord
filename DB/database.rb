require "sequel"
require "sequel_enum"
require "sqlite3"

module Ichigobot
  module DB
    module Database
DB = Sequel.connect("sqlite://ichigo.db")

Sequel.extension :migration
Sequel::Migrator.run(DB, "Ichigobot/migrations")

Sequel::Model.plugin :timestamps

Dir["Ichigobot/models/*.rb"].each { |model| load model }
  end
end
