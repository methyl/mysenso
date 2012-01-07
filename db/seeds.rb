# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
  Factory :profession, :name => 'Modelka / Model', :type => 1
  ['Fotograf', 'Fryzjer', 'Wizażysta', 'Stylista mody', 'Projektant'].each {|name| Factory :profession, :name => name, :type => 2 }
  Factory :profession, :name => 'Hostessa / Host', :type => 3
  Factory :profession, :name => 'Agencja', :type => 4

  ['Fashion', 'Portret', 'Glamour', 'Bielizna', 'Strój kąpielowy', 'Komercyjne', 'Akt'].each {|name| Factory :discipline, :name => name, :profession_types => [1,2]}
  ['Hostessa / Host', 'Wybieg', 'Taniec'].each {|name| Factory :discipline, :name => name, :profession_types => [1]}
  ['do supermarketów', 'na promocje', 'na targi', 'tłumaczki', 'do sklepów', 'na imprezy', 'na bankiety'].each {|name| Factory :discipline, :name => name, :profession_types => [3]}

  ['dolnośląskie', 'kujawsko-pomorskie','lubelskie','lubuskie','łódzkie','małopolskie','mazowieckie','opolskie','podkarpackie','podlaskie','pomorskie','śląskie','świętokrzyskie','warmińsko-mazurskie','wielkopolskie','zachodniopomorskie'].each {|name| Factory :region, :name => name }
  ['afrykańskie korzenie', 'południowoazjatyckie', 'bliskowschodnie', 'chińskie', 'latynoskie', 'europejskie', 'inne'].each {|name| Factory :ethnicity, :name => name }

  ['brązowe','szare','jasnoniebieskie','niebieskie','zielone','czarne','ciemnobrązowe', 'jasnobrązowe','inne'].each {|name| Factory :eye_color, :name => name }
  ['blond','brązowe', 'ciemne', 'ciemnobrązowe', 'ciemny blond','czarne', 'jasnobrązowe', 'jasny blond','kasztanowe', 'platynowy blond', 'rudawy blond', 'rudawy brąz', 'rude', 'szare','inne'].each {|name| Factory :hair_color, :name => name}

  ['województwo','cała Polska', 'cały świat'].each {|name| Factory :prefered_region, :name => name}

  ['polski', 'angielski', 'niemiecki', 'francuski', 'rosyjski'].each {|name| Factory :language, :name => name}

  ['w dni powszednie od poniedziałku do piątku', 'w weekendy', 'pełna dyspozycyjność (24h)', 'prawo jazdy','samochód'].each {|name| Factory :availability, :name => name}

  ['A','A75','B','B75','C','C75','D','D75','E'].each {|name| Factory :bra, :name => name }

  cities = File.new(File.join(::Rails.root, "db", "cities_list_short.txt"))
  cities.each do |city|
    City.create(:name => city.strip)
  end
  
  AdminUser.create(:email => 'lucjansuski@gmail.com', :password => 'niepowiem', :password_confirmation => 'niepowiem')


  
