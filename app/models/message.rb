class Message < ActiveRecord::Base
	def response
		answer = Message.new(:author => "ni", :content => "")

		intento = nil

		if self.content.last == '?'
			if content.include? 'cosa'
				intento = 'cosa'

				self.content.slice! 'cosa'
			elsif content.include? 'dove'
				intento = 'dove'

				self.content.slice! 'dove'
			elsif content.include? 'quando'
				intento = 'quando'

				self.content.slice! 'quando'
			elsif content.include? 'chi'
				intento = 'chi'

				self.content.slice! 'chi'
			else
				intento = 'conferma'
			end

			self.content.chop! # rimuoviamo il '?'
		end

		@frase = Phrase.new(self.content)

		@frase.raggruppa_parole

		@frase.trova_predicati

		if not @frase.predicati.empty?
			@frase.trova_soggetti

			@frase.trova_complementi
		end

		if intento.nil?
			# quando abbiamo una affermazione, creiamo un'azione
			azione = Action.new(:subject => @frase.soggetti.first.to_json, :predicate => @frase.predicati.first.to_json, :complements => @frase.complementi.to_json)

			azione.save

			# aggiorniamo tutte le azioni precedenti, che magari possono essere ricercati meglio i complementi
			#
			#
			# DA FARE!
			#
			#

			answer.content = 'okay'
		else # è una domanda
			if @frase.soggetti.empty? && intento != 'chi'
				# se manca il soggetto significa che viene chiesta una precisazione riguardo al messaggio precedente
				# in pratica viene analizzato il messaggio precedente, cambiando soltanto l'intento della domanda
				# che sarà quello determinato dalla frase senza soggetto

				messaggio_precedente = Message.all[-3].content # in teoria bisogna tornare indietro fino alla prima domanda avente un soggetto

				if messaggio_precedente.last == '?'
					if messaggio_precedente.include? 'cosa'
						messaggio_precedente.slice! 'cosa'
					elsif messaggio_precedente.include? 'dove'
						messaggio_precedente.slice! 'dove'
					elsif messaggio_precedente.include? 'quando'
						messaggio_precedente.slice! 'quando'
					end

					messaggio_precedente.chop! # rimuoviamo il '?'
				end

				@frase = Phrase.new(messaggio_precedente)

				@frase.raggruppa_parole

				@frase.trova_predicati

				if not @frase.predicati.empty?
					@frase.trova_soggetti

					@frase.trova_complementi
				end

				puts @frase.parole.to_s
			end

			if intento == 'conferma'
				# if frase.predicati.first.tipo == 'nominale'
				answer.content = 'no'

				Action.all.each do |azione|
					if azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)
						answer.content = 'si'
					end
				end
				# end
			elsif intento == 'cosa'
				answer.content = 'non lo so'

				Action.all.each do |azione|
					if azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)
						azione_risposta = azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)

						complemento_oggetto = azione_risposta.complementi.select { |c| c.tipo == 'oggetto' }.first

						if complemento_oggetto
							answer.content = complemento_oggetto.testo
						end
					end
				end

				# if @frase.soggetti.first.lemma.nome?
				# 	Action.all.each do |azione|
				# 		if azione.cosa?(@frase.soggetti.first, @frase.predicati.first)
				# 			answer.content = azione.cosa?(@frase.soggetti.first, @frase.predicati.first)
				# 		end
				# 	end
				# else
				# 	Action.all.each do |azione|
				# 		puts azione.predicato.limma
				# 		if azione.cosa?(Subject.new(@frase.predicati.first.nome_del_predicato, @frase.predicati.first.limma_nome_del_predicato), @frase.predicati.first)
				# 			answer.content = azione.cosa?(Subject.new(@frase.predicati.first.nome_del_predicato, @frase.predicati.first.limma_nome_del_predicato), @frase.predicati.first)
				# 		end
				# 	end
				# end
			elsif intento == 'dove'
				answer.content = 'non lo so'

				Action.all.each do |azione|
					if azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)
						azione_risposta = azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)

						complemento_di_luogo = azione_risposta.complementi.select { |c| c.tipo == 'luogo' }.first

						if complemento_di_luogo
							answer.content = complemento_di_luogo.testo
						end
					end
				end
			elsif intento == 'quando'
				answer.content = 'non lo so'

				Action.all.each do |azione|
					if azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)
						azione_risposta = azione.conferma?(@frase.soggetti.first, @frase.predicati.first, @frase.complementi)

						complemento_di_luogo = azione_risposta.complementi.select { |c| c.tipo == 'tempo' }.first

						if complemento_di_luogo
							answer.content = complemento_di_luogo.testo
						end
					end
				end
			elsif intento == 'chi'
				answer.content = 'non lo so'

				Action.all.each do |azione|
					if azione.conferma?(nil, @frase.predicati.first, @frase.complementi)
						azione_risposta = azione.conferma?(nil, @frase.predicati.first, @frase.complementi)

						soggetto = azione_risposta.soggetto.parole.map { |p| p.parola }.join(' ')

						answer.content = soggetto
					end
				end
			end
		end

		# answer.content += @frase.parole.to_s

		# answer.content += 'Predicato ' + @frase.predicati.first.tipo + ': ' + @frase.predicati.first.parole.to_s

		# answer.content += 'Verbo: ' + @frase.predicati.first.limma

		# unless @frase.soggetti.empty?
		# 	answer.content += 'Soggetto: ' + @frase.soggetti.first.parole.to_s

		# 	answer.content += 'Limma soggetto: ' + @frase.soggetti.first.limma
		# end

		# if @frase.predicati.first.tipo == 'nominale'
		# 	@frase.predicati.first.trova_nome_del_predicato

		# 	answer.content += 'Nome del predicato con limma ' + @frase.predicati.first.limma_nome_del_predicato + ': ' + @frase.predicati.first.nome_del_predicato.to_s

		# 	@frase.esegui
		# end

		# if query
		# 	answer.content += 'Risposta: '

		# 	@frase.trova_predicati

		# 	if not @frase.predicati.empty?
		# 		@frase.trova_soggetto
		# 	end

		# 	if @frase.predicati.first.tipo == 'nominale'
		# 		@frase.intento = 'verità'

		# 		# qui ci va il contorollo se il nome del predicato è un aggettivo o un nome
		# 		if @frase.trova_nome_del_predicato.nome? # these should go in a variable
		# 			answer.content += 'nome'


		# 		elsif @frase.trova_nome_del_predicato.aggettivo?  # these should go in a variable
		# 			answer.content += 'aggettivo'
		# 		else
		# 			answer.content += 'booooooh'
		# 		end
		# 	end
		# else
		# 	answer.content += 'Esito istruzione: '

		# 	@frase.trova_predicati

		# 	if not @frase.predicati.empty?
		# 		@frase.trova_soggetto
		# 	end

		# 	if @frase.predicati.first.tipo == 'nominale'
		# 		answer.content += eval(@frase.predicati.first.parole.first.verbo?.azione(Concept.where(:noun_id => @frase.soggetto.last.nome?.id).first, Concept.where(:noun_id => @frase.trova_nome_del_predicato.nome?.id).first))
		# 	end
		# end

		# answer.content = @frase.soggetto.to_s

		answer.save

		answer.content
	end

	def okay
		self.content = "okay"
	end

	def nouns
		self.content = Noun.first.nome
	end
end
