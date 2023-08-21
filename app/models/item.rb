class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :area
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, presence: true
  validates :name, presence: true
  validates :explanation, presence: true

  with_options numericality: { other_than: 1, message: 'を入力してください' } do
    validates :category_id
    validates :condition_id
    validates :charge_id
    validates :area_id
    validates :shipping_date_id
  end

  with_options presence: true, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end
