class OrderDerivery
  include ActiveModel::Model
  attr_accessor :postcode, :area_id, :municipality, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '10桁以上11桁以内の半角数字で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postcode: postcode, area_id: area_id, municipality: municipality, address: address,
                    building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
