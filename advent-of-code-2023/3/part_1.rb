ROWS = File.readlines('input.txt', chomp: true).map { |row| row.split('') }
ROWS_COUNT = ROWS.count
COLUMNS_COUNT = ROWS.first.count

def part_number?(row, column)
  (-1..1).to_a.product((-1..1).to_a).any? do |r, c|
    next if r == 0 && c == 0

    r += row
    c += column

    next unless (0..ROWS_COUNT - 1).include?(r) && (0..COLUMNS_COUNT - 1).include?(c)

    ROWS[r][c] != '.' && !is_number?(ROWS[r][c])
  end
end

def is_number?(value)
  value.to_i.to_s == value
end

numbers = []

ROWS.each_with_index do |row, row_n|
  current_number = ''
  is_part_number = false

  row.each_with_index do |column, column_n|
    n_is_number = is_number?(column)

    if n_is_number
      current_number << column

      is_part_number ||= true if part_number?(row_n, column_n)
    end

    if is_part_number && (!n_is_number || column_n == COLUMNS_COUNT - 1)
      numbers << current_number.to_i if is_part_number
    end

    unless n_is_number
      current_number = ''
      is_part_number = false
    end
  end
end

p numbers.sum
