# frozen_string_literal: true

def differences(array)
  array.each_cons(2).map { |v1, v2| v2 - v1 }
end

def calc_next_value(history)
  return 0 if history.count(0) == history.size

  history[-1] + calc_next_value(differences(history))
end

def calc_prev_value(history)
  calc_next_value(history.reverse)
end

print 'Part 1: '
p File.open(ARGV[0]).readlines.map { |line| line.split.map(&:to_i) }.map { |l| calc_next_value(l) }.sum
print 'Part 2: '
p File.open(ARGV[0]).readlines.map { |line| line.split.map(&:to_i) }.map { |l| calc_prev_value(l) }.sum
