require 'chefspec'

describe 'jenkins::default' do

  let(:chef_run) {
    runner = ChefSpec::ChefRunner.new({:log_level => :debug, :platform => 'centos', :version => '6.3'})
    runner.converge 'jenkins::default'
    runner
  }

  it 'should totally include the OpenJDK recipe from the Java cookbook' do
    chef_run.should include_recipe 'java::openjdk'
  end

end
