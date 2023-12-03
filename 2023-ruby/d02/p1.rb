# frozen_string_literal: true

possibles = []
File.open(ARGV[0]).readlines.map(&:chomp).each do |line|
  greens = []
  blues = []
  reds = []

  p line
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
  possibles << game.to_i unless greens.max > 13 || blues.max > 14 || reds.max > 12
  p ''
end
p possibles.sum
