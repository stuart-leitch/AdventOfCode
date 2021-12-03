#!/usr/bin/ruby

nums = File.readlines('mini_input')

# nums = Array[1,2,3,4,5]
last = nil
count = 0
v = 0

nums.each { |x|
    v += 1
    x = x.to_i
    print "#{v} : #{last} : #{x} : "
    unless last == nil
        if x > last then 
            count += 1
            print "up"
        end
    end
    print "\n"
    last = x
}
puts count