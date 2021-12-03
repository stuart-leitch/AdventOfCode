input = "test_input"
# input = "input"
# readings = File.readlines(input)

readings = File.readlines(input).map { |line| line.chomp.chars.map(&:to_i) }

# Part 1 - Power Consumption
zeros = []
ones = []
readings.each { |reading|
    reading.each_with_index do |v,i|
        zeros[i] = 0 if zeros[i].nil?
        ones[i] = 0 if ones[i].nil?

        if v == 0 then
            zeros[i] += 1
        elsif v==1 then
            ones[i] +=  1
        end
    end

}

print "zeros: #{zeros} \n"
print "ones:  #{ones} \n"

gamma = []
epsilon = []
zeros.each_with_index do |v,i|
    if zeros[i] > ones[i] then
        gamma[i] = 0
        epsilon[i] = 1
    else
        gamma[i] = 1
        epsilon[i] = 0
    end
end

g = gamma.join().to_i(2)
print "gamma: #{gamma} (#{g})\n"

e = epsilon.join().to_i(2)
print "epsilon: #{epsilon} (#{e})\n"

power_consumption = g*e
print "power_consumption: #{power_consumption}\n\n"


# Part 2 - Life Support

def count_ones_and_zeroes(inarray,pos)
    ones =   inarray.select{|v| v[pos] == 1}.length
    zeroes = inarray.select{|v| v[pos] == 0}.length

    return zeroes, ones
end

def find_crit_bit (inarray,pos, meth, tie)

    zeroes, ones = count_ones_and_zeroes(inarray, pos)

    if zeroes == ones then
        crit = tie
    elsif meth == "most" && ones > zeroes then
        crit = 1
    elsif meth == "least" && ones < zeroes then
        crit = 1
    else
        crit = 0
    end
    
    return crit
end

entries = readings
pos = 0
while entries.length > 1 do
    crit = find_crit_bit(entries, pos, "most", 1)
    entries = entries.select {|v| v[pos] == crit}
    pos +=1
end
ogen = entries[0]
ogen_d = ogen.join().to_i(2)
print "Oxygen Generator Rating: {#{ogen}} (#{ogen_d})\n\n"

entries = readings
pos = 0
while entries.length > 1 do
    crit = find_crit_bit(entries, pos, "least",0)
    entries = entries.select {|v| v[pos] == crit}
    pos +=1
end
coscrub = entries[0]
coscrub_d = coscrub.join().to_i(2)
print "CO2 Scrubber Rating: #{coscrub} (#{coscrub_d})\n\n"

life_support = ogen_d * coscrub_d
print "life_support: #{life_support}\n"
