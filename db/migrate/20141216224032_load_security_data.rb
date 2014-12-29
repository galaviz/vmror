class LoadSecurityData < ActiveRecord::Migration
  def up
	Page.create(:description => "Configuración", :command => "configuration", :order_by => 0, :menu_id => 0, :active => true)
	Page.create(:description => "Tablero de Energía", :command => "monitoring", :order_by => 1, :menu_id => 1, :active => true)
	Page.create(:description => "Créditos y Puntos VM", :command => "points", :order_by => 2, :menu_id => 1, :active => true)
	Page.create(:description => "Tienda Verde", :command => "green_shop", :order_by => 3, :menu_id => 1, :active => true)
	Page.create(:description => "Fundación VM", :command => "foundation", :order_by => 4, :menu_id => 1, :active => true)
	Page.create(:description => "Pay-It-Forward", :command => "pay_it_forward", :order_by => 5, :menu_id => 1, :active => true)
	
	Page.create(:description => "Usuarios", :command => "user", :order_by => 6, :menu_id => 2, :active => true)
	Page.create(:description => "Perfiles", :command => "profile", :order_by => 7, :menu_id => 2, :active => true)
	Page.create(:description => "Páginas", :command => "page", :order_by => 8, :menu_id => 2, :active => true)
	Page.create(:description => "Permisos", :command => "permission", :order_by => 9, :menu_id => 2, :active => true)
	Page.create(:description => "Paises", :command => "country", :order_by => 10, :menu_id => 2, :active => true)
	Page.create(:description => "Estados", :command => "state", :order_by => 11, :menu_id => 2, :active => true)
	Page.create(:description => "Municipios", :command => "location", :order_by => 12, :menu_id => 2, :active => true)
	Page.create(:description => "Categorias", :command => "category", :order_by => 12, :menu_id => 2, :active => true)
	Page.create(:description => "Productos", :command => "product", :order_by => 12, :menu_id => 2, :active => true)
	Page.create(:description => "Proyectos", :command => "project", :order_by => 12, :menu_id => 2, :active => true)
	
	Profile.create(:description => "Administrador", :page_id => 7, :active => true)
	Profile.create(:description => "Cliente", :page_id => 2, :active => true)
	
	Permission.create(:description => "fullAccess", :command => "fullAccess", :active => true)
	Permission.create(:description => "Configuracion", :command => "manageConfigurations", :active => true)
	Permission.create(:description => "Gestionar tablas de energia", :command => "manageEnergyTables", :active => true)
	Permission.create(:description => "Gestionar creditos y puntos VM", :command => "manageCreditPiontsVM", :active => true)
	Permission.create(:description => "Gestionar tienda verde", :command => "manageGreenShop", :active => true)
	Permission.create(:description => "Gestionar fundacion VM", :command => "manageFoundationVM", :active => true)
	Permission.create(:description => "Gestionar Pay-It-Forward", :command => "managePayItForword", :active => true)
	
	Permission.create(:description => "Gestionar usuarios", :command => "manageUsers", :active => true)
	Permission.create(:description => "Gestionar perfiles", :command => "manageProfiles", :active => true)
	Permission.create(:description => "Gestionar páginas", :command => "managePages", :active => true)
	Permission.create(:description => "Gestionar permisos", :command => "managePermissions", :active => true)
	Permission.create(:description => "Gestionar paises", :command => "manageCountries", :active => true)
	Permission.create(:description => "Gestionar estados", :command => "manageStates", :active => true)
	Permission.create(:description => "Gestionar municipios", :command => "manageLocations", :active => true)
	Permission.create(:description => "Gestionar categorias", :command => "manageCategories", :active => true)
	Permission.create(:description => "Gestionar productos", :command => "manageProducts", :active => true)
	Permission.create(:description => "Gestionar proyectos", :command => "manageProjects", :active => true)
	
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
	
	PagePermission.create(:page_id => 7, :permission_id => 8, :active => true)
	PagePermission.create(:page_id => 8, :permission_id => 9, :active => true)
	PagePermission.create(:page_id => 9, :permission_id => 10, :active => true)
	PagePermission.create(:page_id => 10, :permission_id => 11, :active => true)
	PagePermission.create(:page_id => 11, :permission_id => 12, :active => true)
	PagePermission.create(:page_id => 12, :permission_id => 13, :active => true)
	PagePermission.create(:page_id => 13, :permission_id => 14, :active => true)
	PagePermission.create(:page_id => 14, :permission_id => 15, :active => true)
	PagePermission.create(:page_id => 15, :permission_id => 16, :active => true)
	PagePermission.create(:page_id => 16, :permission_id => 17, :active => true)
	
  end
  
  def down
      Page.delete_all
      Profile.delete_all
      Permission.delete_all
      PagePermission.delete_all
      ProfilePermission.delete_all
  end
end
