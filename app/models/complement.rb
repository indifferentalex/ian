class Complement
	attr_accessor :parole, :lemma, :tipo

	def initialize(p = [], t = nil, l = nil)
		self.parole = p
		self.tipo = t
		self.lemma = l
	end

  def == complemento
    if self.lemma == complemento.lemma && self.tipo == complemento.tipo
    	true
    else
    	false
    end
  end

  def testo
    self.parole.map { |p| p.parola }.join(' ')
  end
end