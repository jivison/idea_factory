FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name + " " + Faker::Name.last_name}
    sequence(:email) { |n| Faker::Internet.email.sub("@", "-#{n}@") }
    password { "hunter2" }
  end
end
