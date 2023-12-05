# frozen_string_literal: true

seeds, *maps = File.read(ARGV[0]).split("\n\n")

seeds = seeds.split(':')[1].split.map(&:to_i)
print "Seeds: #{seeds}\n"

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

seed2soil = generate_map(map_hash['seed_to_soil'])
soil2fertilizer = generate_map(map_hash['soil_to_fertilizer'])
fertilizer2water = generate_map(map_hash['fertilizer_to_water'])
water2light = generate_map(map_hash['water_to_light'])
light2temperature = generate_map(map_hash['light_to_temperature'])
temperature2humidity = generate_map(map_hash['temperature_to_humidity'])
humidity2location = generate_map(map_hash['humidity_to_location'])

p soils = seeds.map { |seed| translate(seed2soil, seed) }
p fertilizers = soils.map { |soil| translate(soil2fertilizer, soil) }
p waters = fertilizers.map { |fertilizer| translate(fertilizer2water, fertilizer) }
p lights = waters.map { |water| translate(water2light, water) }
p temperatures = lights.map { |light| translate(light2temperature, light) }
p humidities = temperatures.map { |temperature| translate(temperature2humidity, temperature) }
p locations = humidities.map { |humidity| translate(humidity2location, humidity) }
p ''
p locations.min
