class Delivery < ApplicationRecord
  belongs_to :order

  validates :postcode, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :municipality, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: '10桁以上11桁以内の半角数字で入力してください'}
  
  
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :area_id
  end

end
