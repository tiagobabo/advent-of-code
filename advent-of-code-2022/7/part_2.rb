require 'ostruct'

class Folder
  attr_accessor :parent, :folders, :files_size

  def initialize(parent: nil)
    @parent = parent
    @folders = []
    @files_size = 0
  end

  def size
    @files_size + folders.map(&:size).sum
  end

  def find_candidates(space)
    candidates = []
    candidates.push(size) if size >= space

    return candidates if folders.empty?

    candidates.concat(folders.flat_map { |folder| folder.find_candidates(space) })
  end
end

root_folder = Folder.new
current_folder = root_folder

File.readlines('input.txt', chomp: true).each do |line|
  if line.start_with?('$')
    _, command, arg = line.split(' ')

    next unless command == 'cd'

    case arg
    when '..'
      current_folder = current_folder.parent
    when '/'
      current_folder = root_folder
    else
      new_folder = Folder.new(parent: current_folder)
      current_folder.folders.push(new_folder)
      current_folder = new_folder
    end
  elsif !line.start_with?('dir')
    size, _ = line.split(' ')
    current_folder.files_size += size.to_i
  end
end

unused_space = 70000000 - root_folder.size
needed_space = 30000000 - unused_space
candidates = root_folder.find_candidates(needed_space)

puts candidates.sort.first
