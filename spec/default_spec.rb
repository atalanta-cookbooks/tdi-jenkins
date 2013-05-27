require 'spec_helper'
describe 'jenkins::default' do

  let(:chef_run) do
    runner = ChefSpec::ChefRunner.new(
                                      platform: 'redhat',
                                      version: '6.3',
                                      log_level: :debug,
                                      step_into: [ 'yum_repository', 'yum_key' ],
                                      ) do |node|
    end
    Chef::Config.force_logger true
    runner.converge('jenkins::default')
  end
  
  it 'should include the OpenJDK recipe from the Java cookbook' do
    expect(chef_run).to include_recipe 'java::openjdk'
  end

  it 'should install Java' do
    expect(chef_run).to install_package 'java-1.6.0-openjdk'
  end

  it 'should set up the Jenkins yum repo' do
    expect(chef_run).to create_file('/etc/yum.repos.d/jenkins.repo')
    expect(chef_run).to create_file_with_content('/etc/yum.repos.d/jenkins.repo', /Jenkins/)
  end
  
  it 'should import the Jenkins GPG key' do
    expect(chef_run).to create_remote_file('/etc/pki/rpm-gpg/jenkins-ci.org.key').with(
                                                                                       :source => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
                                                                                       )
    expect(chef_run).to execute_command('rpm --import /etc/pki/rpm-gpg/jenkins-ci.org.key')
  end

  it 'should install the Jenkins package' do
    expect(chef_run).to install_package('jenkins')
  end

  it 'should start the Jenkins service' do
    expect(chef_run).to start_service 'jenkins'
  end
  
  it 'should enable the Jenkins service' do
    expect(chef_run).to set_service_to_start_on_boot 'jenkins'
  end

end
