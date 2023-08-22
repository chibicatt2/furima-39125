require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できる場合' do
      it 'image,name,explanation,category_id,condition_id,charge_id,area_id,shipping_date_id,priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を入力してください')
      end

      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end

      it 'explanationが空では出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end

      it 'category_idが1の場合では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end

      it 'condition_idが1の場合では出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end

      it 'charge_idが1の場合では出品できない' do
        @item.charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end

      it 'area_idが1の場合では出品できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end

      it 'shipping_date_idが1の場合では出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('価格を入力してください','価格は半角数字で入力してください','価格は数値で入力してください')
      end

      it 'priceが300円未満では出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end

      it 'priceが10,000,000円以上では出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end

      it 'priceが全角数値では出品できない' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('出品者を入力してください')
      end
    end
  end
end
