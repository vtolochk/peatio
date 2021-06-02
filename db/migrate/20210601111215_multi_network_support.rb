class MultiNetworkSupport < ActiveRecord::Migration[5.2]
  def change
    # Add network table
    create_table :blockchain_currencies do |t|
      t.string :currency_id, foreign_key: true, class: 'Currency', null: false
      t.string :blockchain_key, foreign_key: true, class: 'Blockchain'
      t.decimal :deposit_fee, precision: 32, scale: 16, default: 0, null: false
      t.decimal :min_deposit_amount, precision: 32, scale: 16, default: 0, null: false
      t.decimal :min_collection_amount, precision: 32, scale: 16, default: 0, null: false
      t.decimal :withdraw_fee, precision: 32, scale: 16, default: 0, null: false
      t.decimal :min_withdraw_amount, precision: 32, scale: 16, default: 0, null: false
      t.decimal :withdraw_limit_24h, precision: 32, scale: 16, default: 0, null: false
      t.decimal :withdraw_limit_72h, precision: 32, scale: 16, default: 0, null: false
      t.boolean :deposit_enabled, default: true, null: false
      t.boolean :withdrawal_enabled, default: true, null: false
      t.bigint :base_factor, default: 1, null: false
      t.string :status, limit: 32, null: false, default: 'enabled'
      t.json :options
      t.timestamps
    end

    # TODO
    # Migrate from currencies to blockchain_currencies

    # Remove redundant currencies fields
    ActiveRecord::Base.transaction do
      remove_column :currencies, :blockchain_key, :string
      remove_column :currencies, :deposit_fee, :decimal
      remove_column :currencies, :min_deposit_amount, :decimal
      remove_column :currencies, :min_collection_amount, :decimal
      remove_column :currencies, :withdraw_fee, :decimal
      remove_column :currencies, :min_withdraw_amount, :decimal
      remove_column :currencies, :withdraw_limit_24h, :decimal
      remove_column :currencies, :withdraw_limit_72h, :decimal
      remove_column :currencies, :options, :json
      remove_column :currencies, :visible, :boolean
      remove_column :currencies, :base_factor, :bigint
      remove_column :currencies, :deposit_enabled, :boolean
      remove_column :currencies, :withdrawal_enabled, :boolean
    end
    add_column :currencies, :status, :string, limit: 32, null: false, after: :type

    # Add blockchain key to deposits/withdraws/payment_addresses/beneficiaries tables
    %i[deposits withdraws beneficiaries].each do |t|
      add_column t, :blockchain_key, :string, after: :currency_id
    end
    # TODO
    # Change blockchain_keys for processiong deposits and withdraws
    add_column :payment_addresses, :blockchain_key, :string, after: :wallet_id


    # TODO
    # Change with batch
    PaymentAddress.all.each { |payment| payment.update(blockchain_key: payment.wallet.blockchain_key) }


    # Add new field to blockchain table
    add_column :blockchains, :description, :text, after: :height
    add_column :blockchains, :warning, :string, after: :description
    add_column :blockchains, :protocol, :string, after: :warning
  end
end
