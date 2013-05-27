require 'chefspec'
require 'berkshelf'

TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$: << File.expand_path(File.dirname(__FILE__))

Berkshelf.ui.mute!
berks = Berkshelf::Berksfile.from_file(File.join(TOPDIR, "Berksfile"))
berks.install(path: 'vendor/cookbooks')

module ChefSpec
  class ChefRunner
    %w{yum_key yum_repository}.each do |rtype|
      define_method(rtype) do |name|
        find_resource(rtype, name)
      end
    end
  end
end
