require_relative 'paths'

day, part = ARGV.map { |n| n&.to_i || 0 }

raise "Invalid day #{ARGV.first}." unless day.positive? && day <= 25
raise "Invalid part #{ARGV[1]}." unless part == 1 || part == 2

day_dir = Paths.day_dir(day)

raise "Day #{day_dir} directory does not exist. Try: ruby setup_day.rb #{day}" unless day_dir.directory?

require_relative Paths.solution(day_dir)

input_path = Paths.input(day_dir)

raise "Input file #{input_path} does not exist." unless input_path.exist?
raise "Input file #{input_path} is empty." if input_path.zero?

lines = input_path.readlines(chomp: true)
solution = Solution.new
result = if part == 1
          solution.part_one(lines)
        else
          solution.part_two(lines)
        end
raise "Result was nil." if result.nil?
raise "Result was empty." if result.empty?

puts "Answer: #{result}"

IO.popen("pbcopy", "w") { |pipe| pipe.puts result.to_s }

puts "Copied to clipboard."