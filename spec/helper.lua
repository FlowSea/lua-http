TEST_TIMEOUT = 10

function assert_loop(cq, timeout)
	local ok, err, _, thd = cq:loop(timeout)
	if not ok then
		if thd then
			err = debug.traceback(thd, err)
		end
		error(err, 2)
	end
end

-- Solves https://github.com/keplerproject/luacov/issues/38
local cqueues = require "cqueues"
local luacov_runner = require "luacov.runner"
local wrap; wrap = cqueues.interpose("wrap", function(self, func, ...)
	func = luacov_runner.with_luacov(func)
	return wrap(self, func, ...)
end)
