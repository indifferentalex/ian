class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :subject
      t.string :predicate
      t.string :complements

      t.timestamps
    end
  end
end
