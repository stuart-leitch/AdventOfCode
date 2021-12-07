class Passport
  attr_reader :missing_fields, :invalid_fields

  def initialize(str_fields)
    @field_string = str_fields
    @fields = {}
    @missing_fields = []
    @invalid_fields = []

    # p @field_string

    @field_string.split(" ").each { |field|
      k, v = field.split(":")
      @fields[k] = v
    }
    # p @fields
  end

  def validate_num(fieldname, min, max)
    return true if @fields[fieldname].to_i.between?(min, max)

    @invalid_fields << fieldname
    return false
  end

  def validate_list(fieldname, allowlist)
    return true if allowlist.include? @fields[fieldname]

    @invalid_fields << fieldname
    return false
  end

  def validate_re(fieldname, expr)
    return true if @fields[fieldname].match(expr)

    @invalid_fields << fieldname
    return false
  end

  def valid_byr? # four digits; at least 1920 and at most 2002.
    validate_num("byr", 1920, 2002)
  end

  def valid_iyr? # four digits; at least 2010 and at most 2020.
    validate_num("iyr", 2010, 2020)
  end

  def valid_eyr? # four digits; at least 2020 and at most 2030.
    validate_num("eyr", 2020, 2030)
  end

  def valid_hgt? # a number followed by either cm or in:
    # If cm, the number must be at least 150 and at most 193.
    # If in, the number must be at least 59 and at most 76.
    return false unless (h = @fields["hgt"])
    if h.match(/\A\d{3}cm\z/)
      h.chomp("cm")
      validate_num("hgt", 150, 193)
    elsif h.match(/\A\d{2}in\z/)
      h.chomp("in")
      validate_num("hgt", 59, 76)
    else
      @invalid_fields << "hgt"
      return false
    end
  end

  def valid_hcl? # a # followed by exactly six characters 0-9 or a-f.
    return false unless @fields["hcl"]
    validate_re("hcl", /\A#[a-f0-9]{6}\z/)
  end

  def valid_ecl?
    valid_eye_colours = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    validate_list("ecl", valid_eye_colours)
  end

  def valid_pid? # a nine-digit number, including leading zeroes.
    return false unless @fields["pid"]
    validate_re("pid", /\A\d{9}\z/)
  end

  def valid_cid?
    return true # Hack the system.
  end

  def required_fields_present?
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
    required.delete("cid") # Hacking the system to allow North Pole Credentials to be valid
    valid = true

    required.each { |f|
      unless @field_string.include? f
        @missing_fields << f
        valid = false
      end
    }
    return valid
  end

  def passport_valid?
    valid = true
    valid = false unless required_fields_present?
    valid = false unless valid_byr?
    valid = false unless valid_iyr?
    valid = false unless valid_eyr?
    valid = false unless valid_hgt?
    valid = false unless valid_hcl?
    valid = false unless valid_ecl?
    valid = false unless valid_pid?
    valid = false unless valid_cid?
    return valid
  end
end
