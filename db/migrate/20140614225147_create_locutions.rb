class CreateLocutions < ActiveRecord::Migration
  def change
    create_table :locutions do |t|
      t.string :content

      t.timestamps
    end
  end
end
