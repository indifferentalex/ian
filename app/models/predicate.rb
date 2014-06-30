class Predicate
	attr_accessor :parole, :limma, :tipo, :nome_del_predicato, :limma_nome_del_predicato

	def initialize(p = [], ndp = [], lndp = nil, t = nil, l = nil)
		self.parole = p
		self.nome_del_predicato = ndp
		self.limma_nome_del_predicato = lndp
		self.tipo = t
		self.limma = l
	end

	def ugualianza_parole(predicato)
		self.parole.map { |p| p.parola }.join(' ') == predicato
	end

	def lemma
		Word.new(self.limma, '', self.limma)
	end

	def lemma_nome_del_predicato
		self.trova_nome_del_predicato
		
		Word.new(self.limma_nome_del_predicato, '', self.limma_nome_del_predicato)
	end

	def trova_nome_del_predicato
		if self.tipo == 'nominale'
			self.parole.each do |p|
				if !(p.pdd.include? 'VER')
					self.nome_del_predicato << p

					if (p.pdd.include? 'NOM') || (p.pdd.include? 'ADJ') || (p.pdd.include? 'NPR') # ci potrebbero stare entrambi, soluzione solo per ora
						self.limma_nome_del_predicato = p.lemma
					end
				end
			end

			parole_nome_del_predicato = self.nome_del_predicato

			if parole_nome_del_predicato.first.articolo?
				parole_nome_del_predicato.shift
			end

			self.limma_nome_del_predicato = parole_nome_del_predicato.map { |word| word.lemma }.join(" ") # tutto meno l'articolo
		else
			nil
		end

		self.limma_nome_del_predicato
	end
end