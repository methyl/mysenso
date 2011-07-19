# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.email "testing@gmail.com"
  f.password "test123"
  f.password_confirmation  "test123"   
  f.association :profession
  f.gender "male"
  f.first_name "Mariusz"
  f.last_name "Kowalski"
  f.phone_number "766112123"
  f.city "Jasło"
  f.portfolio_name "Lapis Lazuri"
  f.birth_date 18.years.ago
  f.height 175
  f.weight 45
  f.waist 60
  f.hips 10
  f.dress 31
  f.shoes 39
  f.pants 10
  f.neck 10
  f.about "Jestem zajebisty"
  f.webpage 'nocuje.net'
  f.courses 'none'
  f.references 'none'
end

