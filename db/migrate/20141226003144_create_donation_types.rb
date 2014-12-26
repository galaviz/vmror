class CreateDonationTypes < ActiveRecord::Migration
  def change
    create_table :donation_types do |t|
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
