class Group
	attr_accessor :parole, :limma, :tipo

	def initialize(p = [], l = nil, t = nil)
		self.parole = p
		self.limma = l
		self.tipo = t
	end

	def lemma
		Word.new(self.limma, '', self.limma)
	end

	def complemento_di_luogo?
		begin
			# ci sta sempre una preposizione
			if self.parole.first.preposizione?
				if self.parole.first.lemma.include?('sul') or (self.parole[0].lemma.include?('su') and self.parole[1].articolo?)
					return true
				end

				self.parole.each do |parola|
					if parola.pdd.include?('NOM')
						soggetto = Subject.new([parola], parola.lemma)
						predicato = Predicate.new([Word.new('è', 'VER:pres', 'essere'), Word.new('un', 'DET:indef', 'un'), Word.new('luogo', 'NOM', 'luogo')], [Word.new('luogo', 'NOM', 'luogo')], 'luogo', 'nominale', 'essere')

						# controlliamo se è un luogo
						Action.all.each do |azione|
							if azione.conferma?(soggetto, predicato)
								return true
							end
						end
					elsif parola.pdd.include?('NPR')
						soggetto = Subject.new([parola], parola.lemma)
						predicato = Predicate.new([Word.new('è', 'VER:pres', 'essere'), Word.new('un', 'DET:indef', 'un'), Word.new('luogo', 'NOM', 'luogo')], [Word.new('luogo', 'NOM', 'luogo')], 'luogo', 'nominale', 'essere')

						# controlliamo se è un luogo
						Action.all.each do |azione|
							if azione.conferma?(soggetto, predicato)
								return true
							end
						end
					end
				end

				return false
			else
				return false
			end		
		rescue
			return false
		end
	end

	def complemento_di_tempo?
		begin
			# comincia sempre con o un avverbio (ieri), o una preposizione (nel) o un articolo (il giovedì)
			if self.parole.first.avverbio? or self.parole.first.preposizione? or self.parole.first.articolo?
				if self.parole[0].preposizione? and self.parole[1].numero? # preposizione + numero subito dopo
					return true
				end

				self.parole.each do |parola|
					if parola.pdd.include?('NOM') or parola.pdd.include?('NPR') # ha senso fare la distinzione fatta nel metodo del complemento di luogo?
						soggetto = Subject.new([parola], parola.lemma)
						predicato = Predicate.new([Word.new('è', 'VER:pres', 'essere'), Word.new('un', 'DET:indef', 'un'), Word.new('periodo', 'NOM', 'periodo'), Word.new('di', 'PRE', 'di'), Word.new('tempo', 'NOM', 'tempo')], [Word.new('periodo', 'NOM', 'periodo'), Word.new('di', 'PRE', 'di'), Word.new('tempo', 'NOM', 'tempo')], 'periodo di tempo', 'nominale', 'essere')

						# controlliamo se è un luogo
						Action.all.each do |azione|
							if azione.conferma?(soggetto, predicato)
								return true
							end
						end
					end
				end

				return false
			else
				return false
			end
		rescue
			return false
		end
	end

	def complemento_di_specificazione?
		begin
			if ["del", "di", "d'"].include?(self.parole.first.lemma) # ricorda anche che ci sono i casi dove comincia con la particella pronominale 'ne' o il pronome relativo 'cui'
				return true
			else
				return false
			end
		rescue
			return false
		end
	end

	def complemento_di_agente?
		begin # Nella sintassi della frase semplice, il complemento d'agente indica, in presenza di un verbo in forma passiva, la persona o l'animale che compie l'azione indicata dal verbo, cioè l'agente.[
			if ['da', 'dal'].include?(self.parole.first.lemma)
				self.parole.each do |parola|
					if parola.pdd.include?('NOM') or parola.pdd.include?('NPR') # ha senso fare la distinzione fatta nel metodo del complemento di luogo?
						soggetto = Subject.new([parola], parola.lemma)
						predicato = Predicate.new([Word.new('è', 'VER:pres', 'essere'), Word.new('una', 'DET:indef', 'una'), Word.new('persona', 'NOM', 'persona')], [Word.new('persona', 'NOM', 'persona')], 'persona', 'nominale', 'essere')

						# controlliamo se è un luogo
						Action.all.each do |azione|
							if azione.conferma?(soggetto, predicato)
								return true
							end
						end
					end
				end

				return false
			else
				return false
			end
		rescue
			return false
		end
	end

	def complemento_oggetto?
		begin # Nella sintassi della frase semplice, il complemento d'agente indica, in presenza di un verbo in forma passiva, la persona o l'animale che compie l'azione indicata dal verbo, cioè l'agente.[
			if self.parole.first.articolo? or self.parole.first.pdd.include?('NOM') or self.parole.first.pdd.include?('NPR')
				return true
			end

			return false
		rescue
			return false
		end
	end
end