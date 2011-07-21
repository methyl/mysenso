# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.email "testing@gmail.com"
  f.password "test123"
  f.password_confirmation  "test123"   
  f.association :profession
  f.gender "male"
  f.first_name "Mariusz"
  f.last_name "Kowalski"
  f.phone_number 766112123
  f.association :region
  f.city "Jasło"
  f.portfolio_name "Lapis Lazuri"
  f.association :ethnicity
  f.association :hair_color
  f.association :eye_color
  f.birth_date 18.years.ago
  f.height 175
  f.weight 45
  f.bra "D"
  f.bust 90
  f.waist 60
  f.hips 90
  f.dress 31
  f.shoes 39
  f.pants 10
  f.neck 10
  f.about "Jestem zajebisty"
  f.association :prefered_region
  f.webpage 'nocuje.net'
  f.courses 'Islandia'
  f.references 'są'
end

