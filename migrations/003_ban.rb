Sequel.migration do
  up do
    create_table :bans do
      primary_key :id

      # "Banido", "Expulso", "Banimento Removido"
      Integer :event, null: false

      String  :user,         null: false
      String  :moderator,    null: false
      Integer :user_id,      null: false
      Integer :moderator_id, null: false
      Integer :server_id,    null: false
      String  :reason

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:bans)
  end
end
