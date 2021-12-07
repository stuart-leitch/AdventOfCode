require "boarding_pass"

describe BoardingPass do
  describe "#decode" do
    it "decodes FBFBBFFRLR: row 44, column 5, seat ID 357." do
      expect(BoardingPass.decode("FBFBBFFRLR")).to eq [44, 5, 357]
    end

    it "decodes BFFFBBFRRR: row 70, column 7, seat ID 567." do
      expect(BoardingPass.decode("BFFFBBFRRR")).to eq [70, 7, 567]
    end

    it "decodes FFFBBBFRRR: row 14, column 7, seat ID 119." do
      expect(BoardingPass.decode("FFFBBBFRRR")).to eq [14, 7, 119]
    end

    it "decodes BBFFBBFRLL: row 102, column 4, seat ID 820." do
      expect(BoardingPass.decode("BBFFBBFRLL")).to eq [102, 4, 820]
    end

    it "rejects empty" do
      expect(BoardingPass.decode("")).to eq nil
    end
    it "rejects cheese" do
      expect(BoardingPass.decode("cheese")).to eq nil
    end
    it "checks too long code rejected" do
      expect(BoardingPass.decode("BBBFFBBFRLL")).to eq nil
    end
    it "checks too short code rejected" do
      expect(BoardingPass.decode("BFFBBFRLL")).to eq nil
    end
    it "decodes BBFFBBFRLL: row 102, column 4, seat ID 820." do
      expect(BoardingPass.decode("BAFEBBFRLL")).to eq nil
    end
    it "decodes BBFFBBFRLL: row 102, column 4, seat ID 820." do
      expect(BoardingPass.decode("BBFFBB0RTL")).to eq nil
    end
  end
end
