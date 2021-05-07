# encoding: UTF-8
# frozen_string_literal: true

require 'peatio/import_blockchain_currency_wallet'

module API
  module V2
    module Admin
      class ImportBlockchainCurrencyWallets < Grape::API

        desc 'Import currency, blockchain and wallet from json file'
        params do
          requires :file,
                   type: File
        end
        post '/import_blockchain_currency_wallets' do
          Peatio::ImportBlockchainCurrencyWallet.new.process(params)
          present(result: 'Importing of currency, blockchain and wallet is starting')
        end
      end
    end
  end
end

