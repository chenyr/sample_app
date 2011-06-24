#By using the symbol ':user', we get Factory Girl to simulate the User model. 
Factory.define :user do |user|
  user.name                   "Foo Bar"
  user.email                  "FooBar@foobar.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end