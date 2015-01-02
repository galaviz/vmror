class Product < ActiveRecord::Base

	def self.upload(upload)
	   name =  upload.original_filename
	   directory = "app/assets/images/products_images"
	   # create the file path
	   path = File.join(directory, name)
	   # write the file
	   File.open(path, "wb") { |f| f.write(upload.read) }
	   return name
 	end

 	def self.upload_brand(upload_brand)
	   name =  upload_brand.original_filename
	   directory = "app/assets/images/brands_images"
	   # create the file path
	   path = File.join(directory, name)
	   # write the file
	   File.open(path, "wb") { |f| f.write(upload_brand.read) }
	   return name
 	end
end
