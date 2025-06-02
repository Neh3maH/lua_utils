local lib = {}

local path_searcher = package.searchers[2]

local function mk_searcher(pwd)
	local path = pwd .. '/src/'
	print("INIT SEARCHER")
	local function searcher(mod)
		local capture = string.match(mod, '^utils/([^/]+)$')
		print("CALL SEARCHER: ", mod, capture)
		if capture then
			return path_searcher(path .. capture)
		end
	end

	return searcher
end

local function init()
	lib.misc = require 'utils/misc'
	for k, v in pairs(lib.misc) do
		lib[k] = v
	end

	lib.shell = shell or require 'utils/shell'
	lib.collections = require 'utils/collections'
	lib.types = require 'utils/types'
	lib.lib = require 'utils/lib'
	lib.fs = fs or require 'utils/fs'
	lib.misc = misc
	return lib
end

if not __UTILS__LIB__LOCATION__ then
	print("UNSET")
	return function(pwd)
		__UTILS__LIB__LOCATION__ = pwd
		package.searchers[#package.searchers + 1] = mk_searcher(pwd)
		return init(lib)
	end
end

init(lib)

print(type(lib), tmp)

return lib
