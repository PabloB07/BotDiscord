require "sequel"
require "sequel_enum"
require "sqlite3"

module Ichigo
    module Database
      DB = Sequel.connect("sqlite://Ichigo.db")

      Sequel.extension :migration
      Sequel::Migrator.run(DB, "Ichigo/migrations")

      Sequel::Model.plugin :timestamps

      Dir["Ichigo/models/*.rb"].each { |model| load model }
  end
end