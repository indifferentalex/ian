class Word
	attr_accessor :parola, :pdd, :lemma

	def initialize(w, t, l)
		self.parola = w
		self.pdd = t
		self.lemma = l
	end

	def parte_del_discorso
		nouns = Noun.all
		verbs = Verb.all
		adjectives = Adjective.all

		if nome = nouns.index { |noun| noun == parola }
			nome = nouns[nome]

			if nome.nome == parola
				numero = "singolare"
			else
				numero = "plurale"
			end

			parola + " / sostantivo " + nome.genere + " " + numero
		elsif verbo = verbs.index { |verb| verb == parola }
			verbo = verbs[verbo]

			parola + " / verbo " + verbo.infinito + " " + verbo.tempo(parola) + " " + verbo.persona(parola)
		elsif aggettivo = adjectives.index { |adjective| adjective == parola }
			aggettivo = adjectives[aggettivo]

			if aggettivo.aggettivo == parola
				numero = "singolare"
			else
				numero = "plurale"
			end

			parola + " / aggettivo " + numero
		elsif Noun.articolo_determinativo?(parola) # det/indet/congiunzione vanno sotto la classe nome? hmmm
			parola + " / articolo determinativo"
		elsif Noun.articolo_indeterminativo?(parola)
			parola + " / articolo indeterminativo"
		# elsif Noun.congiunzione?(parola)
		# 	parola + " / congiunzione"
		else
			parola + " / non lo sò"
		end
	end

	def verbo?
		if self.pdd.include?('VER')
			verbs = Verb.all

			# a quanto pare per trasformare un participio passato dal plurale al singolare basta togliere la lettere finale a sostituirla con una o/a
			
			if verbo = verbs.index { |verb| verb == parola }
				return verbs[verbo]
			else
				participio_passato_singolare = parola.chop + 'o'

				if verbo = verbs.index { |verb| verb == participio_passato_singolare }
					return verbs[verbo]
				else
					return false
				end
			end
		else
			return false
		end
	end

	def nome?
		nouns = Noun.all

		if nome = nouns.index { |noun| noun == parola }
			nouns[nome]
		else
			false
		end
	end

	def aggettivo?
		adjectives = Adjective.all

		if aggettivo = adjectives.index { |adjective| adjective == parola }
			adjectives[aggettivo]
		else
			false
		end
	end

	def articolo?
		if Noun.articolo_determinativo?(parola) or Noun.articolo_indeterminativo?(parola) or self.pdd.include?('DET')
			true
		else
			false
		end
	end

	def preposizione?
		if self.pdd.include?('PRE')
			true
		else
			false
		end
	end

	def avverbio?
		if self.pdd.include?('ADV')
			true
		else
			false
		end
	end

	def plurale?
		
	end

	def singolare?
		
	end

	def numero?
		if ['zero', 'uno', 'due', 'tre', 'quattro', 'cinque', 'sei', 'sette', 'otto', 'nove', 'dieci'].include?(self.lemma)
			true
			# case self.lemma

			# when 'zero'
			# 	0
			# when 'uno'
			# 	1
			# when 'due'
			# 	2
			# when 'tre'
			# 	3
			# when 'quattro'
			# 	4
			# when 'cinque'
			# 	5
			# when 'sei'
			# 	6
			# when 'sette'
			# 	7
			# when 'otto'
			# 	8
			# when 'nove'
			# 	9
			# when 'dieci'
			# 	10

			# else
			# 	false
			# end 
		elsif self.lemma.is_i?
			true
		else
			false
		end
	end

	def to_s
		parola
	end
end