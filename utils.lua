local lib = {}

local old_path = package.path
package.path = './src/?.lua;' .. package.path

lib.misc = require 'misc'
for k, v in pairs(lib.misc) do
	lib[k] = v
end

lib.collections = require 'collections'
lib.types = require 'types'
lib.path = require 'path'
lib.misc = misc

package.path = old_path

return lib
