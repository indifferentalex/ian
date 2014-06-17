class AddMethodToVerbs < ActiveRecord::Migration
  def change
    add_column :verbs, :method, :text
  end
end
