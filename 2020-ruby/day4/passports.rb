input = "input"
input = "test_input"

class Passport
  attr_reader :valid

  def initialize(str_fields)
    @field_string = str_fields
    @fields = {}
    @valid = true
    p str_fields
    @fields = {}
    str_fields.split(" ").each { |f|
      k, v = f.split(":")
      @fields[k] = v
    }
    p @fields
  end

  def valid_byr?
  end

  def valid_iyr?
  end

  def valid_eyr?
  end

  def valid_hgt?
  end

  def valid_hcl?
  end

  def valid_ecl?
  end

  def valid_pid?
  end

  def valid_cid?
  end

  def required_fields_present?
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
    required.delete("cid") # Hacking the system to allow North Pole Credentials to be valid

    required.each { |f|
      unless @field_string.include? f
        @valid = false
        print "Missing : #{f}\n"
      end
    }
    return @valid
  end
end

valid_passports = 0
File.foreach(input, "\n\n") do |p|
  p.gsub!("\n", " ")

  passport = Passport.new(p)
  valid = passport.required_fields_present?

  valid_passports += 1 if valid == true
  print "Passport is valid: #{valid}\n\n"
end
print "Valid Passports: #{valid_passports}\n"

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
