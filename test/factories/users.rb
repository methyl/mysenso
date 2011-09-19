# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.login "testing"
  f.email 'testing@gmail.com'
  f.password "test123"
  f.password_confirmation "test123"   
  f.gender "male"
  f.first_name "Mariusz"
  f.last_name "Kowalski"
  f.phone_number 766112123
  f.association :profession, :type => 2
  f.association :region
  f.city "Jasło"
  f.about "Coś o mnie"
  f.association :prefered_region
  f.webpage 'nocuje.net'
  f.courses 'Kurs w Islandii czy cośtam'
  f.birth_date 18.years.ago+6.months
end

Factory.define :male_model, :parent => :user do |f|
  f.login 'male_model'
  f.email 'male_model@gmail.com'
  f.association :ethnicity
  f.association :hair_color
  f.association :eye_color
  f.height 175
  f.weight 45
  f.waist 60
  f.hips 90
  f.dress 31
  f.shoes 39
  f.pants 10
  f.neck 10
end

Factory.define :female_model, :parent => :user do |f|
  f.login 'female_model'
  f.email 'female_model@gmail.com'
  f.first_name 'Anna'
  f.last_name 'Kowalska'
  f.gender 'female'
  f.association :ethnicity
  f.association :hair_color
  f.association :eye_color
  f.height 175
  f.weight 45
  f.bust 90
  f.waist 60
  f.hips 90
  f.dress 31
  f.shoes 39
  f.association :bra
end

Factory.define :female_host, :parent => :user do |f|
  f.login 'female_host'
  f.email 'female_host@gmail.com'
  f.first_name 'Anna'
  f.last_name 'Kowalska'
  f.gender 'female'
  f.association :ethnicity
  f.association :hair_color
  f.association :eye_color
  f.height 175
  f.weight 45
  f.bust 90
  f.waist 60
  f.hips 90
  f.dress 31
  f.shoes 39
  f.pants 10
  f.neck 10
  f.association :bra
  f.association :profession, :name => 'Host / Hostessa', :type => 3
end

Factory.define :male_host, :parent => :user do |f|
  f.login 'male_host'
  f.email 'male_host@gmail.com'
  f.first_name 'Mariusz'
  f.last_name 'Kowalski'
  f.gender 'male'
  f.association :ethnicity
  f.association :hair_color
  f.association :eye_color
  f.height 175
  f.weight 45
  f.waist 60
  f.hips 90
  f.dress 31
  f.shoes 39
  f.pants 10
  f.neck 10
  f.association :profession, :name => 'Host / Hostessa', :type => 3
end

Factory.define :photographer, :parent => :user do |f|
  f.login 'photographer'
  f.email 'photographer@gmail.com'
  f.association :profession, :name => 'Fotograf', :type => 2
end
