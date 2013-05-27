require File.expand_path('../support/helpers', __FILE__)

describe 'jenkins::default' do

  include Helpers::Jenkins

  it "installs Java" do
    package("java-1.6.0-openjdk").must_be_installed
  end

  it "ensures the installed Java is OpenJDK" do
    assert_sh("java -version 2>&1 | grep OpenJDK")
  end
  
  it "makes the Jenkins yum repository available" do
    file("/etc/yum.repos.d/jenkins.repo").must_exist
    file('/etc/yum.repos.d/jenkins.repo').must_match /pkg\.jenkins-ci\.org\/redhat$/
  end

  it "enables the Jenkins yum repository" do
    assert_sh("yum repolist | grep Jenkins")
  end

  it "installs the Jenkins package" do
    package("jenkins").must_be_installed
  end

  it "starts the Jenkins service" do
    service("jenkins").must_be_running
  end

  it "enables the Jenkins service" do
    service("jenkins").must_be_enabled
  end

  it "results in a service running on port 8080" do
    assert_sh("netstat -anlp | fgrep 8080")
  end

  it "serves the main Jenkins dashboard" do
    assert_sh("wget -O - http://localhost:8080 2>&1 | grep 'Dashboard \\\[Jenkins\\\]'")
  end

end
