# frozen_string_literal: true

module API
  module V2
    module Entities
      class BlockchainCurrency < Base
        expose(
          :blockchain_key,
          documentation:{
            type: String,
            desc: 'Unique key to identify blockchain.'
          }
        )

        expose(
          :currency_id,
          documentation:{
            type: String,
            desc: 'Unique id to identify currency.'
          }
        )

        expose(
          :deposit_enabled,
          documentation: {
            type: String,
            desc: 'Blockchain currency deposit possibility status (true/false).'
          }
        )

        expose(
          :withdrawal_enabled,
          documentation: {
            type: String,
            desc: 'Blockchain currency withdrawal possibility status (true/false).'
          }
        )

        expose(
          :deposit_fee,
          documentation: {
            desc: 'Blockchain currency deposit fee',
            example: -> { ::BlockchainCurrency.enabled.first.deposit_fee }
          }
        )

        expose(
          :min_deposit_amount,
          documentation: {
            desc: 'Minimal deposit amount',
            example: -> { ::BlockchainCurrency.enabled.first.min_deposit_amount }
          }
        )

        expose(
          :withdraw_fee,
          documentation: {
            desc: 'Blockchain currency withdraw fee',
            example: -> { ::BlockchainCurrency.enabled.first.withdraw_fee }
          }
        )

        expose(
          :min_withdraw_amount,
          documentation: {
            desc: 'Minimal withdraw amount',
            example: -> { ::BlockchainCurrency.enabled.first.min_withdraw_amount }
          }
        )

        expose(
          :withdraw_limit_24h,
          documentation: {
            desc: 'Blockchain currency 24h withdraw limit',
            example: -> { ::BlockchainCurrency.enabled.first.withdraw_limit_24h }
          }
        )

        expose(
          :withdraw_limit_72h,
          documentation: {
            desc: 'Blockchain currency 72h withdraw limit',
            example: -> { ::BlockchainCurrency.enabled.first.withdraw_limit_72h }
          }
        )

        expose(
          :base_factor,
          documentation: {
            desc: 'Blockchain currency base factor',
            example: -> { ::BlockchainCurrency.enabled.first.base_factor }
          }
        )

        expose(
          :explorer_transaction,
          documentation: {
            desc: 'Blockchain currency transaction exprorer url template',
            example: 'https://testnet.blockchain.info/tx/'
          },
          if: -> (blockchain_currency){ blockchain_currency.currency.coin? }
        )

        expose(
          :explorer_address,
          documentation: {
            desc: 'Blockchain currency address exprorer url template',
            example: 'https://testnet.blockchain.info/address/'
          },
          if: -> (blockchain_currency){ blockchain_currency.currency.coin? }
        )

        expose(
          :min_confirmations,
          if: ->(blockchain_currency) { blockchain_currency.currency.coin? },
          documentation: {
            desc: 'Number of confirmations required for confirming deposit or withdrawal'
          }
        ) { |blockchain_currency| blockchain_currency.blockchain.min_confirmations }
      end
    end
  end
end
