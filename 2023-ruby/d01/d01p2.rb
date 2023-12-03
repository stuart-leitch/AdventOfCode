# frozen_string_literal: true

NUMERALS = %w[one two three four five six seven eight nine].freeze

def check_for_numeral_at_start(line)
  NUMERALS.each.with_index(1) do |numeral, n|
    return n if line.start_with?(numeral)
  end
  0
end

def check_for_numeral_at_end(line)
  NUMERALS.each.with_index(1) do |numeral, n|
    return n if line.end_with?(numeral)
  end
  0
end

def get_first(line)
  until line.empty?
    n = check_for_numeral_at_start(line)
    if n != 0
      return n
    elsif line[0] =~ /[[:digit:]]/
      return line[0].to_i
    else
      line = line[1..-1]
    end
  end
end

def get_last(line)
  until line.empty?
    n = check_for_numeral_at_end(line)
    if n != 0
      return n
    elsif line[-1] =~ /[[:digit:]]/
      return line[-1].to_i
    else
      line = line[0..-2]
    end
  end
end

file = File.open(ARGV[0])
lines = file.readlines.map(&:chomp)

values = []
lines.each.with_index(1) do |line, line_no|
  print "#{line_no.to_s.rjust(4, '0')} '#{line}'\n"
  first = get_first(line)
  last = get_last(line)

  value = first * 10 + last
  values << value

  print "---> <#{first},#{last}> #{value}\n\n"
end
p values.sum
