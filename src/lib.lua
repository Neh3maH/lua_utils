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

module.Module = { name = nil, deps = {}, init = nil }

function module.Module:new(name, deps, init)
	local new = { name = name, deps = deps, init = init }
	setmetatable(new, self)
	self.__index = self
	return new
end

function module.Module:ld(pwd)
	package.path = pwd .. '/libs/?/lib.lua;' .. package.path
	if '.' == path then
		package.searchers[#package.searchers + 1] = module.mk_searcher(self.name, pwd)
	end
	local p = pwd .. '/libs/'
	for _, dep in pairs(self.deps) do
		local path = p .. dep
		package.searchers[#package.searchers + 1] = module.mk_searcher(dep, path)
		local pack = require(path .. '/deps')
		pack:ld(path)
	end
end

return module
