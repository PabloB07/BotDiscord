Sequel.migration do
  up do
    create_table :tickets do
      primary_key :id

      String  :user
      Integer :user_id
      Integer :server_id
      Integer :status, default: 1
      String  :content

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:tickets)
  end
end