# frozen_string_literal: true

module API
  module V2
    class ImportConfigHelpers
      def process(params)
        JSON.parse(params[:file][:tempfile], :headers => true, quote_empty: false).each do |row|
          type = row[0]
          data = row[1]
          next unless type

          data.each do |record|
            record = record.compact.symbolize_keys!
            case type
            when "blockchains"
              ::Blockchain.create!(record) unless ::Blockchain.find_by(key: record[:key])
            when "currencies"
              Currency.create!(record) unless Currency.find_by(code: record[:id])
            when "wallets"
              ::Wallet.create!(record) unless ::Wallet.find_by(blockchain_key: record[:blockchain_key], kind: record[:kind])
            end
          rescue StandardError => e
            Rails.logger.error { e.message }
          end
        rescue StandardError => e
          Rails.logger.error { e.message }
        end
      end
    end
  end
end