moves = File.readlines('input')

fwd = 0
depth = 0
v = 0
d=0
c=0
aim = 0

moves.each { |move|
    v += 1

    d,c = move.split()
    c=c.to_i
    # x = x.to_i
    print "#{v} : #{d} :  #{c.to_i} : "
    if d == "forward" then
        fwd += c
        depth += aim * c
    elsif d == "up" then
        aim -= c
    elsif d = "down" then
        aim += c
    end
    print "\n"
}
print "Horizontal: #{fwd}, Depth: #{depth} (#{fwd * depth})"