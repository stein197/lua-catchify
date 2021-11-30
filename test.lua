local try = require ""
local luaunit = require "luaunit"

TestCatchify = {

	["test: Error in try() is being silent"] = function ()
		try(
			function ()
				error "Error"
			end
		)
		try {
			function ()
				error "Error"
			end
		}
	end;

	["test: Error in try() is being processed in catch()"] = function ()
		local var1
		local var2
		try(function ()
			error "Error"
		end):catch(function (msg)
			var1 = msg
		end)
		try {
			function ()
				error "Error"
			end
		} :catch {
			function (msg)
				var2 = msg
			end
		}
		luaunit.assertStrContains(var1, "Error")
		luaunit.assertStrContains(var2, "Error")
	end;

	["test: No errors in try() won't make catch() execute"] = function ()
		local var1
		local var2
		try(function () end):catch(function (msg)
			var1 = msg
		end)
		try {
			function () end
		} :catch {
			function (msg)
				var2 = msg
			end
		}
		luaunit.assertNil(var1)
		luaunit.assertNil(var2)
	end;

	["test: finally() executes after error in try()"] = function ()
		local var1
		local var2
		try(function ()
			error "Error"
		end):catch(function (msg)
			var1 = msg
		end):finally(function ()
			var1 = "Finally"
		end)
		try {
			function ()
				error "Error"
			end
		} :catch {
			function (msg)
				var2 = msg
			end
		} :finally {
			function ()
				var2 = "Finally"
			end
		}
		luaunit.assertEquals(var1, "Finally")
		luaunit.assertEquals(var2, "Finally")
	end;

	["test: finally() executes after no errors in try()"] = function ()
		local var1
		local var2
		try(function () end):catch(function (msg)
			var1 = msg
		end):finally(function ()
			var1 = "Finally"
		end)
		try {
			function () end
		} :catch {
			function (msg)
				var2 = msg
			end
		} :finally {
			function ()
				var2 = "Finally"
			end
		}
		luaunit.assertEquals(var1, "Finally")
		luaunit.assertEquals(var2, "Finally")
	end;
}

os.exit(luaunit.run())
