Sequel.migration do
  change do
    create_table(:rabbits) do
      primary_key :id
      String :name, :null=>false
      Text :description
      Integer :age
      String :color
      DateTime :created_at
      DateTime :updated_at
    end
  end
end