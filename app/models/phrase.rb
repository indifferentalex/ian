class Phrase
	attr_accessor :parole, :soggetti, :predicati, :complementi, :intento, :raw, :gruppi

	def initialize(sentence)
		self.raw = sentence

		self.parole = []

		cmd = 'echo "' + sentence + '" | /Users/alexvlasov/Code/tree-tagger/cmd/tree-tagger-italian' # /home/deployer/downloads/cmd/tree-tagger-italian-utf8' # '/Users/alex/Development/treetaggerutf8/cmd/tree-tagger-italian-utf8

		value = `#{cmd}`

		result = value.split

		puts result

		result.each_with_index do |row, i|
			if i % 3 == 2 # third element
				if result[i] == '@card@' # in modo che i numeri hanno come lemma il numero
					parola = Word.new(result[i - 2], result[i - 1], result[i - 2])
				elsif result[i] == '<unknown>' and result[i - 2].first.is_upper?  # si tratta di un nome proprio
					parola = Word.new(result[i - 2], 'NPR', result[i - 2])
				else
					parola = Word.new(result[i - 2], result[i - 1], result[i])
				end

				self.parole << parola
			end
		end

		puts parole.to_s

		self.parole.each do |p|
			if p.pdd.include?('VER')
				Verb.carica_coniugazioni(p.lemma)
			end
		end

		self.soggetti = []
		self.predicati = []
		self.complementi = []
		self.gruppi = []
		self.intento = nil
	end

	def raggruppa_parole
		gruppo = Group.new

		self.parole.each do |parola|
			if parola.articolo? or parola.preposizione? or parola.pdd.include?('NPR') # divisione obbligatoria
				if not gruppo.parole.empty?
					if not gruppo.parole.last.articolo? and not gruppo.parole.last.preposizione?
						if gruppo.parole.last.verbo?
							# if not gruppo.parole.last.verbo?.infinito == 'essere' # non trattandosi di un predicato nominale, dividiamo
							self.gruppi << gruppo

							gruppo = Group.new

							gruppo.parole << parola
							# else # predicato nominale
							# 	if parola.articolo?
							# 		gruppo.parole << parola
							# 	else # preposizione
							# 		self.gruppi << gruppo

							# 		gruppo = Group.new

							# 		gruppo.parole << parola
							# 	end
							# end
						else
							self.gruppi << gruppo

							gruppo = Group.new

							gruppo.parole << parola
						end
					else # se la parola precedente è anch'essa un articolo/preposizione vanno insieme
						gruppo.parole << parola
					end
				else
					gruppo.parole << parola
				end
			else # la parola non è un articolo/preposizione
				if parola.verbo?
					if not gruppo.parole.empty?
						if not gruppo.parole.last.verbo?
							self.gruppi << gruppo

							gruppo = Group.new

							gruppo.parole << parola
						else
							gruppo.parole << parola
						end
					else
						gruppo.parole << parola
					end
				else # la parola non è un verbo
					if not gruppo.parole.empty?
						if gruppo.parole.last.verbo?
							# if gruppo.parole.last.verbo?.infinito == 'essere' # nome del predicato, perciò sta nello stesso gruppo del verbo
								# no, questo comportamento è stato cambiato, il nome del predicato sta in un gruppo da solo all'inizio
								# gruppo.parole << parola
							# else # il predicato è un predicato verbale, perciò qualunque parola che non sia un verbo che viene dopo sta in un gruppo a se stante
								self.gruppi << gruppo

								gruppo = Group.new

								gruppo.parole << parola
							# end
						else
							gruppo.parole << parola
						end
					else
						gruppo.parole << parola
					end
				end
			end
		end

		if not gruppo.parole.empty?
			self.gruppi << gruppo
		end

		# alla ricerca di locuzioni (e.g. unità di tempo)
		i = 0

		while i < gruppi.count - 1 do # fino al penultimo
			if (self.gruppi[i].parole.first.articolo? or self.gruppi[i].parole.first.preposizione? or self.gruppi[i].parole.first.pdd.include?('NOM')) and (self.gruppi[i + 1].parole.first.articolo? or self.gruppi[i + 1].parole.first.preposizione? or self.gruppi[i + 1].parole.first.pdd.include?('NOM'))
				parole_locuzione = self.gruppi[i].parole + self.gruppi[i + 1].parole

				if parole_locuzione.first.articolo?
					parole_locuzione.shift
				end

				if not Locution.where(:content => parole_locuzione.map { |word| word.parola }.join(' ')).empty?
					self.gruppi[i].parole.concat(self.gruppi[i + 1].parole)

					self.gruppi.slice!(i + 1)
				end
			end

			i += 1
		end
	end

	def trova_predicati
		if self.predicati.empty?
			self.gruppi.each_with_index do |gruppo, i|
				if gruppo.parole.first.verbo?
					predicato = Predicate.new

					predicato.parole = gruppo.parole

					if gruppo.parole.any? { |parola| parola.pdd.include?('VER') and parola.verbo?.infinito != 'essere' } # sono presenti verbi che non sono 'essere'
						predicato.tipo = 'verbale'
					else # altrimenti è presente solo il verbo essere
						predicato.tipo = 'nominale'
					end

					gruppo.parole.each do |parola|
						if parola.pdd.include?('VER')
							predicato.limma = parola.verbo?.infinito
						end
					end

					gruppo.tipo = 'predicato'

					if predicato.tipo == 'nominale'
						if i + 1 < self.gruppi.count # per non andare fuori range
							# dobbiamo "assorbire" il gruppo subito dopo
							gruppo.parole += self.gruppi[i + 1].parole

							predicato.parole = gruppo.parole

							self.gruppi.slice!(i + 1)

							predicato.trova_nome_del_predicato
						end
					end

					self.predicati << predicato
				end
			end
		end
	end

	# def trova_predicati
	# 	if self.predicati.empty? # to avoid multiples
	# 		c = 0
	# 		predicato = Predicate.new # to set the scope properly, otherwise predicato only exists within that if!

	# 		self.parole.each do |parola|
	# 			if parola.pdd.include? 'VER'
	# 				if c == 0
	# 					predicato = Predicate.new

	# 					if parola.verbo?.infinito == 'essere'
	# 						predicato.tipo = 'nominale'
	# 					else
	# 						predicato.tipo = 'verbale'
	# 					end

	# 					predicato.parole << parola
	# 					c += 1
	# 				else
	# 					predicato.parole << parola
	# 					c += 1
	# 				end
	# 			else
	# 				if c > 0
	# 					solo_verbo_essere = true

	# 					predicato.parole.each do |p|
	# 						if (p.pdd.include? 'VER') && !(p.lemma.include? 'essere')
	# 							solo_verbo_essere = false
	# 						end
	# 					end

	# 					if solo_verbo_essere
	# 						if (parola.pdd.include? 'DET') || (parola.pdd.include? 'NOM') || (parola.pdd.include? 'ADJ')
	# 							predicato.parole << parola
	# 							c += 1
	# 						else
	# 							# controlliamo il verbo
	# 							predicato.parole.each do |p|
	# 								if (p.pdd.include? 'VER') && !(p.lemma.include? 'essere') && !(p.lemma.include? 'avere')
	# 									predicato.limma = p.lemma
	# 								end
	# 							end

	# 							if predicato.limma.nil?
	# 								predicato.limma = predicato.parole.first.lemma
	# 							end

	# 							self.predicati << predicato
	# 							c = 0
	# 						end
	# 					else
	# 						# controlliamo il verbo
	# 						predicato.parole.each do |p|
	# 							if (p.pdd.include? 'VER') && !(p.lemma.include? 'essere') && !(p.lemma.include? 'avere')
	# 								predicato.limma = p.lemma
	# 							end
	# 						end

	# 						if predicato.limma.nil?
	# 							predicato.limma = predicato.parole.first.lemma
	# 						end

	# 						self.predicati << predicato
	# 						c = 0
	# 					end
	# 				end
	# 			end
	# 		end

	# 		# se il verbo è l'ultima parola
	# 		if c > 0
	# 			# controlliamo il verbo
	# 			predicato.parole.each do |p|
	# 				if (p.pdd.include? 'VER') && !(p.lemma.include? 'essere') && !(p.lemma.include? 'avere')
	# 					predicato.limma = p.lemma
	# 				end
	# 			end

	# 			if predicato.limma.nil?
	# 				predicato.limma = predicato.parole.first.lemma
	# 			end

	# 			self.predicati << predicato
	# 			c = 0
	# 		end
	# 	end
	# end

	def trova_soggetti
		if self.predicati.empty?
			self.trova_predicati
		end

		if self.predicati.first
			if self.soggetti.empty?
				indice_predicato = self.gruppi.index(self.gruppi.select { |gruppo| gruppo.parole == self.predicati.first.parole }.first)

				# controlliamo per prima cosa i gruppi davanti al predicato
				self.gruppi.first(indice_predicato).each do |gruppo|
					# se la prima parola è un articolo oppure un sostantivo, è un ottimo candidato per essere il soggetto
					if gruppo.parole.first.pdd.include?('DET') or gruppo.parole.first.pdd.include?('NOM') or gruppo.parole.first.pdd.include?('NPR')
						soggetto = Subject.new

						soggetto.parole = gruppo.parole

						soggetto.limma = gruppo.parole.select { |parola| parola.pdd.include?('NOM') }.first

						if soggetto.limma.nil? # allora è un nome proprio
							soggetto.limma = gruppo.parole.select { |parola| parola.pdd.include?('NPR') }.first
						end

						if not soggetto.limma.nil?
							soggetto.limma = soggetto.limma.lemma # il limma è una stringa, lemma è una Word
						end

						gruppo.tipo = 'soggetto'

						self.soggetti << soggetto
					end
				end

				if self.soggetti.empty? # nessun soggetto prima del predicato, controlliamo dopo
					self.gruppi.last(self.gruppi.count - indice_predicato - 1).reverse_each do |gruppo|
						# se la prima parola è un articolo oppure un sostantivo, è un ottimo candidato per essere il soggetto
						if gruppo.parole.first.pdd.include?('DET') or gruppo.parole.first.pdd.include?('NOM') or gruppo.parole.first.pdd.include?('NPR') and self.soggetti.empty? # solo uno per ora
							# è un ottimo candidato, ma non necessariamente il soggetto, bisogna effettuare altri controlli
							# 1. concordanza di genere/numero con il verbo
							# 2. "dove ha comprato le scarpe Claudia?", per il momento si risolve considerando l'ultimo gruppo candidato (essenzialmente "partire dalla fine della frase")

							soggetto = Subject.new

							soggetto.parole = gruppo.parole

							soggetto.limma = gruppo.parole.select { |parola| parola.pdd.include?('NOM') }.first

							if soggetto.limma.nil? # allora è un nome proprio
								soggetto.limma = gruppo.parole.select { |parola| parola.pdd.include?('NPR') }.first
							end

							if not soggetto.limma.nil?
								soggetto.limma = soggetto.limma.lemma # il limma è una stringa, lemma è una Word
							end

							gruppo.tipo = 'soggetto'

							self.soggetti << soggetto
						end
					end
				end

				indice_predicato
			end
		end
	end

	# def trova_soggetto
	# 	soggetto = Subject.new

	# 	if self.predicati.empty?
	# 		self.trova_predicati
	# 	end

	# 	# 1. controlliamo prima il caso dove il soggetto sta prima del predicato
	# 	self.parole.each_with_index do |parola, i|
	# 		if (parola.nome?) && (self.parole.index { |p| p == self.predicati.first.parole.first } > i) # la parola è un sostantivo e sta prima del predicato
	# 			# anche l'articolo se c'è
	# 			if i > 0
	# 				if self.parole[i - 1].articolo?
	# 					soggetto.parole << self.parole[i - 1]
	# 				end
	# 			end

	# 			soggetto.parole << parola

	# 			if soggetto.parole.last.pdd.include? 'NOM'
	# 				soggetto.limma = soggetto.parole.last.lemma
	# 			end
	# 		end
	# 	end

	# 	# 2. Se il soggetto non è stato trovato prima del predicato, controlliamo se sta dopo (ha mangiato il cane, è nato il bambino)
	# 	if soggetto.parole.empty?
	# 		self.parole.each_with_index do |parola, i|
	# 			if (parola.nome?) && (self.parole.index { |p| p == self.predicati.first.parole.first } < i) # la parola è un sostantivo e sta dopo il predicato
	# 				# anche l'articolo se c'è
	# 				if i > 0
	# 					if self.parole[i - 1].articolo?
	# 						soggetto.parole << self.parole[i - 1]
	# 					end
	# 				end

	# 				soggetto.parole << parola

	# 				if soggetto.parole.last.pdd.include? 'NOM'
	# 					soggetto.limma = soggetto.parole.last.lemma
	# 				end
	# 			end
	# 		end
	# 	end

	# 	self.soggetti << soggetto # al momento solo un unico soggetto
	# end

	def trova_complementi
		if self.complementi.empty?
			self.gruppi.each_with_index do |gruppo, i|
				if gruppo.tipo.nil? # non sono ancora stati analizzati quindi, ne soggetto ne predicato
					if gruppo.complemento_di_luogo?
						gruppo.tipo = 'luogo'
					elsif gruppo.complemento_di_tempo?
						gruppo.tipo = 'tempo'
					elsif gruppo.complemento_di_specificazione?
						gruppo.tipo = 'specificazione'
					elsif gruppo.complemento_di_agente?
						gruppo.tipo = 'agente'
					elsif self.predicati.first.tipo == 'verbale' && (i > 0) && (gruppi[i - 1].tipo == 'predicato') && gruppi[i].complemento_oggetto?
						gruppo.tipo = 'oggetto'
					else
						# per far portare i test dove 'complemento x è y', anche i gruppi per le quali non si trova un complemento devono "crearlo" il complemento
						# è molto importante i casi di test del tipo 'complemento x è y' perché il numero di complementi porta nel caso dello stesso numero di gruppi
						gruppo.tipo = 'nessuno'
					end

					gruppo.limma = gruppo.parole.select { |parola| parola.pdd.include?('NOM') }.first

					if gruppo.limma.nil? # allora è un nome proprio
						gruppo.limma = gruppo.parole.select { |parola| parola.pdd.include?('NPR') }.first
					end

					if not gruppo.limma.nil?
						gruppo.limma = gruppo.limma.lemma # il limma è una stringa, lemma è una Word
					end

					complemento = Complement.new(gruppo.parole, gruppo.tipo, gruppo.limma)

					self.complementi << complemento
				end
			end
		end
	end

	# def trova_parole_rimanenti # frase - soggetto - predicato
	# 	parole_rimanenti = self.parole

	# 	parole_rimanenti.delete_if { |parola| self.soggetti.first.parole.include?(parola) || self.predicati.first.parole.include?(parola) }

	# 	parole_rimanenti
	# end

	# def trova_complementi
	# 	parole_rimanenti = self.trova_parole_rimanenti

	# 	# le parole rimanenti si scorrono, tenendo conto che preposizioni/parole di diverso tipo comportono variazioni di complemento
	# 	parole_rimanenti.each do |parola|

	# 	end
	# end

	def tipo
		'dichiarazione'
	end

	def esegui
		commando = ''

		commando += 'frase = Phrase.new("' + self.raw + '");'

		commando += 'frase.trova_predicati;'

		commando += 'frase.trova_soggetto;'

		if self.predicati.first.tipo == 'nominale'
			commando += 'frase.predicati.first.trova_nome_del_predicato;'
		end

		# commando += 'frase.trova_complementi;'

		# supponiamo che si tratta di concetti
		# verbo essere : if frase.tipo == 'dichiarazione' then (frase.soggetti.first.lemma.nome?) && (frase.predicati.first.nome_del_predicato.nome?) then end; end;

		commando += self.predicati.first.lemma.verbo?.method

		eval(commando)
	end

	# def esegui
	# 	unless self.predicati.empty?
	# 		self.predicati.each do |predicato|
	# 			soggetto = self.soggetti.first


	# 		end
	# 	end
	# end
end