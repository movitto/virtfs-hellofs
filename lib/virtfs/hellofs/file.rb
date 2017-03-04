module VirtFS::HelloFS
  # File class representation, responsible for
  # managing corresponding dir_entry attributes
  # and file content.
  #
  # For HelloFS, files are simple in memory strings
  class File
    attr_accessor :superblock, :dir_entry

    def initialize(superblock, dir_entry)
      @sb        = superblock
      @dir_entry = dir_entry
    end

    def to_h
      { :directory? => dir?,
        :file?      => file?,
        :symlink?   => false }
    end

    def dir?
      dir_entry.is_a?(Hash)
    end

    def file?
      dir_entry.is_a?(String)
    end

    def fs
      @sb.fs
    end

    def size
      dir? ? 0 : dir_entry.size
    end

    def close
    end
  end # class File
end # module VirtFS::HelloFS
