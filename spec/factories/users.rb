FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + '1a'}
    password_confirmation { password }
    family_name           { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    family_name_kana      { Faker::Name.initials(number: 2) }
    first_name_kana       { Faker::Name.initials(number: 2) }
    date_birth            { Faker::Date.birthday }
  end
end
