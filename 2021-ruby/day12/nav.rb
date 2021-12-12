require "set"

def ppaths
  print "\n"
  $paths.each { |p| print "#{p.join ","}\n" }
  print "\n"
end

connections = []
lines = File.readlines("input")
lines.each do |line|
  connection = line.strip.split("-")
  connections << connection
  connections << [connection[1], connection[0]] unless connection[0] == "start" || connection[1] == "end"
end
connections.each { |c| print "#{c}\n" }

$paths = Set.new()
start_paths = connections.select { |c| c[0] == "start" }
$paths.merge(start_paths)
ppaths

# was = paths.length
loop do
  was = $paths.length
  newpaths = Set.new()
  $paths.each do |p|
    print "Extending path <#{p.join(",")}> from '#{p.last}'\n"
    extensions = connections.select { |c| c[0] == p.last }
    extensions = extensions.select { |e| (!p.include?(e[1]) || e[1].match(/\A[A-Z]*\z/)) }
    print "\tMatching extensions: #{extensions}\n"
    extensions.each do |e|
      print "\tExtending path <#{p.join(",")}> with connection <#{e}>\n"
      newpath = []
      newpath = p.clone
      newpath << e[1]
      print "\t\tNew path: #{newpath}\n"
      newpaths << newpath
    end
  end
  print "\nNew Paths: #{newpaths}\n"
  ppaths
  $paths.merge(newpaths)
  break if was == $paths.length
  ppaths
end
$paths.delete_if { |p| p.last != "end" }
ppaths

p $paths.count
