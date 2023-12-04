rows = File.readlines('input.txt', chomp: true).map { |row| row.split('').map(&:to_i) }
rows_count = rows.size

max = 0

rows.each_with_index do |row, row_index|
  row.each_with_index do |n, column_index|
    left, right, top, bottom = 0, 0, 0, 0

    rows[row_index][0...column_index].reverse.each do |r|
      left += 1 if r <= n
      break if r >= n
    end

    rows[row_index][(column_index + 1)..-1].each do |r|
      right += 1 if r <= n
      break if r >= n
    end

    (0..(row_index - 1)).to_a.reverse.each do |i|
      top += 1 if rows[i][column_index] <= n
      break if rows[i][column_index] >= n
    end

    ((row_index + 1)...rows_count).each do |i|
      bottom += 1 if rows[i][column_index] <= n
      break if rows[i][column_index] >= n
    end

    score = left * right * top * bottom
    max = score if score > max
  end
end

p max
