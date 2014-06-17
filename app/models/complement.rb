class Complement
	attr_accessor :parole, :lemma, :tipo

	def initialize(p = [], t = nil, l = nil)
		self.parole = p
		self.tipo = t
		self.lemma = l
	end
end