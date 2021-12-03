# input = "test_input"
input = "input"

zeros = []
ones = []

File.readlines(input).each { |reading|
    reading.strip!
    # puts reading

    value = reading.chars

    value.each_with_index do |v,i|
        zeros[i] = 0 if zeros[i].nil?
        ones[i] = 0 if ones[i].nil?

        # p "#{i}:#{v}"
        if v == "0" then
            zeros[i] = zeros[i] + 1
        elsif v=="1" then
            ones[i] = ones[i] + 1
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
print "power_consumption: #{power_consumption}"