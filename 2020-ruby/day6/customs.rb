sum = 0
File.readlines("input", "\n\n").each do |declaration|
  declaration.gsub!("\n", "")
  sum += declaration.chars.uniq.length
end
p sum
