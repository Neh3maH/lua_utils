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

module.Module = { name = nil, deps = {}, init = nil}

function module.Module:new(name, deps, init)
	local new = { name = name, deps = deps, init = init }
	setmetatable(new, self)
	self.__index = self
end

function module.Module:ld()
	for k, _ in pairs(package.loaded) do
		if self.name == k then
			local ret = require tostring(self.name);
			return ret
		end
	end

	return function(pwd)
		package.searchers[#package.searchers + 1] = mk_searcher(self.name, pwd)
	end
end

return module
