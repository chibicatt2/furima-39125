require 'rails_helper'

RSpec.describe OrderDerivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    order = FactoryBot.create(:order)
    @order_derivery = FactoryBot.build(:order_derivery, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_derivery).to be_valid
      end

      it 'building_name が空でも保存できること' do
        @order_derivery.building_name = ''
        expect(@order_derivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_derivery.postcode = ''
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Postcode can't be blank")
      end

      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_derivery.postcode = '1234567'
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end

      it 'area_idが1の場合では出品できない' do
        @order_derivery.area_id = 1
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Area can't be blank")
      end

      it 'municipalityが空では保存できないこと' do
        @order_derivery.municipality = ''
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空では保存ができない' do
        @order_derivery.address = ''
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが10桁以上11桁以内の半角数字でないと保存ができない' do
        @order_derivery.phone_number = '０９０１２３４５６７８'
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include('Phone number 10桁以上11桁以内の半角数字で入力してください')
      end

      it 'tokenが空では保存ができないこと' do
        @order_derivery.token = nil
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐づいていないと保存ができないこと' do
        @order_derivery.user_id = nil
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていないと保存ができないこと' do
        @order_derivery.item_id = nil
        @order_derivery.valid?
        expect(@order_derivery.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
