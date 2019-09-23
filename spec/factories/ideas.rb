FactoryBot.define do
  factory :idea do
    title { Faker::Hacker.say_something_smart }
    description { Faker::TvShows::MichaelScott.quote }

    user
  end
end
