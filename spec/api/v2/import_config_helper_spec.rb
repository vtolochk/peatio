# frozen_string_literal: true

RSpec.describe API::V2::ImportConfigHelpers do
  let(:test_file) { File.read(Rails.root.join('spec', 'resources', 'import_config', file_name)) }
  let(:file_name) { 'data.json' }

  subject(:import_config) { API::V2::ImportConfigHelpers.new.process({ file: { tempfile: test_file } }) }

  it 'create new currency' do
    expect { import_config }.to change { Currency.count }.by(1)
  end

  it 'create new blockchain' do
    expect { import_config }.to change { Blockchain.count }.by(1)
  end

  it 'create new wallet' do
    expect { import_config }.to change { Wallet.count }.by(1)
  end

end


