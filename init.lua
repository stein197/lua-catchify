local function getcallback(f)
	return type(f) == "table" and f[1] or f
end

local metatable = {
	__index = {
		catch = function (self, f)
			if not self.ok then
				getcallback(f)(self.rs)
			end
			return self
		end;

		finally = function (self, f)
			getcallback(f)()
		end;
	}
}

local function ctor(ok, rs)
	return setmetatable({
		ok = ok,
		rs = rs
	}, metatable)
end

return function (f)
	return ctor(pcall(getcallback(f)))
end
