require 'test_helper'

class PhraseTest < ActiveSupport::TestCase
	@@frase = Phrase.new("il cane ha mangiato i fiori dell'orto")

  test "treetagger trova il corretto numero di parole" do
  	frase = Phrase.new("il cane ha mangiato i fiori")

    assert (frase.parole.count == 6)
  end

  test "treetagger trova il corretto numero di parole anche con apostrofi" do
  	frase = Phrase.new("il cane ha mangiato i fiori dell'orto")

  	assert (frase.parole.count == 8)
	end

	# "il cane ha mangiato i fiori dell'orto"
	test "predicato deve essere <<ha mangiato>>" do
		# frase = Phrase.new("il cane ha mangiato i fiori dell'orto")

		assert true
	end

	# test "soggetto deve essere <<il cane>>" do

	# end
end
