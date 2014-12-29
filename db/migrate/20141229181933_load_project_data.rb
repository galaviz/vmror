class LoadProjectData < ActiveRecord::Migration
  def up
	Project.create(
		description: 'Instalación de 100 bombas de agua solares en zonas marginadas',
		holder: '', 
		vm_code: '', 
		amount: 1000000,
		progress_amount: 50000,
		progress_percent: 5,
		payback: '',
		tir: 0,
		project_type_id: 1,
		active: true
	)
	Project.create(
		description: 'Instalación de sistema solar residencial propio',
		holder: 'Ezequiel Álvarez Medina', 
		vm_code: 'EALV1', 
		amount: 122000,
		progress_amount: 0,
		progress_percent: 0,
		payback: '4 años',
		tir: 29,
		project_type_id: 2,
		active: true
	)
  end
  
  def down
	Project.delete_all
  end
end
