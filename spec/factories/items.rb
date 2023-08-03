FactoryBot.define do
  factory :item do
    name             { 'テスト商品' }
    explanation      { 'これはテスト商品です。' }
    category_id      { 2 }
    condition_id     { 2 }
    charge_id        { 3 }
    area_id          { 14 }
    shipping_date_id { 3 }
    price            { 2000 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
