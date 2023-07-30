class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :area
  belongs_to :time
  belongs_to :user
  has_one_attached :image

  validates :name, :explanation, presence: true

  validates :category_id, :condition_id, :charge_id, :area_id, :time_id, numericality: { other_than: 1 , message: "can't be blank"}

  with_options presence: true, format: { with: /\A[0-9]+\z/, message: '半角数字で入力してください' } do
    validates :price
  end
end
