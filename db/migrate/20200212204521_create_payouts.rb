class CreatePayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :payouts do |t|
      t.datetime :dt, null: false, precision: 0
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :phone, null: false
      t.string :client, null: false
      t.integer :destination, null: false
      t.string :receiver_fio, null: false
      t.string :response_payout
      t.string :response_check

      t.timestamps
    end
  end
end
