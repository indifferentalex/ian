class CreateAdjectives < ActiveRecord::Migration
  def change
    create_table :adjectives do |t|
      t.string :aggettivo
      t.string :classe

      t.timestamps
    end
  end
end
