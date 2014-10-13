class CreateRows < ActiveRecord::Migration
  def change
    create_table :rows do |t|
      t.references :user, index: true
      t.decimal :age
      t.references :race, index: true

      t.timestamps
    end
  end
end
