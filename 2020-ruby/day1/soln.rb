# input = "test_input"
input = "input"

readings = File.readlines(input).map { |line| line.chomp.to_i}

readings.each do |u|
    readings.each do |v|
        readings.each do |w|
            if u + v + w == 2020 then
                print "u #{u}, v #{v}, w #{w}, u+v+w #{u+v+w}, uvw #{u*v*w}\n"
                exit
            end
        end
    end
end
