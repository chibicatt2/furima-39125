FactoryBot.define do
  factory :order_derivery do
    postcode         { '123-4567' }
    area_id          { 14 }
    municipality     { '新宿区'}
    address          { '1-1' }
    building_name    { '新宿ハイツ' }
    phone_number     { '09012345678'}
  end
end
