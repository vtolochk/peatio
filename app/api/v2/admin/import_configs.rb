# encoding: UTF-8
# frozen_string_literal: true

module API
  module V2
    module Admin
      class ImportConfigs < Grape::API

        desc 'Import currencies, blockchains and wallets from json file'
        params do
          requires :file,
                   type: File
        end
        post '/import_configs' do
          API::V2::ImportConfigsHelper.new.process(params)
          present(result: 'Importing of currencies, blockchains and wallets is started')
        end
      end
    end
  end
end