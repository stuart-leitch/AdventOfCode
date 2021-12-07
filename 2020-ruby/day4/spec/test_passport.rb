require "passport"

describe Passport do
  happy_string = "hgt:156cm iyr:2014 byr:1960 pid:720786216 cid:99 ecl:gry hcl:#a97842 eyr:2028"
  describe "#valiid_byr" do
    it "checks success" do
      p = Passport.new(happy_string)
      expect(p.passport_valid?).to eq true
    end
    it "checks that Birth Year is required" do
      p = Passport.new(happy_string.delete("byr:1960"))
      expect(p.passport_valid?).to eq false
      expect(p.missing_fields.include?("byr")).to eq true
    end
    it "checks that Birth Year can't be < 1920" do
      p = Passport.new(happy_string.gsub("byr:1960", "byr:1919"))
      expect(p.passport_valid?).to eq false
      expect(p.invalid_fields.include?("byr")).to be_true
      expect(p.missing_fields.include?("byr")).to be_false
    end
    it "checks that Birth Year can't be > 2002" do
      p = Passport.new(happy_string.gsub("byr:1960", "byr:2003"))
      expect(p.passport_valid?).to eq false
      expect(p.invalid_fields.include?("byr")).to eq true
    end
    it "checks that Birth Year can't be 2002.17" do
      p = Passport.new(happy_string.gsub("byr:1960", "byr:2002.17"))
      expect(p.passport_valid?).to eq false
      expect(p.invalid_fields.include?("byr")).to eq true
    end
    it "checks that Birth Year can't be cheese" do
      p = Passport.new(happy_string.gsub("byr:1960", "byr:cheese"))
      expect(p.passport_valid?).to eq false
      expect(p.invalid_fields.include?("byr")).to eq true
    end
  end
end
