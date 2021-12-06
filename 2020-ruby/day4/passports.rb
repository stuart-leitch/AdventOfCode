input = "input"
input = "test_input"

# required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

valid_passports = 0
File.foreach(input, "\n\n") do |p|
  valid = true
  fields = {}
  p.gsub!("\n", " ")
  p p
  p.split(" ").each { |f|
    k, v = f.split(":")
    fields[k] = v
  }
  p fields

  required.each { |f|
    unless p.include? f
      valid = false
      print "Missing : #{f}\n"
    end
  }

  valid_passports += 1 if valid == true
  print "Passport is valid: #{valid}\n\n"
end
print "Valid Passports: #{valid_passports}\n"

# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

# byr (Birth Year)      - four digits; at least 1920 and at most 2002.
# iyr (Issue Year)      - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hcl (Hair Color)      - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color)       - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID)     - a nine-digit number, including leading zeroes.
# cid (Country ID)      - ignored, missing or not.
# hgt (Height)          - a number followed by either cm or in:
#                           If cm, the number must be at least 150 and at most 193.
#                           If in, the number must be at least 59 and at most 76.
