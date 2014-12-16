class LoadSecurityData < ActiveRecord::Migration
  def up
	Page.create(:description => "Configuración", :command => "/dashboard/configuration", :order_by => 0, :is_menu => false, :active => true)
	Page.create(:description => "Tablero de Energía", :command => "/dashboard/monitoreo", :order_by => 1, :is_menu => true, :active => true)
	Page.create(:description => "Créditos y Puntos VM", :command => "/dashboard/puntos", :order_by => 2, :is_menu => true, :active => true)
	Page.create(:description => "Tienda Verde", :command => "/dashboard/tienda", :order_by => 3, :is_menu => true, :active => true)
	Page.create(:description => "Fundación VM", :command => "/dashboard/fundacion", :order_by => 4, :is_menu => true, :active => true)
	Page.create(:description => "Pay-It-Forward", :command => "/dashboard/pay_it_forward", :order_by => 5, :is_menu => true, :active => true)
	
	Profile.create(:description => "Administrador", :page_id => 1, :active => true)
	Profile.create(:description => "Cliente", :page_id => 2, :active => true)
	
	Permission.create(:description => "fullAccess", 						:command => "fullAccess", 			:active => true)
	Permission.create(:description => "Configuracion", 						:command => "manageConfiguration", 	:active => true)
	Permission.create(:description => "Gestionar tablas de energia", 		:command => "manageEnergyTables", 	:active => true)
	Permission.create(:description => "Gestionar creditos y puntos VM", 	:command => "manageCreditPiontsVM", :active => true)
	Permission.create(:description => "Gestionar tienda verde", 			:command => "manageGreenShop", 		:active => true)
	Permission.create(:description => "Gestionar fundacion VM", 			:command => "manageFoundationVM", 	:active => true)
	Permission.create(:description => "Gestionar Pay-It-Forward", 			:command => "managePayItForword", 	:active => true)
	
	ProfilePermission.create(:profile_id => 1, :permission_id => 1, :active => true)
	ProfilePermission.create(:profile_id => 2, :permission_id => 3, :active => true)
	ProfilePermission.create(:profile_id => 2, :permission_id => 4, :active => true)
	ProfilePermission.create(:profile_id => 2, :permission_id => 5, :active => true)
	ProfilePermission.create(:profile_id => 2, :permission_id => 6, :active => true)
	ProfilePermission.create(:profile_id => 2, :permission_id => 7, :active => true)
	
	PagePermission.create(:page_id => 1, :permission_id => 2, :active => true)
	PagePermission.create(:page_id => 2, :permission_id => 3, :active => true)
	PagePermission.create(:page_id => 3, :permission_id => 4, :active => true)
	PagePermission.create(:page_id => 4, :permission_id => 5, :active => true)
	PagePermission.create(:page_id => 5, :permission_id => 6, :active => true)
	PagePermission.create(:page_id => 6, :permission_id => 7, :active => true)
  end
  
  def down
      Page.delete_all
      Profile.delete_all
      Permission.delete_all
      PagePermission.delete_all
      ProfilePermission.delete_all
  end
end
