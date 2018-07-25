sentence = 'i cani sono verdi.'

cmd = "echo '" + sentence + "' | /Users/alexvlasov/Code/tree-tagger/cmd/tree-tagger-italian" # /Users/alex/development/treetagger/cmd/tree-tagger-italian"

value = `#{cmd}`

result = value.split

result.each_with_index do |row, i|
	if i % 3 == 0
		puts row
	end
end
