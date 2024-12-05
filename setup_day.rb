require 'uri'
require 'net/http'

require_relative 'paths'

day = ARGV.first&.to_i || 0

raise "Invalid day input #{ARGV.first}. Usage: ruby setup_day.rb <day_number>" unless day.positive? && day <= 25

day_dir = Paths.day_dir(day)
part_one_path = Paths.solution(day_dir, 1)
part_two_path = Paths.solution(day_dir, 2)
input_path = Paths.input(day_dir)

if part_one_path.exist? && part_two_path.exist? && input_path.exist?
  puts "All day #{day} files already exist."
  exit(0)
end

day_dir.mkdir unless day_dir.directory?

solution_template = <<~RUBY
  # frozen_string_literal: true
  
  require_relative "../solution_base"

  class Solution < SolutionBase
    def solve(lines)
      # TODO
    end
  end
RUBY

input_path.write("") unless input_path.exist?
puts "Created empty input file."
part_one_path.write(solution_template) unless part_one_path.exist?
puts "Wrote #{part_one_path}"
part_two_path.write(solution_template) unless part_two_path.exist?
puts "Wrote #{part_two_path}"

puts "Done"
exit(0)