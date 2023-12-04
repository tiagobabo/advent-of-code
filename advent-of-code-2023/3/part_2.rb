ROWS = File.readlines('input.txt', chomp: true).map { |row| row.split('') }
ROWS_COUNT = ROWS.count
COLUMNS_COUNT = ROWS.first.count

def find_powers(row, column)
  (-1..1).to_a.product((-1..1).to_a).filter_map do |r, c|
    next if r == 0 && c == 0

    r += row
    c += column

    next unless (0..ROWS_COUNT - 1).include?(r) && (0..COLUMNS_COUNT - 1).include?(c)

    "#{r}:#{c}" if ROWS[r][c] == '*'
  end
end

def is_number?(value)
  value.to_i.to_s == value
end

all_powers = {}

ROWS.each_with_index do |row, row_n|
  current_number = ''
  current_power_position = nil

  row.each_with_index do |column, column_n|
    n_is_number = is_number?(column)

    if n_is_number
      current_number << column
      current_power_position ||= find_powers(row_n, column_n).first
    end

    if current_power_position && (!n_is_number || column_n == COLUMNS_COUNT - 1)
      all_powers[current_power_position] ||= []
      all_powers[current_power_position] << current_number.to_i
    end

    unless n_is_number
      current_number = ''
      current_power_position = nil
    end
  end
end

p all_powers.values.select { |values| values.size > 1 }.map { |v| v.inject(:*) }.sum
