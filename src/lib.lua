local module = {}

module.path_searcher = package.searchers[2]

function module.mk_searcher(lib, pwd)
	pwd = pwd .. '/src/'
	local pattern = string.format("^%s/([^/]+)$", lib)
	return function(path)
		local mod = string.match(path, pattern)
		if mod then
			return module.path_searcher(pwd .. mod)
		end
	end
end

module.Module = { name = nil, deps = {} }

function module.Module:new(name, deps)
	local new = { name = name, deps = deps }
	setmetatable(new, self)
	self.__index = self
	return new
end

function module.Module:ld(pwd)
	package.path = pwd .. '/libs/?/lib.lua;' .. package.path
	if '.' == pwd then
		package.searchers[#package.searchers + 1] = module.mk_searcher(self.name, pwd)
	end
	pwd = pwd .. '/libs/'
	for _, dep in pairs(self.deps) do
		local path = pwd .. dep
		package.searchers[#package.searchers + 1] = module.mk_searcher(dep, path)
		local pack = require(path .. '/deps')
		pack:ld(path)
	end
end

return module
