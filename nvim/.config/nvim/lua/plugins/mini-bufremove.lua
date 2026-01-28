local function delete_buffer()
	require("mini.bufremove").delete(0, false)
	vim.defer_fn(function()
		local bufs = vim.fn.getbufinfo({ buflisted = 1 })
		local real_bufs = vim.tbl_filter(function(b)
			return b.name ~= ""
		end, bufs)
		if #real_bufs == 0 and vim.bo.filetype ~= "alpha" then
			local empty_buf = vim.api.nvim_get_current_buf()
			vim.cmd("Alpha")
			vim.api.nvim_buf_delete(empty_buf, { force = true })
		end
	end, 10)
end

local function delete_all_buffers()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	for _, buf in ipairs(bufs) do
		require("mini.bufremove").delete(buf.bufnr, false)
	end
	vim.cmd("Alpha")
end

return {
	"echasnovski/mini.bufremove",
	keys = {
		{ "<leader>bd", delete_buffer },
		{ "<leader>bD", delete_all_buffers },
	},
}
