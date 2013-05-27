#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (C) 2013 Atalanta Systems Ltd
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'java::openjdk'


yum_repository 'jenkins' do
  repo_name 'jenkins'
  description 'Jenkins Repository'
  url 'http://pkg.jenkins-ci.org/redhat'
  action :add
end

yum_key 'jenkins-ci.org.key' do
  url 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
  action :add
end

package 'jenkins'

service 'jenkins' do
  action [ :enable, :start ]
end
