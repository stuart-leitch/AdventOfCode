readings = File.readlines('input')

count = 0
window = []

readings.each { |x|
    window << x.to_i
    print "#{window} : "
    
    unless window.length() == 4
        print "\n"
        next
    end

    depth1 = window[0..2].sum
    depth2 = window[1..3].sum
    print "#{depth1} : #{depth2} : "
    
    
    if depth2 > depth1 then 
        count += 1
        print "up"
    end
    
    window.shift()
    print "\n"
}
puts count