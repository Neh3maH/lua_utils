local lib = {}

lib.misc = require 'utils/misc'
for k, v in pairs(lib.misc) do
	lib[k] = v
end

lib.collections = require 'utils/collections'
lib.types = require 'utils/types'
lib.lib = require 'utils/lib'

lib.shell = shell or require 'utils/shell'
lib.fs = fs or require 'utils/fs'

return lib
