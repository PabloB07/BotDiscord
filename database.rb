require "sequel"
require "sequel_enum"

module Ichigo
  module Database
DB = Sequel.connect("sqlite://ichigo.db")

Sequel.extension :migration
Sequel::Migrator.run(DB, "Ichigo/migrations")

Sequel::Model.plugin :timestamps

Dir["Ichigo/models/*.rb"].each { |model| load model }
  end
end
