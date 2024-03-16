FactoryBot.define do
  factory :user do
    email { 'default-email' }
    password_digest { 'password' }
  end
end
