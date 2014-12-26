class LoadCategoryData < ActiveRecord::Migration
  def up
	Category.create(:description => "Iluminación", :active => true)
	Category.create(:description => "Calefacción", :active => true)
	Category.create(:description => "Aire Acondicionado", :active => true)
  end
  
  def down
	Category.delete_all
  end
end
