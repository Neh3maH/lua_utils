local module = {}

function module.dir()
	return os.getenv("PWD")
end

function module.setDir(path)
end

return module
