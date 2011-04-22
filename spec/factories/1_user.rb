Factory.define :user do |u|
  u.email "teste@teste.com"
  u.name "Teste"
  u.password "teste123"
  u.password_confirmation "teste123"
end

Factory.define :other, :class => User do |u|
  u.email "other@teste.com"
  u.name "Other"
  u.password "teste123"
  u.password_confirmation "teste123"
end