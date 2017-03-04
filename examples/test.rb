require 'json'
require 'virtfs'
require 'virtfs/hellofs'

PATH = JSON.parse(File.read('hello.fs'))

exit 1 unless VirtFS::HelloFS::FS.match?(PATH)
fs = VirtFS::HelloFS::FS.new(PATH)

VirtFS.mount fs, '/'
puts VirtFS::VDir.entries('/')
