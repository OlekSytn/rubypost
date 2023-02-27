FactoryBot.define do
  factory :member do
    name { 'username' }
    email { 'member@blog.com' }
    password { 'password' }
    confirmed_at { Time.now }
  end
end
