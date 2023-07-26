FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + '1a'}
    password_confirmation { password }
    family_name           { "山田" }
    first_name            { "太郎" }
    family_name_kana      { "ヤマダ" }
    first_name_kana       { "タロウ" }
    date_birth            { Faker::Date.birthday }
  end
end
