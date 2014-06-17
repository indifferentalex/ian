if frase.tipo == 'dichiarazione' then 
	# se entrambi sono sostantivi allora il tipo di legame è per forza di tipo 'è-un' (is-a)
	if (frase.soggetti.first.lemma.nome?) && (frase.predicati.first.lemma_nome_del_predicato.nome?) then
		concetto_soggetto = Concept.find_by_noun_id(frase.soggetti.first.lemma.nome?.id);
		concetto_nome_del_predicato = Concept.find_by_noun_id(frase.predicati.first.lemma_nome_del_predicato.nome?.id);

		# cerca legami preesistenti
		bond = Bond.where(concetto_1_id: [concetto_soggetto.id, concetto_nome_del_predicato.id], concetto_2_id: [concetto_soggetto.id, concetto_nome_del_predicato.id]).first;

		if bond then
			puts bond.id;
		else
			bond = Bond.new(:concetto_1_id => concetto_soggetto.id, :concetto_2_id => concetto_nome_del_predicato.id, :tipo => 'is-a');
			bond.save;
			puts bond.id;
		end;
	end;
end;

if frase.tipo == 'dichiarazione' then if (frase.soggetti.first.lemma.nome?) && (frase.predicati.first.lemma_nome_del_predicato.nome?) then concetto_soggetto = Concept.find_by_noun_id(frase.soggetti.first.lemma.nome?.id); concetto_nome_del_predicato = Concept.find_by_noun_id(frase.predicati.first.lemma_nome_del_predicato.nome?.id); bond = Bond.where(concetto_1_id: [concetto_soggetto.id, concetto_nome_del_predicato.id], concetto_2_id: [concetto_soggetto.id, concetto_nome_del_predicato.id]).first; if bond then puts bond.id else bond = Bond.new(:concetto_1_id => concetto_soggetto.id, :concetto_2_id => concetto_nome_del_predicato.id, :tipo => 'is-a'); bond.save; puts bond.id; end; end; end;
