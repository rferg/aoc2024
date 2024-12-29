require_relative 'test/test'

pattern = ARGV.first || "test/**/*_test.rb"
Dir[pattern].each do |path|
  require_relative path
end

Result = Data.define(:klass, :method, :error) do
  def failure_message
    return "" if error.nil?

    [
      "#{klass} #{method} failed with #{error.message}",
      "",
      *(error.backtrace.grep_v(/^test.rb:/))
    ].join("\n")
  end
end

raise "No tests found at #{pattern}." if Test.subclasses.empty?

results = []
Test.subclasses.each do |test_class|
  test_class.instance_methods.grep(/^test_/).each do |method|
    inst = test_class.new
    inst.public_send(method)
    results << Result.new(test_class, method, nil)
  rescue StandardError => e
    results << Result.new(test_class, method, e)
  end
end

failed = results.select(&:error)

if failed.empty?
  puts "All #{results.length} passed!"
else
  puts "\n\n#{">" * 8} #{failed.length} of #{results.length} failed #{"<" * 8}\n\n"

  failed.each_with_index do |r, i|
    puts "#{i + 1}. #{r.failure_message}\n\n"
  end
end


