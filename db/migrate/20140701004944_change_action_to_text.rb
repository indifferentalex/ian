class ChangeActionToText < ActiveRecord::Migration
  def change
  	change_column :actions, :subject, :text, :limit => nil
  	change_column :actions, :predicate, :text, :limit => nil
  	change_column :actions, :complements, :text, :limit => nil
  end
end
