require "rails_helper"

describe Phrase do
  context "il cane ha mangiato i fiori" do
  	frase = Phrase.new("il cane ha mangiato i fiori")

  	frase.raggruppa_parole

  	frase.trova_predicati

  	frase.trova_soggetti

    frase.trova_complementi

    it "ha 6 parole" do
    	expect(frase.parole.count).to eq(6)
    end

    it "ha 3 gruppi grammaticali" do
    	expect(frase.gruppi.count).to eq(3)
 		end	

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come predicato <<ha mangiato>>" do
    	expect(frase.predicati.first.ugualianza_parole("ha mangiato")).to eq(true)
    end

    it "ha come soggetto <<il cane>>" do
    	expect(frase.soggetti.first.ugualianza_parole("il cane")).to eq(true)
    end
  end

  context "il cane è morto" do
  	frase = Phrase.new("il cane è morto")

  	frase.raggruppa_parole

  	frase.trova_predicati

  	frase.trova_soggetti

    it "ha 4 parole" do
    	expect(frase.parole.count).to eq(4)
    end

    it "ha 2 gruppi grammaticali" do
    	expect(frase.gruppi.count).to eq(2)
 		end	

    it "ha come predicato <<è morto>>" do
    	expect(frase.predicati.first.ugualianza_parole("è morto")).to eq(true)
    end

    it "ha come soggetto <<il cane>>" do
    	expect(frase.soggetti.first.ugualianza_parole("il cane")).to eq(true)
    end
  end

  context "Dio è morto" do
    frase = Phrase.new("Dio è morto")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    it "ha 3 parole" do
      expect(frase.parole.count).to eq(3)
    end

    it "ha 2 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(2)
    end 

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come predicato <<è morto>>" do
      expect(frase.predicati.first.ugualianza_parole("è morto")).to eq(true)
    end

    it "ha come soggetto <<Dio>>" do
      expect(frase.soggetti.first.ugualianza_parole("Dio")).to eq(true)
    end
  end

  context "è morto il cane" do
  	frase = Phrase.new("è morto il cane")

  	frase.raggruppa_parole

  	frase.trova_predicati

  	frase.trova_soggetti

    it "ha 4 parole" do
    	expect(frase.parole.count).to eq(4)
    end

    it "ha 2 gruppi grammaticali" do
    	expect(frase.gruppi.count).to eq(2)
 		end	

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come predicato <<è morto>>" do
    	expect(frase.predicati.first.ugualianza_parole("è morto")).to eq(true)
    end

    it "ha come soggetto <<il cane>>" do
    	expect(frase.soggetti.first.ugualianza_parole("il cane")).to eq(true)
    end
  end

  context "la città è un luogo" do
  	frase = Phrase.new("la città è un luogo")

  	frase.raggruppa_parole

  	frase.trova_predicati

  	frase.trova_soggetti

    it "ha 5 parole" do
    	expect(frase.parole.count).to eq(5)
    end

    it "ha 2 gruppi grammaticali" do
    	expect(frase.gruppi.count).to eq(2)
 		end	

    it "ha un predicato nominale" do
      expect(frase.predicati.first.tipo).to eq('nominale')
    end

    it "ha come predicato <<è un luogo>>" do
    	expect(frase.predicati.first.ugualianza_parole("è un luogo")).to eq(true)
    end

    it "ha come soggetto <<la città>>" do
    	expect(frase.soggetti.first.ugualianza_parole("la città")).to eq(true)
    end
  end

  context "la seconda guerra mondiale è cominciata nel 1939" do
    frase = Phrase.new("la seconda guerra mondiale è cominciata nel 1939")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 8 parole" do
      expect(frase.parole.count).to eq(8)
    end

    it "ha 3 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(3)
    end 

    it "ha come predicato <<è cominciata>>" do
      expect(frase.predicati.first.ugualianza_parole("è cominciata")).to eq(true)
    end

    it "ha come soggetto <<la seconda guerra mondiale>>" do
      expect(frase.soggetti.first.ugualianza_parole("la seconda guerra mondiale")).to eq(true)
    end

    it "ha un unico complemento" do
      expect(frase.complementi.count).to eq(1)
    end
  end

  context "Londra è una grande città" do
    frase = Phrase.new("Londra è una grande città")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 5 parole" do
      expect(frase.parole.count).to eq(5)
    end

    it "ha 2 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(2)
    end 

    it "ha come predicato <<è una grande città>>" do
      expect(frase.predicati.first.ugualianza_parole("è una grande città")).to eq(true)
    end

    it "ha come soggetto <<Londra>>" do
      expect(frase.soggetti.first.ugualianza_parole("Londra")).to eq(true)
    end

    it "il soggetto ha come lemma <<Londra>>" do
      expect(frase.soggetti.first.limma).to eq('Londra')
    end

    it "ha zero complementi" do
      expect(frase.complementi.count).to eq(0)
    end
  end

  context "Claudia è andata a Londra" do
    frase = Phrase.new("Claudia è andata a Londra")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 5 parole" do
      expect(frase.parole.count).to eq(5)
    end

    it "ha 3 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(3)
    end 

    it "ha come predicato <<è andata>>" do
      expect(frase.predicati.first.ugualianza_parole("è andata")).to eq(true)
    end

    it "ha come soggetto <<Claudia>>" do
      expect(frase.soggetti.first.ugualianza_parole("Claudia")).to eq(true)
    end

    it "ha un unico complemento" do
      expect(frase.complementi.count).to eq(1)
    end

    it "ha un complemento di luogo" do
      expect(frase.complementi.last.tipo).to eq('luogo')
    end
  end

  context "Claudia è passata per la città" do
    frase = Phrase.new("Claudia è passata per la città")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 6 parole" do
      expect(frase.parole.count).to eq(6)
    end

    it "ha 3 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(3)
    end 

    it "ha come predicato <<è passata>>" do
      expect(frase.predicati.first.ugualianza_parole("è passata")).to eq(true)
    end

    it "ha come soggetto <<Claudia>>" do
      expect(frase.soggetti.first.ugualianza_parole("Claudia")).to eq(true)
    end

    it "ha un unico complemento" do
      expect(frase.complementi.count).to eq(1)
    end
  end

  context "Claudia è andata a Londra per dieci giorni" do
    frase = Phrase.new("Claudia è andata a Londra per dieci giorni")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 8 parole" do
      expect(frase.parole.count).to eq(8)
    end

    it "ha 4 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(4)
    end 

    it "ha come predicato <<è andata>>" do
      expect(frase.predicati.first.ugualianza_parole("è andata")).to eq(true)
    end

    it "ha come soggetto <<Claudia>>" do
      expect(frase.soggetti.first.ugualianza_parole("Claudia")).to eq(true)
    end

    it "ha due complementi" do
      expect(frase.complementi.count).to eq(2)
    end
  end

  context "Giacomo Leopardi è nato a Recanati nel 1798" do
    frase = Phrase.new("Giacomo Leopardi è nato a Recanati nel 1798")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 8 parole" do
      expect(frase.parole.count).to eq(8)
    end

    it "ha 4 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(4)
    end 

    it "ha come predicato <<è nato>>" do
      expect(frase.predicati.first.ugualianza_parole("è nato")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<Giacomo Leopardi>>" do
      expect(frase.soggetti.first.ugualianza_parole("Giacomo Leopardi")).to eq(true)
    end

    it "ha come primo complemento un complemento di luogo" do
      expect(frase.complementi[0].tipo).to eq('luogo')
    end

    it "ha come secondo complemento un complemento di tempo" do
      expect(frase.complementi[1].tipo).to eq('tempo')
    end
  end

  context "Claudia è andata a Londra d'estate" do
    frase = Phrase.new("Claudia è andata a Londra d'estate")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 7 parole" do
      expect(frase.parole.count).to eq(7)
    end

    it "ha 4 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(4)
    end 

    it "ha come predicato <<è andata>>" do
      expect(frase.predicati.first.ugualianza_parole("è andata")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<Claudia>>" do
      expect(frase.soggetti.first.ugualianza_parole("Claudia")).to eq(true)
    end

    it "ha due complementi" do
      expect(frase.complementi.count).to eq(2)
    end

    it "ha come primo complemento un complemento di luogo" do
      expect(frase.complementi[0].tipo).to eq('luogo')
    end

    it "ha come secondo complemento un complemento di tempo" do
      expect(frase.complementi[1].tipo).to eq('tempo')
    end
  end

  context "i biscotti sono stati mangiati dalla nonna" do
    frase = Phrase.new("i biscotti sono stati mangiati dalla nonna")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 7 parole" do
      expect(frase.parole.count).to eq(7)
    end

    it "ha 3 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(3)
    end 

    it "ha come predicato <<sono stati mangiati>>" do
      expect(frase.predicati.first.ugualianza_parole("sono stati mangiati")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<i biscotti>>" do
      expect(frase.soggetti.first.ugualianza_parole("i biscotti")).to eq(true)
    end

    it "ha un unico complemento" do
      expect(frase.complementi.count).to eq(1)
    end

    it "ha come primo e unico complemento un complemento di agente" do
      expect(frase.complementi[0].tipo).to eq('agente')
    end
  end

  context "il libro sta sul tavolo" do
    frase = Phrase.new("il libro sta sul tavolo")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 5 parole" do
      expect(frase.parole.count).to eq(5)
    end

    it "ha 3 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(3)
    end 

    it "ha come predicato <<sta>>" do
      expect(frase.predicati.first.ugualianza_parole("sta")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<il libro>>" do
      expect(frase.soggetti.first.ugualianza_parole("il libro")).to eq(true)
    end

    it "ha un unico complemento" do
      expect(frase.complementi.count).to eq(1)
    end

    it "ha come primo e unico complemento un complemento di luogo" do
      expect(frase.complementi[0].tipo).to eq('luogo')
    end
  end

  context "il cane di Claudia ha mangiato il gelato" do
    frase = Phrase.new("il cane di Claudia ha mangiato il gelato")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 8 parole" do
      expect(frase.parole.count).to eq(8)
    end

    it "ha 4 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(4)
    end 

    it "ha come predicato <<ha mangiato>>" do
      expect(frase.predicati.first.ugualianza_parole("ha mangiato")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<il cane>>" do
      expect(frase.soggetti.first.ugualianza_parole("il cane")).to eq(true)
    end

    it "ha due complementi" do
      expect(frase.complementi.count).to eq(2)
    end

    it "ha come primo complemento un complemento di specificazione" do
      expect(frase.complementi[0].tipo).to eq('specificazione')
    end

    it "ha come secondo complemento un complemento oggetto" do
      expect(frase.complementi[1].tipo).to eq('oggetto')
    end
  end

  context "l'estate è un periodo di tempo" do
    frase = Phrase.new("l'estate è un periodo di tempo")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 7 parole" do
      expect(frase.parole.count).to eq(7)
    end

    it "ha 2 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(2)
    end 

    it "ha come predicato <<è un periodo di tempo>>" do
      expect(frase.predicati.first.ugualianza_parole("è un periodo di tempo")).to eq(true)
    end

    it "ha un predicato nominale" do
      expect(frase.predicati.first.tipo).to eq('nominale')
    end

    it "ha come soggetto <<l'estate>>" do
      expect(frase.soggetti.first.ugualianza_parole("l'estate")).to eq(true)
    end

    it "ha zero complementi" do
      expect(frase.complementi.count).to eq(0)
    end
  end

  context "Claudia ha visto un film al cinema" do
    frase = Phrase.new("Claudia ha visto un film al cinema")

    frase.raggruppa_parole

    frase.trova_predicati

    frase.trova_soggetti

    frase.trova_complementi

    it "ha 7 parole" do
      expect(frase.parole.count).to eq(7)
    end

    it "ha 4 gruppi grammaticali" do
      expect(frase.gruppi.count).to eq(4)
    end 

    it "ha come predicato <<ha visto>>" do
      expect(frase.predicati.first.ugualianza_parole("ha visto")).to eq(true)
    end

    it "ha un predicato verbale" do
      expect(frase.predicati.first.tipo).to eq('verbale')
    end

    it "ha come soggetto <<Claudia>>" do
      expect(frase.soggetti.first.ugualianza_parole("Claudia")).to eq(true)
    end

    it "ha 2 complementi" do
      expect(frase.complementi.count).to eq(2)
    end

    it "ha come primo complemento un complemento oggetto" do
      expect(frase.complementi[0].tipo).to eq('oggetto')
    end

    it "ha come secondo complemento un complemento di luogo" do
      expect(frase.complementi[1].tipo).to eq('luogo')
    end
  end
end