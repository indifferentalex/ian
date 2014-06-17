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
		context "alla affermazione <<il tulipano è un fiore>>" do
			messaggio = Message.new(:author => "rspec", :content => "il tulipano è un fiore")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<il tulipano è un fiore?>>" do
			messaggio = Message.new(:author => "rspec", :content => "il tulipano è un fiore?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<il tulipano è una casa?>>" do
			messaggio = Message.new(:author => "rspec", :content => "il tulipano è una casa?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<è un fiore il tulipano?>>" do
			messaggio = Message.new(:author => "rspec", :content => "è un fiore il tulipano?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<è un tulipano il fiore?>>" do
			messaggio = Message.new(:author => "rspec", :content => "è un tulipano il fiore?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "la città è un luogo" do
		context "alla affermazione <<la città è un luogo>>" do
			messaggio = Message.new(:author => "rspec", :content => "la città è un luogo")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la città è un luogo?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la città è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la città è una nave?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la città è una nave?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "Londra è una città" do
		context "alla affermazione <<Londra è una città>>" do
			messaggio = Message.new(:author => "rspec", :content => "Londra è una città")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Londra è una città?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Londra è una città?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Londra è un albero?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Londra è un albero?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<Londra è un luogo?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Londra è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "Recanati è una città" do
		context "alla affermazione <<Recanati è una città>>" do
			messaggio = Message.new(:author => "rspec", :content => "Recanati è una città")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Recanati è una città?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Recanati è una città?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Recanati è un gatto?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Recanati è un gatto?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<Recanati è un luogo?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Recanati è un luogo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "la donna è una persona" do
		context "alla affermazione <<la donna è una persona>>" do
			messaggio = Message.new(:author => "rspec", :content => "la donna è una persona")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la donna è una persona?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la donna è una persona?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la donna è una tazza?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la donna è una tazza?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "la nonna è una donna" do
		context "alla affermazione <<la nonna è una donna>>" do
			messaggio = Message.new(:author => "rspec", :content => "la nonna è una donna")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<la nonna è una donna?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la nonna è una donna?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<la nonna è un pesce?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la nonna è un pesce?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end

		context "alla domanda <<la nonna è una persona?>>" do
			messaggio = Message.new(:author => "rspec", :content => "la nonna è una persona?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end
	end

	context "l'estate è un periodo di tempo" do
		context "alla affermazione <<l'estate è un periodo di tempo>>" do
			messaggio = Message.new(:author => "rspec", :content => "l'estate è un periodo di tempo")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<l'estate è un periodo di tempo?>>" do
			messaggio = Message.new(:author => "rspec", :content => "l'estate è un periodo di tempo?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<l'estate è un luogo?>>" do
			messaggio = Message.new(:author => "rspec", :content => "l'estate è un luogo?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end

	context "Claudia ha visto un film al cinema" do
		context "alla affermazione <<Claudia ha visto un film al cinema>>" do
			messaggio = Message.new(:author => "rspec", :content => "Claudia ha visto un film al cinema")

			risposta = messaggio.response

			it "risponde con <<okay>>" do
				expect(risposta).to eq("okay")
			end
		end

		context "alla domanda <<Claudia ha visto un film al cinema?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Claudia ha visto un film al cinema?")

			risposta = messaggio.response

			it "risponde con <<si>>" do
				expect(risposta).to eq("si")
			end
		end

		context "alla domanda <<Claudia ha visto un film al mare?>>" do
			messaggio = Message.new(:author => "rspec", :content => "Claudia ha visto un film al mare?")

			risposta = messaggio.response

			it "risponde con <<no>>" do
				expect(risposta).to eq("no")
			end
		end
	end
end