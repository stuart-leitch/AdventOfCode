# frozen_string_literal: true

seeds, *maps = File.read(ARGV[0]).split("\n\n")

seeds = seeds.split(':')[1].split.map(&:to_i)

map_hash = {}
maps.each do |map|
  name, data = map.split(':')
  name.gsub!('-', '_').delete_suffix!(' map')

  data = data.split("\n")[1..-1].map { |e| e.split.map(&:to_i) }

  map_hash[name] = data
end
pp map_hash

def generate_map(input_map)
  output_map = []
  input_map.each do |row|
    d_start, s_start, r_length = row
    output_map << [s_start, s_start + r_length - 1, d_start - s_start]
  end
  output_map
end

def translate(map, src)
  dest = src
  map.each do |row|
    source_start, source_end, offset = row
    next unless src.between?(source_start, source_end)

    dest = src + offset
    break
  end
  dest
end

$seed2soil = generate_map(map_hash['seed_to_soil'])
$soil2fertilizer = generate_map(map_hash['soil_to_fertilizer'])
$fertilizer2water = generate_map(map_hash['fertilizer_to_water'])
$water2light = generate_map(map_hash['water_to_light'])
$light2temperature = generate_map(map_hash['light_to_temperature'])
$temperature2humidity = generate_map(map_hash['temperature_to_humidity'])
$humidity2location = generate_map(map_hash['humidity_to_location'])

def seed2location(seed)
  soil = translate($seed2soil, seed)
  fertilizer = translate($soil2fertilizer, soil)
  water = translate($fertilizer2water, fertilizer)
  light = translate($water2light, water)
  temperature = translate($light2temperature, light)
  humidity = translate($temperature2humidity, temperature)
  translate($humidity2location, humidity)
end

min_location = 2_147_483_647
num_seeds = 0
seeds.each_slice(2) do |a, b|
  a.upto(a + b - 1).each do |seed|
    num_seeds += 1
    loc = seed2location(seed)
    if loc < min_location
      min_location = loc
      p min_location
    end
  end

  # a.upto(a + b - 1).each { |_seed| num_seeds += 1 }
  p b
end
print "\n"

print "Seeds: #{num_seeds}\n"
print "Location: #{min_location}\n"
