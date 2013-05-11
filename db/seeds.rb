# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

=begin
routes = ["tech", [[42.36237, -71.08613, '01', 'Kendall Square'], [42.361272, -71.0843897, '07', 'Amherst St at Wadsworth St'], [42.3623986, -71.0902529, '48', 'Stata Center'], [42.35608, -71.09871, '16', 'Burton House'], [42.3566938, -71.1021138, '47', 'Simmons hall'], [42.3548358, -71.1049941, '57', 'W92 at Amesbury St'], [42.35489, -71.10269, '51', 'Tang\\/Westgate'], [42.3603, -71.09452, '52', 'Vassar St at Mass Ave'], [42.36032, -71.08686, '60', 'Media Lab'], [42.35797, -71.09421, '61', 'Kresge']]]
stops = routes[1]
route = Route.where(:nid => "tech").first
stops.each do |stopinfo|
  stop = Stop.where(:nid => stopinfo[2]).first
  if stop.nil?
    stop = Stop.create(:latitude => stopinfo[0], :longitude => stopinfo[1], :nid => stopinfo[2], :name => stopinfo[3])
  end
  route.stops << stop
end
names = ['NW35','W7','W51','62','NW10','W61','W1','W70','W71','NW61','W79','E2','W84','NW30','ET','FH','NS','P','SH','WILG','ADP','AEP','PP','BTP','DKE','DTD','DU','ZBT','ZP','TDC','TX','TC','KS','LCA','PLP','SN','SPE','SC','TEP','PBE','PDT','PKT','PKS','PSK','CP','AP','ACO','KAT','SK']
addresses = [ '305 Memorial Drive',' 362 Memorial Dr',' 410 Memorial Drive',' 3 Ames Street',' 143 Albany Street',' 450 Memorial Drive',' 305 Memorial Drive',' 471 Memorial Drive',' 500 Memorial Drive',' 290 Massachusetts Ave.',' 229 Vassar Street',' 70 Amherst Street',' 550 Memorial Drive','224 Albany St.',' 259 St. Paul Street',' 34 The Fenway','428 Memorial Drive',' 69 Chestnut Street',' 111 Bay State Road','355 Massachusetts Ave',' 351 Massachusetts Avenue',' 155 Bay State Rd','405 Memorial Drive',' 119 Bay State Road',' 403 Memorial Drive',' 416 Beacon Street',' 526 Beacon Street',' 58 Manchester Road','233 Massachusetts Ave',' 372 Memorial Drive',' 64 Bay State Road',' 528 Beacon Street',' 407 Memorial Drive',' 99 Bay State Road',' 450 Beacon Street',' 523 Newbury St',' 518 Beacon St',' 532 Beacon St',' 253 Commonwealth Avenue',' 400 Memorial Dr',' 97 Bay State Road',' 229 Commonwealth Avenue',' 530 Beacon Street',' 487 Commonwealth Avenue',' 32 Hereford Street',' 479 Commonwealth Avenue',' 478 Commonwealth Avenue','350 Memorial Drive','480 Commonwealth Avenue']
cities = [ 'Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge',' Cambridge','Cambridge',' Brookline',' Boston','Cambridge',' Cambridge',' Boston','Cambridge',' Cambridge',' Boston',' Cambridge',' Boston',' Cambridge',' Boston',' Boston',' Brookline',' Cambridge',' Cambridge',' Boston',' Boston',' Cambridge',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston',' Cambridge',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston',' Boston','Cambridge','Boston']
i = 0
while i < names.length do
  Building.create(:mit => names[i], :address => addresses[i] + ", " + cities[i] + ", " + "MA")
  i = i+1
end




=end



