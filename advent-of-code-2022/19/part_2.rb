
blueprints = {}
max_minutes = 32

File.readlines('input.txt', chomp: true).each.with_index(1) do |line, i|
  tokens = line.split(' ')

  blueprints[i] = {
    ore_robot_ore_cost: tokens[6].to_i,
    clay_robot_ore_cost: tokens[12].to_i,
    obsidian_robot_ore_cost: tokens[18].to_i,
    obsidian_robot_clay_cost: tokens[21].to_i,
    geode_robot_ore_cost: tokens[27].to_i,
    geode_robot_obsidian_cost: tokens[30].to_i
  }
end

value = blueprints.take(3).map do |i, blueprint|
  queue = [[0, 0, 0, 0, 1, 0, 0, 0, 1, []]]

  seen = {}
  best = 0
  max_ore_needed = [blueprint[:ore_robot_ore_cost], blueprint[:clay_robot_ore_cost], blueprint[:obsidian_robot_ore_cost], blueprint[:geode_robot_ore_cost]].max
  max_clay_needed = blueprint[:obsidian_robot_clay_cost]
  max_obsidian_needed = blueprint[:geode_robot_obsidian_cost]

  while queue.size > 0
    ore_count, clay_count, obsidian_count, geode_count, ore_robot_count, clay_robot_count, obsidian_robot_count, geode_robot_count, minutes, can_do = queue.shift
    next_ore_count = ore_count + ore_robot_count
    next_clay_count = clay_count + clay_robot_count
    next_obsidian_count = obsidian_count + obsidian_robot_count
    next_geode_count = geode_count + geode_robot_count

    next if next_geode_count < best - 2

    key = [ore_robot_count, clay_robot_count, obsidian_robot_count, geode_robot_count, ore_count, clay_count, obsidian_count]
    value = geode_count

    next if seen.fetch(key, -1) >= value

    seen[key] = value

    best = [best, next_geode_count].max

    next if minutes == max_minutes

    if !can_do.include?(:geode) && ore_count >= blueprint[:geode_robot_ore_cost] && obsidian_count >= blueprint[:geode_robot_obsidian_cost]
      queue.push([
        next_ore_count - blueprint[:geode_robot_ore_cost],
        next_clay_count,
        next_obsidian_count - blueprint[:geode_robot_obsidian_cost],
        next_geode_count,
        ore_robot_count,
        clay_robot_count,
        obsidian_robot_count,
        geode_robot_count + 1,
        minutes + 1,
        []
      ])

      can_do << :geode
    end

    if !can_do.include?(:obsidian) && obsidian_robot_count < max_obsidian_needed && ore_count >= blueprint[:obsidian_robot_ore_cost] && clay_count >= blueprint[:obsidian_robot_clay_cost]
      queue.push([
        next_ore_count - blueprint[:obsidian_robot_ore_cost],
        next_clay_count - blueprint[:obsidian_robot_clay_cost],
        next_obsidian_count,
        next_geode_count,
        ore_robot_count,
        clay_robot_count,
        obsidian_robot_count + 1,
        geode_robot_count,
        minutes + 1,
        []
      ])

      can_do << :obsidian
    end

    if !can_do.include?(:clay) && clay_robot_count < max_clay_needed && ore_count >= blueprint[:clay_robot_ore_cost]
      queue.push([
        next_ore_count - blueprint[:clay_robot_ore_cost],
        next_clay_count,
        next_obsidian_count,
        next_geode_count,
        ore_robot_count,
        clay_robot_count + 1,
        obsidian_robot_count,
        geode_robot_count,
        minutes + 1,
        []
      ])

      can_do << :clay
    end

    if !can_do.include?(:ore) && ore_robot_count < max_ore_needed && ore_count >= blueprint[:ore_robot_ore_cost]
      queue.push([
        next_ore_count - blueprint[:ore_robot_ore_cost],
        next_clay_count,
        next_obsidian_count,
        next_geode_count,
        ore_robot_count + 1,
        clay_robot_count,
        obsidian_robot_count,
        geode_robot_count,
        minutes + 1,
        []
      ])

      can_do << :ore
    end

    queue.push([
      next_ore_count,
      next_clay_count,
      next_obsidian_count,
      next_geode_count,
      ore_robot_count,
      clay_robot_count,
      obsidian_robot_count,
      geode_robot_count,
      minutes + 1,
      can_do
    ])
  end

  best
end.reduce(:*)

p value
