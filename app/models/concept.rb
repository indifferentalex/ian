class Concept < ActiveRecord::Base
  # belongs_to :hypernym, :class_name => 'Concept', :foreign_key => 'concept_id'
  # has_many :hyponyms, :class_name => 'Concept', :foreign_key => 'concept_id'

  has_many :some_bonds, :class_name => 'Bond', :foreign_key => 'concetto_1_id'
  has_many :other_bonds, :class_name => 'Bond', :foreign_key => 'concetto_2_id'

  belongs_to :noun

  def bonds
  	self.some_bonds + self.other_bonds
  end

  def create_hyponym(noun)
  	hyponym = Concept.new(:noun_id => noun.id, :concept_id => self.id)

  	hyponym.save
  end
end
