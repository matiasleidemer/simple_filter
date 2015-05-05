ActiveRecord::Schema.define(version: 0) do
  create_table :products do |t|
    t.string :name
    t.integer :price
    t.datetime :start_at
    t.datetime :end_at
    t.boolean :active
  end
end
