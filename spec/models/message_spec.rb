require 'rails_helper'

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, {:only => %w[actions]}

DatabaseCleaner.clean

describe Message do
  # RSpec.configure do |config|
  #   config.order_groups_and_examples do |list|
  #     list.sort_by { |item| item.description }
  #   end
  # end

	context "il tulipano è un fiore" do
		puts "il tulipano è un fiore"

		context "alla affermazione <<il tulipano è un fiore>>" do
			messaggio = Message.create(:author => "rspec", :content => "il tulipano è un fiore")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<il tulipano è un fiore?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il tulipano è un fiore?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<i tulipani sono fiori?>>" do
			messaggio = Message.create(:author => "rspec", :content => "i tulipani sono fiori?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<il tulipano è una casa?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il tulipano è una casa?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<è un fiore il tulipano?>>" do
			messaggio = Message.create(:author => "rspec", :content => "è un fiore il tulipano?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<è un tulipano il fiore?>>" do
			messaggio = Message.create(:author => "rspec", :content => "è un tulipano il fiore?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "il fiore è una pianta" do
		puts "il fiore è una pianta"

		context "alla affermazione <<il fiore è una pianta>>" do
			messaggio = Message.create(:author => "rspec", :content => "il fiore è una pianta")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end
	end

	context "il gelsomino è un fiore" do
		puts "il gelsomino è un fiore"

		context "alla affermazione <<il gelsomino è un fiore>>" do
			messaggio = Message.create(:author => "rspec", :content => "il gelsomino è un fiore")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<il gelsomino è un fiore?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il gelsomino è un fiore?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<è un gelsomino il fiore?>>" do
			messaggio = Message.create(:author => "rspec", :content => "è un gelsomino il fiore?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<il gelsomino è una pianta?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il gelsomino è una pianta?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "la città è un luogo" do
		puts "la città è un luogo"

		context "alla affermazione <<la città è un luogo>>" do
			messaggio = Message.create(:author => "rspec", :content => "la città è un luogo")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la città è un luogo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la città è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la città è una nave?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la città è una nave?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "Londra è una città" do
		puts "Londra è una città"

		context "alla affermazione <<Londra è una città>>" do
			messaggio = Message.create(:author => "rspec", :content => "Londra è una città")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Londra è una città?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Londra è una città?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Londra è un albero?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Londra è un albero?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<Londra è un luogo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Londra è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "Recanati è una città" do
		puts "Recanati è una città"

		context "alla affermazione <<Recanati è una città>>" do
			messaggio = Message.create(:author => "rspec", :content => "Recanati è una città")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Recanati è una città?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Recanati è una città?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Recanati è un gatto?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Recanati è un gatto?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<Recanati è un luogo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Recanati è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "la donna è una persona" do
		puts "la donna è una persona"

		context "alla affermazione <<la donna è una persona>>" do
			messaggio = Message.create(:author => "rspec", :content => "la donna è una persona")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la donna è una persona?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la donna è una persona?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la donna è una tazza?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la donna è una tazza?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "la nonna è una donna" do
		puts "la nonna è una donna"

		context "alla affermazione <<la nonna è una donna>>" do
			messaggio = Message.create(:author => "rspec", :content => "la nonna è una donna")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la nonna è una donna?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la nonna è una donna?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la nonna è un pesce?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la nonna è un pesce?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<la nonna è una persona?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la nonna è una persona?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "l'estate è un periodo di tempo" do
		puts "l'estate è un periodo di tempo"

		context "alla affermazione <<l'estate è un periodo di tempo>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'estate è un periodo di tempo")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<l'estate è un periodo di tempo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'estate è un periodo di tempo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<l'estate è un luogo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'estate è un luogo?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "l'edificio è un luogo" do
		puts "l'edificio è un luogo"

		context "alla affermazione <<l'edificio è un luogo>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'edificio è un luogo")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<l'edificio è un luogo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'edificio è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<l'edificio è un periodo di tempo?>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'edificio è un periodo di tempo?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "le case sono edifici" do
		puts "le case sono edifici"

		context "alla affermazione <<le case sono edifici>>" do
			messaggio = Message.create(:author => "rspec", :content => "le case sono edifici")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<le case sono edifici?>>" do
			messaggio = Message.create(:author => "rspec", :content => "le case sono edifici?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la casa è un edificio?>>" do
			messaggio = Message.create(:author => "rspec", :content => "la casa è un edificio?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "il cinema è un edificio" do
		puts "il cinema è un edificio"

		context "alla affermazione <<il cinema è un edificio>>" do
			messaggio = Message.create(:author => "rspec", :content => "il cinema è un edificio")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<il cinema è un edificio?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il cinema è un edificio?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<il cinema è un lago?>>" do
			messaggio = Message.create(:author => "rspec", :content => "il cinema è un lago?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "Claudia ha visto un film al cinema" do
		puts "Claudia ha visto un film al cinema"

		context "alla affermazione <<Claudia ha visto un film al cinema>>" do
			messaggio = Message.create(:author => "rspec", :content => "Claudia ha visto un film al cinema")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Claudia ha visto un film?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Claudia ha visto un film?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Claudia ha visto un film al cinema?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Claudia ha visto un film al cinema?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Claudia ha visto un film al mare?>>" do
			messaggio = Message.create(:author => "rspec", :content => "Claudia ha visto un film al mare?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "l'episodio della notte dei cristalli è avvenuto nel 1938" do
		puts "l'episodio della notte dei cristalli è avvenuto nel 1938"

		context "alla affermazione <<l'episodio della notte dei cristalli è avvenuto nel 1938>>" do
			messaggio = Message.create(:author => "rspec", :content => "l'episodio della notte dei cristalli è avvenuto nel 1938")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end
	end

	context "Claudia ha comprato le scarpe a Londra" do
		puts "Claudia ha comprato le scarpe a Londra"

		context "alla affermazione <<Claudia ha comprato le scarpe a Londra>>" do
			messaggio = Message.create(:author => "rspec", :content => "Claudia ha comprato le scarpe a Londra")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<cosa ha comprato Claudia?>>" do
			messaggio = Message.create(:author => "rspec", :content => "cosa ha comprato Claudia?")

			risposta = messaggio.response

			it "risponde con <<le scarpe>>" do
				expect(risposta).to eq("le scarpe")
			end
		end

		context "alla domanda <<dove?>> subito successiva" do
			messaggio = Message.create(:author => "rspec", :content => "dove?")

			risposta = messaggio.response

			it "risponde con <<a Londra>>" do
				expect(risposta).to eq("a Londra")
			end
		end

		context "alla domanda <<dove ha comprato le scarpe Claudia?>> subito successiva" do
			messaggio = Message.create(:author => "rspec", :content => "dove ha comprato le scarpe Claudia?")

			risposta = messaggio.response

			it "risponde con <<a Londra>>" do
				expect(risposta).to eq("a Londra")
			end
		end
	end
end