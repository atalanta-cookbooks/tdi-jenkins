guard 'rspec', :cli => "--color" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
  watch('metadata.rb') { "spec" }
  watch(%r{^recipes/(.+)\.rb$}) { |m| "spec/unit/recipes/#{m[1]}_spec.rb" }
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb}) { |m| "spec/unit/providers/#{m[1]}_spec.rb" }
  watch(%r{^resources/(.+)\.rb}) { |m| "spec/unit/resources/#{m[1]}_spec.rb" }
end
