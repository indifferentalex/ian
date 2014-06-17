class Bond < ActiveRecord::Base
	belongs_to :concetto_1, :class_name => 'Concept'
	belongs_to :concetto_2, :class_name => 'Concept'
end
