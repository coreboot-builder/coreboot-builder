# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


lenovo = Vendor.create(name: 'Lenovo')

lenovo_devices = %w(
  Thinkpad T500
  Thinkpad T400
  Thinkpad X200
  Thinkpad X220
  Thinkpad X230
  Thinkpad T420
  Thinkpad T430s
  Thinkpad T520
  Thinkpad T530
  Thinkpad T410
)

lenovo_devices.each do |device|
  Device.create(vendor: lenovo, needs_rom_dump: true, name: device, config_file: 'random.name')
end
