module VirtFS::HelloFS
  # Dir class representation, responsible
  # for managing corresponding dir_entry
  # attributes
  #
  # For HelloFS, dirs are simply nested
  # json maps
  class Dir
    attr_accessor :sb, :dir_entry

    def initialize(sb, dir_entry)
      @sb        = sb
      @dir_entry = dir_entry
    end

    def close
    end

    def glob_names
      dir_entry.keys
    end

    def find_entry(name, type = nil)
      dir = type == :dir
      fle = type == :file

      return nil unless glob_names.include?(name)
      return nil if (dir && !dir_entry[name].is_a?(Hash)) ||
                    (fle && !dir_entry[name].is_a?(String))
      dir ? Dir.new(sb, dir_entry[name]) :
            File.new(sb, dir_entry[name])
    end
  end # class Directory
end # module VirtFS::HelloFS
