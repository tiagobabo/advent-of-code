rows = File.readlines('input.txt', chomp: true).map { |row| row.split('').map(&:to_i) }
count = rows.length * 2 + (rows.first.length - 2) * 2
rows_count = rows.size

rows[1..-2].each.with_index(1) do |row, row_index|
  row[1..-2].each.with_index(1) do |n, column_index|
    next if rows[row_index][0...column_index].any? { |r| r >= n } &&
            rows[row_index][(column_index + 1)..-1].any? { |r| r >= n } &&
            (0..(row_index - 1)).any? { |i| rows[i][column_index] >= n } &&
            ((row_index + 1)...rows_count).any? { |i| rows[i][column_index] >= n }
    count += 1
  end
end

p count
