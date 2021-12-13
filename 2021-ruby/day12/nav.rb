require "set"

class Nav
  attr_reader :paths

  def initialize(file)
    get_connections(file)
    @paths = Set.new()
  end

  def get_connections(file)
    @connections = []
    lines = File.readlines(file).each do |line|
      connection = line.strip.split("-")
      @connections << connection unless connection[1] == "start" || connection[0] == "end"
      @connections << connection.reverse unless connection[0] == "start" || connection[1] == "end"
    end
    print_connections
  end

  def print_connections
    print "\nConnections <------- (#{@connections.count})\n"
    @connections.each { |c| print "\t#{c}\n" }
    print "Connections  ------->\n\n"
  end

  def get_start_connections()
    @start_connections = Set.new()
    @start_connections = @connections.select { |c| c[0] == "start" }
  end

  def print_paths
    print "Paths <---------- (#{@paths.count})\n"
    @paths.each { |p| print "\t#{p.join ","}\n" }
    print "Paths  ---------->\n\n"
  end

  def no_small_cave_twice_yet(path)
    tallies = path.select { |v| v.match(/\A[a-z]*\z/) }.tally

    print "\t\tFilter Small Cave #{tallies}\n" if tallies.values.max > 1

    return true if (tallies.values.max < 2)
  end

  def extend_path(path)
    extensions = @connections.select { |ex| ex[0] == path.last }
    return if extensions.count == 0
    print "\t<#{path.join(",")}> + ("

    print "#{extensions.count}) from <#{path.last}> to <"
    extensions.each { |e| print "#{e[1]} " }
    print ">\n"

    extensions = extensions.select { |ex|
      ex[1].match(/\A[A-Z]*\z/) ||
      ex[1] == "end" ||
      !path.include?(ex[1]) ||
      no_small_cave_twice_yet(path)
    }
    print "\t\tFiltering... (#{extensions.count}) <"
    extensions.each { |e| print "#{e[1]} " }
    print ">\n"
    # extensions.each { |e| print "\t\t\t#{e}\n" }

    # @newpaths = Set.new()
    # p extensions
    return if extensions.count == 0
    extensions.each do |e|
      newpath = path.clone
      newpath << e[1]
      # p newpath
      @newpaths << newpath
    end
  end

  def try_to_expand_paths
    @newpaths = Set.new()
    @length_before = @paths.length

    @lastpaths.each { |path| extend_path(path) }
    @paths.merge(@newpaths)
    @lastpaths = @newpaths.clone
    return paths.length != @length_before
  end

  def expand_paths
    @paths = Set.new(@start_connections)
    @lastpaths = Set.new(@start_connections)
    print_paths
    loop do
      print "Expanding New Paths <============= (#{@lastpaths.count} of #{@paths.count})\n"
      expanded = try_to_expand_paths
      print "Expanding New Paths =============> (+#{@lastpaths.count} of #{@paths.count})\n\n"
      print_paths
      break if expanded == false
    end
    @paths.delete_if { |p| p.last != "end" }
  end
end

nav = Nav.new("input")
nav.get_start_connections
nav.expand_paths
nav.print_paths
p nav.paths.count

# check = File.readlines("t1.out").each.map(&:strip)
# print "\n#{check.length}\n"
# check = check.delete_if { |e| nav.paths.include?(e.split(",")) }
# print "\n#{check.length}\n"
# print "#{check.join("\n")}"
