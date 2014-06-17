class Subject
	attr_accessor :parole, :limma

	def initialize(p = [], l = nil)
		self.parole = p
		self.limma = l
	end

  def == soggetto
    if self.limma == soggetto.limma
    	true
    else
    	false
    end
  end

	def ugualianza_parole(soggetto)
		self.parole.map { |p| p.parola }.join(' ').sub("' ", "'") == soggetto
	end

	def lemma
		Word.new(self.limma, '', self.limma)
	end
end