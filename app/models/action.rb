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

	def conferma?(s, p)
		if self.soggetto == s && self.predicato.limma_nome_del_predicato == p.limma_nome_del_predicato
			return true
		elsif self.soggetto == s
			Action.all.each do |azione|
				if azione.conferma?(Subject.new(self.predicato.nome_del_predicato, self.predicato.limma_nome_del_predicato), p)
					return true
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
