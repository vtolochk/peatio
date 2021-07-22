class AddBeneficiariesEnabledToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :beneficiaries_whitelisting, :bool, after: :group
  end
end
