-- [Full Boarder](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi)
require("full-border"):setup()

-- [Git](https://github.com/yazi-rs/plugins/tree/main/git.yazi)
th.git = th.git or {}
th.git.unknown_sign = " "
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.clean_sign = "✔"
require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}

-- [MIME EXT](https://github.com/yazi-rs/plugins/tree/main/mime-ext.yazi)
require("mime-ext.local"):setup {
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
		-- ...
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		mk = "text/makefile",
		-- ...
	},

	-- If the MIME type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime.local` plugin, which uses `file(1)`
	fallback_file1 = false,
}

-- [Smart Enter](https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi) 
require("smart-enter"):setup {
	open_multi = true,
}
