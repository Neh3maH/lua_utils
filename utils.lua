local lib = {}

if not __UTILS__LIB__LOCATION__ then
	print("UNSET")
	return function(pwd)
		__UTILS__LIB__LOCATION__ = pwd
	end
end

local function pwd()
	return __UTILS__LIB__LOCATION__
end

package.path = pwd() .. '/src/?.lua;' .. package.path

lib.misc = require 'misc'
for k, v in pairs(lib.misc) do
	lib[k] = v
end

lib.shell = shell or require 'shell'
lib.collections = require 'collections'
lib.types = require 'types'
lib.fs = fs or require 'fs'
lib.misc = misc

print(type(lib), tmp)

return lib
