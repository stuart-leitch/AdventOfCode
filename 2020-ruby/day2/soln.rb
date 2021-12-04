input = "test_input"
# input = "input"

entries = File.readlines(input).map { |line| line.chomp}

entries.each do |entry|
    puts entry 
end