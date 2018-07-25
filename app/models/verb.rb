class Verb < ActiveRecord::Base
	def == parola
		if [infinito, prima_persona_singolare, seconda_persona_singolare, terza_persona_singolare, prima_persona_plurale, seconda_persona_plurale, terza_persona_plurale, participio_passato.split(',').first, participio_passato.split(',').first.gsub(/.$/, 'a')].include? parola # split(',').first perché alcune hanno come part. pass. "visto/veduto"
			true
		else
			false
		end
	end

	def tempo(parola)
		"presente"
	end

	def persona(parola)
		if parola == prima_persona_singolare
			"prima persona singolare"
		elsif parola == seconda_persona_singolare
			"seconda persona singolare"
		elsif parola == terza_persona_singolare
			"terza persona singolare"
		elsif parola == prima_persona_plurale
			"prima persona plurale"
		elsif parola == seconda_persona_plurale
			"seconda persona plurale"
		elsif parola == terza_persona_plurale
			"terza persona plurale"
		else
			"infinito"
		end
	end

	# def azione(soggetto, predicato, complementi = nil)
	# 	# carichiamo tutto in stringa
	# 	commando = ''

	# 	commando += 'parole = [];'

	# 	soggetto.parole.each do |parola|
	# 		commando += 'parole << Word.new(parola.parola, parola.pdd, parola.lemma);'
	# 	end

	# 	commando += 'soggetto = parole'
	# 	# facciamo finta che tutto è un concetto per ora
	# 	# 'subject = Concept.find_by_noun_id(' + soggetto.select { |parola| parola.nome? }.first.nome?.id + '); payload = ' + (payload.nil? ? ' nil; ' : 'Concept.find(' + payload.id.to_s + '); ') + self.method
	# end

	def domanda(soggetto, predicato, complementi = nil)

	end

	def self.carica_coniugazioni(verbo)
		require 'nokogiri'
		require 'open-uri'

		if Verb.where(:infinito => verbo).first.nil? # non esiste ancora
			begin
				v = Verb.new

				v.infinito = verbo

				pagina = Nokogiri::HTML(open('http://www.wordreference.com/conj/itverbs.aspx?v=' + verbo))

				# indicativo presente
				indicativo_presente = pagina.css('.aa td').first(6).map { |td| ActionView::Base.full_sanitizer.sanitize(td.to_s).gsub("\n", "") }

				v.prima_persona_singolare = indicativo_presente[0]
				v.seconda_persona_singolare = indicativo_presente[1]
				v.terza_persona_singolare = indicativo_presente[2]
				v.prima_persona_plurale = indicativo_presente[3]
				v.seconda_persona_plurale = indicativo_presente[4]
				v.terza_persona_plurale = indicativo_presente[5]

				# participio passato
				i = 0

				pagina.css('#cheader > td').each do |td|
					if i == 1
						principali = td.to_s.split('<br>') # infinito, gerundio, part. presente e part. passato

						principali.each_with_index do |coniugazione, i|
							principali[i] = ActionView::Base.full_sanitizer.sanitize(coniugazione).squish
						end

						v.participio_passato = principali[3].split('/').first
					end

					i += 1
				end

				# ausiliare (prendiamo quello usato sul passato prossimo dal sito, non è detto che non ha due ausiliari come 'cominciare')
				passato_prossimo = pagina.css('.aa td').first(30).last(6).map { |td| ActionView::Base.full_sanitizer.sanitize(td.to_s).gsub("\n", "") }

				passato_prossimo.each_with_index do |coniugazione, i|
					passato_prossimo[i] = ActionView::Base.full_sanitizer.sanitize(coniugazione).squish
				end

				if passato_prossimo[0].split.first == 'sono'
					v.ausiliare = 'essere'
				else
					v.ausiliare = 'avere'
				end

				if v.save
					puts 'Verbo caricato'
				else
					puts 'Qualcosa è andato storto'
				end
			rescue
				puts 'Qualcosa è andato storto'
			end
		else
			puts 'Il verbo è già caricato'
		end
	end
end