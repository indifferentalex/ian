class Adjective < ActiveRecord::Base
  def == parola
    if (aggettivo == parola) || (pluralizza.include? parola)
      true
    else
      false
    end
  end

  def pluralizza
  	if aggettivo.end_with? "cia"
  		if aggettivo.chomp("cia").end_with?("a") || aggettivo[0..-4].end_with?("e") || aggettivo[0..-4].end_with?("i") || aggettivo[0..-4].end_with?("o") || aggettivo[0..-4].end_with?("u")
  			aggettivo.chop.chop.chop + "cie"
  		else
  			aggettivo.chop.chop.chop + "ce"
  		end
  	elsif aggettivo.end_with? "gia"
  		if aggettivo.chomp("gia").end_with?("a") || aggettivo[0..-4].end_with?("e") || aggettivo[0..-4].end_with?("i") || aggettivo[0..-4].end_with?("o") || aggettivo[0..-4].end_with?("u")
  			aggettivo.chop.chop.chop + "gie"
  		else
  			aggettivo.chop.chop.chop + "ge"
  		end
  	elsif aggettivo.end_with? "ca"
   		if maschile?
  			aggettivo.chop.chop + "chi"
  		else
  			aggettivo.chop.chop + "che"
  		end
  	elsif aggettivo.end_with? "ga"
   		if maschile?
  			aggettivo.chop.chop + "ghi"
  		else
  			aggettivo.chop.chop + "ghe"
  		end
  	elsif aggettivo.end_with? "ia"
  		aggettivo.chop.chop + "ie"
  	elsif aggettivo.end_with? "a"
  		if maschile?
  			aggettivo.chop + "i"
  		else
  			aggettivo.chop + "e"
  		end
  	elsif aggettivo.end_with? "o"
  		aggettivo.chop + "i"
  	elsif aggettivo.end_with? "e"
  		aggettivo.chop + "i"
  	elsif aggettivo.end_with? "i"
  		aggettivo
  	elsif aggettivo.end_with?("à") || aggettivo.end_with?("è") || aggettivo.end_with?("ì")
  		aggettivo
  	else
  		aggettivo
  	end 			
  end

  def self.plurale?(parola)
  	
  end

  def self.genere?(parola)
  	# se l'aggettivo finisce in 'e' non si può dedurre
  end
end
