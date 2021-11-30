# Tiny try-catch-finally implementation for Lua
![](https://img.shields.io/github/license/stein197/lua-catchify)
![](https://img.shields.io/github/v/tag/stein197/lua-catchify?label=Version)
![](https://img.shields.io/luarocks/v/stein197/lua-catchify)

Lua does not have a common syntax sugar to wrap the code that will possibly lead to errors. This package provides a very simple way to bring this sugar to Lua.

## Installation
Via LuaRocks:
```
luarocks install catchify
```
Or just download and require `init.lua` file from this repo.

## Usage
The whole concept can be illustrated in a single code piece below:
```lua
local try = require "catchify"
try(function ()
	error "Something's wrong!"
end):catch(function (e) -- e will contain error message
	print(e) -- > stdin:3: Something's wrong!
end):finally(function () -- Will be executed anyway
	print "Finally here!"
end)
```

You can pass a table containing single function instead of a function to make syntax more "curly":
```lua
try {
	function ()
		error "Something's wrong!"
	end
} :catch {
	function (e)
		print(e)
	end
} :finally {
	function ()
		print "Finally here!"
	end
}
```

## Testing
Install luaunit package:
```
luarocks install luaunit
```
Then run from the console:
```
lua test.lua
```
