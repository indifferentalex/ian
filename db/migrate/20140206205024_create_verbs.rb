class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :infinito
      t.string :prima_persona_singolare
      t.string :seconda_persona_singolare
      t.string :terza_persona_singolare
      t.string :prima_persona_plurale
      t.string :seconda_persona_plurale
      t.string :terza_persona_plurale
      t.string :participio_passato
      t.string :ausiliare

      t.timestamps
    end
  end
end
