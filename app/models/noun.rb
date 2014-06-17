class Noun < ActiveRecord::Base
  belongs_to :hypernym, :class_name => 'Noun', :foreign_key => 'noun_id'
  has_many :hyponyms, :class_name => 'Noun', :foreign_key => 'noun_id'

  def == parola
    if nome == parola || pluralizza == parola
      true
    else
      false
    end
  end

  def pluralizza
  	# to do
  	# 1. i nomi con una sola sillaba al plurale non cambiano
  	# 2. finire end_with? accentate
  	# 3. ordinare dai end_with? più specifici a quelli meno specifici
  	# 4. replace ugly end_with?s with regexes

  	if nome.end_with? "cia"
  		if nome.chomp("cia").end_with?("a") || nome[0..-4].end_with?("e") || nome[0..-4].end_with?("i") || nome[0..-4].end_with?("o") || nome[0..-4].end_with?("u")
  			nome.chop.chop.chop + "cie"
  		else
  			nome.chop.chop.chop + "ce"
  		end
  	elsif nome.end_with? "gia"
  		if nome.chomp("gia").end_with?("a") || nome[0..-4].end_with?("e") || nome[0..-4].end_with?("i") || nome[0..-4].end_with?("o") || nome[0..-4].end_with?("u")
  			nome.chop.chop.chop + "gie"
  		else
  			nome.chop.chop.chop + "ge"
  		end
  	elsif nome.end_with? "ca"
   		if maschile?
  			nome.chop.chop + "chi"
  		else
  			nome.chop.chop + "che"
  		end
  	elsif nome.end_with? "ga"
   		if maschile?
  			nome.chop.chop + "ghi"
  		else
  			nome.chop.chop + "ghe"
  		end
  	elsif nome.end_with? "ia"
  		nome.chop.chop + "ie"
  	elsif nome.end_with? "a"
  		if maschile?
  			nome.chop + "i"
  		else
  			nome.chop + "e"
  		end
  	elsif nome.end_with? "o"
  		nome.chop + "i"
  	elsif nome.end_with? "e"
  		nome.chop + "i"
  	elsif nome.end_with? "i"
  		nome
  	elsif nome.end_with?("à") || nome.end_with?("è") || nome.end_with?("ì")
  		nome
  	else
  		nome
  	end 			
  end

  def articolo
    
  end

  def self.articolo_determinativo?(parola)
    if ["il", "lo", "i", "gli", "la", "le"].include? parola
      true
    else
      false
    end
  end

  def self.articolo_indeterminativo?(parola)
    if ["un", "uno", "una"].include? parola
      true
    else
      false
    end
  end

  def maschile?
  	if genere == "m"
  		true
  	else
  		false
  	end
  end

  def femminile?
  	if genere == "f"
  		true
  	else
  		false
  	end
  end
end
