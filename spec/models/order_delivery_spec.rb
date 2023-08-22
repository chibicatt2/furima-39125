require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題がない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end

      it 'building_name が空でも保存できること' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空では保存できないこと' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号を入力してください','郵便番号は半角のハイフンを含んだ正しい形式で入力してください')
      end

      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_delivery.postcode = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('郵便番号は半角のハイフンを含んだ正しい形式で入力してください')
      end

      it 'area_idが1の場合では出品できない' do
        @order_delivery.area_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('都道府県を入力してください')
      end

      it 'municipalityが空では保存できないこと' do
        @order_delivery.municipality = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('市区町村を入力してください')
      end

      it 'addressが空では保存ができない' do
        @order_delivery.address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('番地を入力してください')
      end

      it 'phone_numberが空では保存ができない' do
        @order_delivery.phone_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号を入力してください','電話番号は10桁以上11桁以内の半角数字で入力してください')
      end

      it 'phone_numberが10桁以上11桁以内の半角数字でないと保存ができない' do
        @order_delivery.phone_number = '０９０１２３４５６７８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数字で入力してください')
      end

      it 'phone_numberが9桁以下では保存ができない' do
        @order_delivery.phone_number = '090123456'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数字で入力してください')
      end

      it 'phone_numberが全角文字では保存ができない' do
        @order_delivery.phone_number = '山田太郎'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('電話番号は10桁以上11桁以内の半角数字で入力してください')
      end

      it 'tokenが空では保存ができないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('クレジットカード情報を入力してください')
      end

      it 'userが紐づいていないと保存ができないこと' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('購入者を入力してください')
      end

      it 'itemが紐づいていないと保存ができないこと' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('購入品を入力してください')
      end
    end
  end
end
