local lib = function (pwd)
	local old_path = package.path
	package.path = pwd .. '/src/?.lua;' .. package.path

	lib = {}
	lib.misc = require 'misc'
	for k, v in pairs(lib.misc) do
		lib[k] = v
	end

	lib.shell = shell or require 'shell'
	lib.collections = require 'collections'
	lib.types = require 'types'
	lib.fs = fs or require 'fs'
	lib.misc = misc

	package.path = old_path
	return lib
end

return lib
