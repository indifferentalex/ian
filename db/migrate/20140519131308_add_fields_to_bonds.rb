class AddFieldsToBonds < ActiveRecord::Migration
  def change
  	add_column :bonds, :concetto_1_id, :integer
  	add_column :bonds, :concetto_2_id, :integer
  	add_column :bonds, :tipo, :string
  end
end
