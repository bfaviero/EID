# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



=begin
names = ['NW35','W7','W51','62','NW10','W61','W1','W70','W71','NW61','W79','E2','W84','NW30','ET','FH','NS','P','SH','WILG','ADP','AEP','PP','BTP','DKE','DTD','DU','ZBT','ZP','TDC','TX','TC','KS','LCA','PLP','SN','SPE','SC','TEP','PBE','PDT','PKT','PKS','PSK','CP','AP','ACO','KAT','SK']
addresses = [ '305 Memorial Drive',' 362 Memorial Dr',' 410 Memorial Drive',' 3 Ames Street',' 143 Albany Street',' 450 Memorial Drive',' 305 Memorial Drive',' 471 Memorial Drive',' 500 Memorial Drive',' 290 Massachusetts Ave.',' 229 Vassar Street',' 70 Amherst Street',' 550 Memorial Drive','224 Albany St.',' 259 St. Paul Street',' 34 The Fenway','428 Memorial Drive',' 69 Chestnut Street',' 111 Bay State Road','355 Massachusetts Ave',' 351 Massachusetts Avenue',' 155 Bay State Rd','405 Memorial Drive',' 119 Bay State Road',' 403 Memorial Drive',' 416 Beacon Street',' 526 Beacon Street',' 58 Manchester Road','233 Massachusetts Ave',' 372 Memorial Drive',' 64 Bay State Road',' 528 Beacon Street',' 407 Memorial Drive',' 99 Bay State Road',' 450 Beacon Street',' 523 Newbury St',' 518 Beacon St',' 532 Beacon St',' 253 Commonwealth Avenue',' 400 Memorial Dr',' 97 Bay State Road',' 229 Commonwealth Avenue',' 530 Beacon Street',' 487 Commonwealth Avenue',' 32 Hereford Street',' 479 Commonwealth Avenue',' 478 Commonwealth Avenue','350 Memorial Drive','480 Commonwealth Avenue']
cities = [ 'Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge','Cambridge',' Brookline',' Boston','Cambridge',' Cambridge',' Boston','Cambridge',' Cambridge',' Boston',' Cambridge',' Boston',' Cambridge',' Boston',' Boston',' Brookline',' Cambridge',' Cambridge',' Boston',' Boston',' Cambridge',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston',' Cambridge',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston','Cambridge','Boston']
i = 0
while i < names.length do
  Building.create(:mit => names[i], :address => addresses[i] + ", " + cities[i] + ", " + "MA")
  i = i+1
end



routes = [["saferidebostonall", [[42.3592716, -71.0936817, '02', '77 Mass Ave'], [42.3595199, -71.0941612, '03', '84 Mass Ave'], [42.3509167, -71.0894078, '13', 'Beacon St at Mass Ave'], [42.3505003, -71.0908289, '12', '528 Beacon St'], [42.34881, -71.09401, '21', '478 Commonwealth Ave'], [42.34915, -71.0946491, '22', '487 Commonwealth Ave'], [42.346556, -71.11655, '49', '259 Saint Paul St'], [42.3565967, -71.102045, '47', 'Simmons hall'], [42.3501399, -71.0979709, '08', '111 Bay State Rd'], [42.3503297, -71.1005866, '09', '155 Bay State Rd'], [42.3488479, -71.123854, '28', '58 Manchester St'], [42.35103, -71.08963, '29', 'Mass Ave at Beacon St'], [42.35523, -71.104301, '62', 'Audrey/Vassar Street'], [42.350292, -71.086361, '26', '32 Hereford St'], [42.348309, -71.08834, '58', 'MBTA Stop at Newbury']]],
["saferidecamball", [[42.36204, -71.0981, '56', 'Random Hall'], [42.3547905, -71.1026282, '51', 'Tang/Westgate'], [42.3602019, -71.0975257, '36', 'NW10 \\/ Edgerton'], [42.3612719, -71.0843897, '53', 'Wadsworth@E40'], [42.36264, -71.08908, '24', 'East Lot on Main St'], [42.35952, -71.09416, '03', '84 Mass Ave'], [42.36318, -71.09654, '27', 'Main St at Windsor St'], [42.3681476, -71.0855705, '04', 'Sixth St at Charles St'], [42.3601694, -71.0975111, '23', 'NW10\\/Edgerton'], [42.3639197, -71.1086206, '46', 'River St at Pleasant St'], [42.3565968, -71.1020453, '47', 'Simmons hall'], [42.3626179, -71.1124847, '44', 'River St at Fairmont St'], [42.3647999, -71.10594, '45', 'River Street@Franklin Street'], [42.35904, -71.11096, '43', 'Putnum Ave at Magazine St'], [42.36023, -71.1023, '40', 'NW86\\/70 Pacific Street'], [42.3661096, -71.0918302, '41', 'Portland St at Hampshire St'], [42.36123, -71.0883699, '05', 'Ames St at Bld 66'], [42.3592699, -71.0936799, '02', '77 Mass Ave'], [42.36237, -71.08613, '01', 'Kendall Square T'], [42.360289, -71.1022784, '39', 'NW86 \\/ 70 Pacific'], [42.3565399, -71.1089, '14', 'Brookline St at Chestnut St'], [42.37144, -71.0832, '17', 'Cambridge St at Fifth St'], [42.3560823, -71.098703, '16', 'Burton House'], [42.3557087, -71.1097712, '55', 'WW15'], [42.3590332, -71.1002949, '54', 'NW30\\/Warehouse'], [42.35766, -71.0947, '30', 'McCormick Hall'], [42.3591086, -71.1002973, '37', 'NW30 \\/ Warehouse'], [42.36246, -71.10016, '50', 'Sydney St at Green St'], [42.35559, -71.1002099, '35', 'New House'], [42.3610355, -71.0862818, '33', 'MIT Medical at 34 Carleton St'], [42.3719808, -71.0874169, '18', '638 Cambridge St']]],
["saferidebostone", [[42.3592699, -71.0936799, '02', '77 Mass Ave'], [42.35952, -71.09416, '03', '84 Mass Ave'], [42.3509163, -71.0894084, '13', 'Beacon St at Mass Ave'], [42.3488099, -71.0940128, '21', '478 Commonwealth Ave'], [42.34915, -71.0946288, '22', '487 Commonwealth Ave'], [42.35103, -71.08963, '29', 'Mass Ave at Beacon St'], [42.34831, -71.08834, '58', 'MBTA Stop at Newbury']]],
["saferidebostonw", [[42.35952, -71.09416, '03', '84 Mass Ave'], [42.350292, -71.086361, '26', '32 Hereford St'], [42.3505003, -71.0908289, '12', '528 Beacon St'], [42.34915, -71.094638, '22', '487 Commonwealth Ave'], [42.346556, -71.11655, '49', '259 Saint Paul St'], [42.3565969, -71.1020451, '47', 'Simmons hall'], [42.3501399, -71.0979716, '08', '111 Bay State Rd'], [42.3503299, -71.1005866, '09', '155 Bay State Rd'], [42.3488581, -71.1238855, '28', '58 Manchester St'], [42.3552296, -71.1043008, '62', 'Audrey\\/Vassar Street']]],
["saferidecambeast", [[42.36264, -71.08908, '24', 'East Lot on Main St'], [42.35952, -71.09416, '03', '84 Mass Ave'], [42.360289, -71.1022784, '39', 'NW86 \\/ 70 Pacific'], [42.36204, -71.0981, '38', 'NW61 \\/ Random Hall'], [42.3681476, -71.0855705, '04', 'Sixth St at Charles St'], [42.37144, -71.0832, '17', 'Cambridge St at Fifth St'], [42.36123, -71.0883699, '05', 'Ames St at Bld 66'], [42.3610382, -71.0862815, '33', 'MIT Medical at 34 Carleton St'], [42.3719808, -71.0874169, '18', '638 Cambridge St'], [42.36237, -71.08613, '01', 'Kendall Square T'], [42.3591086, -71.1002973, '37', 'NW30 \\/ Warehouse'], [42.3602019, -71.0975257, '36', 'NW10 \\/ Edgerton'], [42.3612719, -71.0843897, '53', 'Wadsworth@E40'], [42.3661096, -71.0918302, '41', 'Portland St at Hampshire St'], [42.35927, -71.09368, '02', '77 Mass Ave'], [42.36318, -71.09654, '27', 'Main St at Windsor St']]],
["saferidecambwest", [[42.3592699, -71.0936799, '02', '77 Mass Ave'], [42.3595199, -71.09416, '03', '84 Mass Ave'], [42.3601694, -71.0975111, '23', 'NW10\\/Edgerton'], [42.364801, -71.105938, '45', 'River Street@Franklin Street'], [42.3565399, -71.1089, '14', 'Brookline St at Chestnut St'], [42.3560823, -71.098703, '16', 'Burton House'], [42.3557087, -71.1097712, '55', 'WW15'], [42.3565968, -71.1020453, '47', 'Simmons hall'], [42.3626179, -71.1124847, '44', 'River St at Fairmont St'], [42.35766, -71.0947, '30', 'McCormick Hall'], [42.3547905, -71.1026282, '51', 'Tang\\/Westgate'], [42.35904, -71.11096, '43', 'Putnum Ave at Magazine St'], [42.35559, -71.1002099, '35', 'New House'], [42.3624601, -71.1001597, '50', 'Sydney St at Green St'], [42.3639197, -71.1086206, '46', 'River St at Pleasant St'], [42.36237, -71.08613, '01', 'Kendall Square T'], [42.36023, -71.1023, '40', 'NW86\\/70 Pacific Street'], [42.3590332, -71.1002949, '54', 'NW30\\/Warehouse'], [42.3612719, -71.0843897, '53', 'Wadsworth@E40']]]]

routes.each do |routeinfo|
  nrid = routeinfo[0]
  stops = routeinfo[1]
  route = Route.where(:nid => nrid).first
  stops.each do |stopinfo|
    stop = Stop.where(:nid => stopinfo[2]).first
    if stop.nil?
      stop = Stop.create(:latitude => stopinfo[0], :longitude => stopinfo[1], :nid => stopinfo[2], :name => stopinfo[3])
    end
    route.stops << stop
  end
end
=end



