class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.text :name

      t.timestamps
    end
  end
end
