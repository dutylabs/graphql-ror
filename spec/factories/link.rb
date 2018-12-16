FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end