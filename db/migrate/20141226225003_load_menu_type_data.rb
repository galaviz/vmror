class LoadMenuTypeData < ActiveRecord::Migration
  def up
	MenuType.create(:description => "Menu principal", :active => true)
	MenuType.create(:description => "Menu de configuración", :active => true)
  end
  
  def down
	MenuType.delete_all
  end
end
