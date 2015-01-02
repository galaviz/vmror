class CreateDonationHistories < ActiveRecord::Migration
  def change
    create_table :donation_histories do |t|
      t.string :description
      t.integer :user_id
      t.integer :donation_type_id
      t.integer :project_id
      t.integer :amount_mxn
      t.integer :credit_vm
      t.string :contract_file_name
      t.boolean :active

      t.timestamps
    end
  end
end
