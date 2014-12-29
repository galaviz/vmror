class LoadProjectTypeData < ActiveRecord::Migration
  def up
	ProjectType.create(description: 'Fundación VM', active: true)
	ProjectType.create(description: 'Pay-It-Forword', active: true)
  end
  
  def down
	ProjectType.delete_all
  end
end
