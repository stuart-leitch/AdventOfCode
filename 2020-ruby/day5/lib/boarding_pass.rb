class BoardingPass
  def self.bp_to_dec(bp, h, l)
    low, high = 0, 2 ** (bp.length) - 1
    bp.each do |b|
      if b == h
        low = low + (high - low) / 2 + 1
      else
        high = low + (high - low) / 2
      end
    end
    return low
  end

  def self.decode(str)
    # FBFBBFF RLR
    return nil unless str.match(/\A[FB]{7}[RL]{3}\z/)
    # return 357
    str_row = str.chars[0..6]
    str_col = str.chars[7..9]

    row = bp_to_dec(str_row, "B", "F")
    col = bp_to_dec(str_col, "R", "L")
    id = row * 8 + col
    return row, col, id
  end
end
