$readings = File.readlines("input").map(&:strip).map(&:chars)
# .map(&:toi)
# clines = lines.length

$cols = $readings[0].length
$rows = $readings.length

def get_val(r, c)
  # print "get_val: #{r},#{c} (#{$rows},#{$cols})\n"
  return nil if r >= $rows || r < 0 || c >= $cols || c < 0
  $readings[r][c]
end

def get_vals(r, c)
  vals = []
  vals << get_val(r - 1, c)
  vals << get_val(r + 1, c)
  vals << get_val(r, c - 1)
  vals << get_val(r, c + 1)
  return vals
end

print "\n"
risk = 0
$rows.times do |r|
  # print "ROW: #{r}:\n"
  $cols.times do |c|
    # print "c:#{c}: #{$readings[r][c]}: "
    # print "#{get_vals(r, c)}"
    if $readings[r][c].to_i < get_vals(r, c).compact.map(&:to_i).min
      risk += (1 + $readings[r][c].to_i)
      # print " -- MIN!"
    end
    # print "\n"
  end
  # print "\n"
end
p risk
