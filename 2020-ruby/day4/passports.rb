require_relative "lib/passport"
input = "input"
# input = "test_input"

valid_passports = 0
invalid_passports = 0
File.foreach(input, "\n\n") do |p|
  p.gsub!("\n", " ").strip!

  passport = Passport.new(p)
  if passport.passport_valid?
    print "Passport is valid\n\n"
    valid_passports += 1
  else
    print "Passport is NOT valid (missing: #{passport.missing_fields}.  invalid: #{passport.invalid_fields})\n\n"
    invalid_passports += 1
  end
end
print "Valid Passports:   #{valid_passports}\n"
print "Invalid Passports: #{invalid_passports}\n"
