class CreateNouns < ActiveRecord::Migration
  def change
    create_table :nouns do |t|
      t.string :nome
      t.string :definizione
      t.string :genere
      t.references :noun, index: true

      t.timestamps
    end
  end
end
