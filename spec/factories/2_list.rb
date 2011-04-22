Factory.define :list do |l|
  l.user Factory.build(:user)
  l.name "Coisas a fazer"
  l.public true
end