# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.email "testing@gmail.com"
  f.password "test123"
  f.password_confirmation  "test123"   
  f.association :profession
  f.gender "male"
end

