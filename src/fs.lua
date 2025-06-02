local types = require 'utils/types'

local module = {}

function module.delete(path)
	assert(types.is.str(path) and path ~= "", "rm invalid path")
	return os.execute("rm -rf " .. path)
end

function module.makeDir(path)
	assert(types.is.str(path) and path ~= "", "mkdir invalid path")
	return os.execute("mkdir -p " .. path)
end

return module
