def packet_1_winner?(packet_1, packet_2, position: 0)
  packet_1_item = packet_1[position]
  packet_2_item = packet_2[position]

  return if packet_1_item.nil? && packet_2_item.nil?
  return true if packet_1_item.nil?
  return false if packet_2_item.nil?

  if packet_1_item.is_a?(Integer) && packet_2_item.is_a?(Integer)
    return true if packet_1_item < packet_2_item
    return false if packet_1_item > packet_2_item

    packet_1_winner?(packet_1, packet_2, position: position + 1)
  else
    packet_1_item_winner = packet_1_winner?(
      packet_1_item.is_a?(Integer) ? [packet_1_item] : packet_1_item,
      packet_2_item.is_a?(Integer) ? [packet_2_item] : packet_2_item,
      position: 0
    )

    return packet_1_item_winner unless packet_1_item_winner == nil

    packet_1_winner?(packet_1, packet_2, position: position + 1)
  end
end

packets = [[[2]], [[6]]]

File.readlines('input.txt', chomp: true).each_slice(3).with_index do |(packet_1, packet_2, _), i|
  packets << eval(packet_1)
  packets << eval(packet_2)
end

packets.sort! { |packet_1, packet_2| 0 <=> (packet_1_winner?(packet_1, packet_2) ? 1 : -1) }

p (packets.find_index([[2]]) + 1) * (packets.find_index([[6]]) + 1)
