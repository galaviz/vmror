# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141112135510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "image_url"
    t.string   "brand_image_url"
    t.float    "watts"
    t.string   "lumenes"
    t.float    "precio"
    t.string   "vida"
    t.string   "disponibilidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "is_residential"
    t.string   "empresa"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "telefono"
    t.string   "celular"
    t.string   "estado"
    t.string   "municipio"
    t.string   "calle"
    t.integer  "numero_direccion"
    t.string   "colonia"
    t.string   "codigo_postal"
    t.string   "rpu"
    t.string   "tarifa"
    t.float    "cargo_fijo"
    t.float    "energia"
    t.float    "consumo_total"
    t.float    "importe_total"
    t.float    "total_a_pagar"
    t.string   "tipo_membresia"
    t.string   "hora_visita"
    t.string   "fecha_visita"
    t.string   "forma_pago"
    t.string   "clave_referencia"
    t.string   "stripe_id"
    t.integer  "puntos_vm"
    t.string   "creditos_vm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
