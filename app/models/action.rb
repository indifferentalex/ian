class Action < ActiveRecord::Base
	def soggetto
		Subject.new(JSON.parse(self.subject)["parole"].map { |parola| Word.new(parola["parola"], parola["pdd"], parola["lemma"]) }, JSON.parse(self.subject)["limma"])
	end

	def predicato
		Predicate.new(JSON.parse(self.predicate)["parole"].map { |parola| Word.new(parola["parola"], parola["pdd"], parola["lemma"]) },
			JSON.parse(self.predicate)["nome_del_predicato"].map { |parola| Word.new(parola["parola"], parola["pdd"], parola["lemma"]) },
			JSON.parse(self.predicate)["limma_nome_del_predicato"],
			JSON.parse(self.predicate)["tipo"],
			JSON.parse(self.predicate)["limma"])
	end

	def complementi
		risultato = []

		JSON.parse(self.complements).each do |complement|
			complemento = Complement.new(complement["parole"].map { |parola| Word.new(parola["parola"], parola["pdd"], parola["lemma"]) },
				complement["tipo"],
				complement["lemma"])

			risultato << complemento			
		end

		risultato
	end

	def complementi_corrispondono?(c)
		# l'azione deve contenere tutti i complmenti della frase, la frase non tutti i complementi dell'azione
		complementi_corrispondenti = 0

		c.each do |complemento|
			presente = false

			self.complementi.each do |comp|
				if comp == complemento
					presente = true
				end
			end

			if presente
				complementi_corrispondenti += 1
			end
		end

		if complementi_corrispondenti == c.count
			return true
		else
			return false
		end
	end

	def conferma?(s, p, c)
		if ((self.soggetto == s) || s.nil?) && (self.predicato.limma_nome_del_predicato == p.limma_nome_del_predicato) && (self.predicato.limma == p.limma)
			if not c.empty?
				if self.complementi_corrispondono?(c)
					return self
				end
			else
				return self
			end
		elsif self.soggetto == s
			Action.all.each do |azione|
				if azione.conferma?(Subject.new(self.predicato.nome_del_predicato, self.predicato.limma_nome_del_predicato), p, c)
					return self
				end
			end

			return false
		else
			return false
		end
	end

	def cosa?(s, p)
		if (self.soggetto == s) && ((self.predicato.limma.include? p.limma) || (p.limma.include? self.predicato.limma)) # stesso soggetto e stesso verbo
			return self.predicato.limma_nome_del_predicato
		else
			return false
		end
	end
end
