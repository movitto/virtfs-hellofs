module VirtFS::HelloFS
  # Top level filesystem construct.
  #
  # In our case, we simply create a new
  # root directory from the HelloFS
  # json hash, but in most cases this
  # would parse / read top level metadata
  class Superblock
    attr_accessor :device

    def initialize(fs, device)
      @fs     = fs
      @device = device
    end

    def root_dir
      Dir.new(self, device)
    end
  end # class SuperBlock
end # module VirtFS::Hello
