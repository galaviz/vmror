class LoadDonationTypeData < ActiveRecord::Migration
  def up
	DonationType.create(:description => "Donación Fundación VM", :active => true)
	DonationType.create(:description => "Donación Pay-It-Forword", :active => true)
	DonationType.create(:description => "Inversión Pay-It-Forword", :active => true)
  end
  
  def down
	DonationType.delete_all
  end
end
