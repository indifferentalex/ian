class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.references :concept, index: true
      t.references :noun, index: true
      t.text :definition

      t.timestamps
    end
  end
end
