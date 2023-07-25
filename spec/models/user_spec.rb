require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do

      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do

      end
      it "emailが空では登録できない" do

      end
      it "passwordが空では登録できない" do

      end
    end
  end
end
