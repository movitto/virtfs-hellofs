module VirtFS::HelloFS
  class FS
    # VirtFS Dir API implementation, dispatches
    # calls to underlying HelloFS constructs
    module DirClassMethods
      def dir_delete(p)
      end

      def dir_entries(p)
        dir = get_dir(p)
        return nil if dir.nil?
        dir.glob_names
      end

      def dir_exist?(p)
        begin
          !get_dir(p).nil?
        rescue
          false
        end
      end

      def dir_foreach(p, &block)
        r = get_dir(p).try(:glob_names)
                      .try(:each, &block)
        block.nil? ? r : nil
      end

      def dir_mkdir(p, permissions)
      end

      def dir_new(fs_rel_path, hash_args, _open_path, _cwd)
        get_dir(fs_rel_path)
      end

      private

      def get_dir(p)
        names = p.split(/[\\\/]/)
        names.shift

        dir = get_dir_r(names)
        raise "Directory '#{p}' not found" if dir.nil?
        dir
      end

      def get_dir_r(names)
        return root_dir if names.empty?

        # Check for this path in the cache.
        fname = names.join('/')

        name = names.pop
        pdir = get_dir_r(names)
        return nil if pdir.nil?

        de = pdir.find_entry(name)
        return nil if de.nil?

        Directory.new(self, superblock, de.inode)
      end
    end # module DirClassMethods
  end # class FS
end # module VirtFS::HelloFS
