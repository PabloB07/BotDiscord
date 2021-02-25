module Ichigo
  module Migrations
      module BanMigration
  
  Sequel.migration do
    up do
      create_table :bans do
        primary_key :id
        
        Integer :event

        String  :user
        String  :moderator
        Integer :user_id
        Integer :moderator_id
        Integer :server_id
        String  :reason
  
        DateTime :created_at
        DateTime :updated_at
      end
    end
end
    down do
        drop_table(:bans)
    end
end
  end
  end