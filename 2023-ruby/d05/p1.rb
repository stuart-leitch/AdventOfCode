# frozen_string_literal: true

seeds = [79, 14, 55, 13]
print "Seeds: #{seeds}\n"

seed_to_soil_map = [
  [50, 98, 2],
  [52, 50, 48]
]

soil_to_fertilizer_map = [
  [0, 15, 37],
  [37, 52, 2],
  [39, 0, 15]
]

fertilizer_to_water_map = [
  [49, 53, 8],
  [0, 11, 42],
  [42, 0, 7],
  [57, 7, 4]
]
water_to_light_map = [
  [88, 18, 7],
  [18, 25, 70]
]
light_to_temperature_map = [
  [45, 77, 23],
  [81, 45, 19],
  [68, 64, 13]
]
temperature_to_humidity_map = [
  [0, 69, 1],
  [1, 0, 69]
]
humidity_to_location_map = [
  [60, 56, 37],
  [56, 93, 4]
]

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

seed2soil = generate_map(seed_to_soil_map)
soil2fertilizer = generate_map(soil_to_fertilizer_map)
fertilizer2water = generate_map(fertilizer_to_water_map)
water2light = generate_map(water_to_light_map)
light2temperature = generate_map(light_to_temperature_map)
temperature2humidity = generate_map(temperature_to_humidity_map)
humidity2location = generate_map(humidity_to_location_map)

print "Seed to soil map: #{seed2soil}\n"
print "Soil to fertilizer map: #{soil2fertilizer}\n"
print "Fertilizer to water map: #{fertilizer2water}\n"
print "Water to light map: #{water2light}\n"
print "Light to temperature map: #{light2temperature}\n"
print "Temperature to humidity map: #{temperature2humidity}\n"
print "Humidity to location map: #{humidity2location}\n"

soils = seeds.map { |seed| translate(seed2soil, seed) }
print "Soils: #{soils}\n"

fertilizers = soils.map { |soil| translate(soil2fertilizer, soil) }
print "Fertilizers: #{fertilizers}\n"

waters = fertilizers.map { |fertilizer| translate(fertilizer2water, fertilizer) }
print "Waters: #{waters}\n"

lights = waters.map { |water| translate(water2light, water) }
print "Lights: #{lights}\n"

temperatures = lights.map { |light| translate(light2temperature, light) }
print "Temperatures: #{temperatures}\n"

humidities = temperatures.map { |temperature| translate(temperature2humidity, temperature) }
print "Humidities: #{humidities}\n"

locations = humidities.map { |humidity| translate(humidity2location, humidity) }
print "Locations: #{locations}\n"
