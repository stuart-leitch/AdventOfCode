# input = "test_input"
input = "input"

zeros = []
ones = []

readings = File.readlines(input)

readings.each { |reading|
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
print "power_consumption: #{power_consumption}\n\n"

pos = 0
val=[]
ogen = readings

while ogen.length > 1 do
print "ogen: #{ogen}\n"
    ogen_next = []

    z = 0
    o = 0

    ogen.each do |v|
        v.strip!
        val = v.chars
        if val[pos] == "0" then
            z +=1
        else
            o +=1
        end
    end
    if o < z then
        crit = "0"
    else 
        crit = "1"
    end
    print "pos  #{[pos]}, Zeroes: #{z}, Ones: #{o}, Crit: #{crit}\n"
    

    ogen.each do |v|
        v.strip!
        val = v.chars
        print "pos: #{pos} val: #{val} gamma: #{gamma} "
        print "val: #{val[pos]} gamma: #{gamma[pos]}"
        if val[pos].to_i == crit.to_i then
            print " match"
            ogen_next << v
        end
        print "\n"
    end
    ogen = ogen_next
    pos +=1
end

print "Oxygen Generator Rating: #{ogen[0]} (#{ogen[0].to_i(2)})\n\n"

pos = 0
val=[]
coscrub = readings

while coscrub.length > 1 do
    print "coscrub: #{coscrub}\n"
        ogen_next = []
    
        z = 0
        o = 0
    
        coscrub.each do |v|
            v.strip!
            val = v.chars
            if val[pos] == "0" then
                z +=1
            else
                o +=1
            end
        end
        if o < z then
            crit = "1"
        else 
            crit = "0"
        end
        print "pos  #{[pos]}, Zeroes: #{z}, Ones: #{o}, Crit: #{crit}\n"
        
    
        coscrub.each do |v|
            v.strip!
            val = v.chars
            print "pos: #{pos} val: #{val} gamma: #{gamma} "
            print "val: #{val[pos]} gamma: #{gamma[pos]}"
            if val[pos].to_i == crit.to_i then
                print " match"
                ogen_next << v
            end
            print "\n"
        end
        coscrub = ogen_next
        pos +=1
    end
    print "CO2 Scrubber Rating: #{coscrub[0]} (#{coscrub[0].to_i(2)})\n\n"

    life_support = ogen[0].to_i(2) * coscrub[0].to_i(2)
print "life_support: #{life_support}\n"