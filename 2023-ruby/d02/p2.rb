# frozen_string_literal: true

powers = []
File.open(ARGV[0]).readlines.map(&:chomp).each do |line|
  greens = []
  blues = []
  reds = []
  # p line
  game, record = line.split(': ')
  game.delete_prefix!('Game ')
  rounds = record.split('; ')
  rounds.each do |round|
    cubes = round.split(', ')
    cubes.each do |cube|
      number, color = cube.split(' ')
      case color
      when 'green'
        greens << number.to_i
      when 'blue'
        blues << number.to_i
      when 'red'
        reds << number.to_i
      end
    end
  end
  powers << (greens.max * blues.max * reds.max)
  print '.'
end
print "\n"
p powers.sum
