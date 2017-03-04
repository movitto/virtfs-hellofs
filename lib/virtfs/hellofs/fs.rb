require_relative 'fs/dir_class_methods'
require_relative 'fs/file_class_methods'

module VirtFS::HelloFS
  class FS
    include DirClassMethods
    include FileClassMethods

    attr_accessor :mount_point, :superblock

    # Return bool indicating if device contains
    # a HelloFS instance
    def self.match?(device)
      begin
        Superblock.new(self, device)
        return true
      rescue => err
        return false
      end
    end

    # Initialze new HelloFS instance w/ the
    # specified device
    def initialize(device)
      @superblock  = Superblock.new(self, device)
    end

    # Return root directory of the filesystem
    def root_dir
      superblock.root_dir
    end

    def thin_interface?
      true
    end

    def umount
      @mount_point = nil
    end
  end # class FS
end # module VirtFS::HelloFS
