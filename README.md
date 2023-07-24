# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null:false                |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| family_name        | string   | null: false               |
| last_name          | string   | null: false               |
| family_name_kana   | string   | null: false               |
| last_name_kana     | string   | null: false               |
| date_birth         | integer  | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | text       | null: false                    |
| explanation     | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| shipping_area   | string     | null: false                    |
| shipping_time   | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- has_one :orders

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- has_one :deliveries

## deliveries

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postalcode    | string     | null: false                    |
| prefecture    | string     | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | text       |                                |
| phone_number  | integer    | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :orders