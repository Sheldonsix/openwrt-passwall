local _M = {}

local function gh_hysteria1_release_url(self)
	return "https://api.github.com/repos/" .. self.repo .. "/releases/tags/v1.3.5"
end

local function gh_release_url(self)
	return "https://api.github.com/repos/" .. self.repo .. "/releases/latest"
end

local function gh_pre_release_url(self)
	return "https://api.github.com/repos/" .. self.repo .. "/releases?per_page=1"
end

_M.hysteria1 = {
	name = "Hysteria1",
	repo = "HyNetwork/hysteria",
	get_url = gh_hysteria1_release_url,
	cmd_version = "version | awk '/^Version:/ {print $2}'",
	zipped = false,
	default_path = "/usr/bin/hysteria1",
	match_fmt_str = "linux%%-%s$",
	file_tree = {
		armv6 = "arm",
		armv7 = "arm",
		mipsel = "mipsle"
	}
}

_M.hysteria = {
	name = "Hysteria",
	repo = "HyNetwork/hysteria",
	get_url = gh_release_url,
	cmd_version = "version | awk '/^Version:/ {print $2}'",
	remote_version_str_replace = "app/",
	zipped = false,
	default_path = "/usr/bin/hysteria",
	match_fmt_str = "linux%%-%s$",
	file_tree = {
		armv6 = "arm",
		armv7 = "arm",
		mipsel = "mipsle"
	}
}

_M.singbox = {
	name = "Sing-Box",
	repo = "SagerNet/sing-box",
	get_url = gh_release_url,
	cmd_version = "version | awk '{print $3}' | sed -n 1P",
	zipped = true,
	zipped_suffix = "tar.gz",
	default_path = "/usr/bin/sing-box",
	match_fmt_str = "linux%%-%s",
	file_tree = {
		x86_64 = "amd64",
		mips64el = "mips64le"
	}
}

_M.xray = {
	name = "Xray",
	repo = "XTLS/Xray-core",
	get_url = gh_pre_release_url,
	cmd_version = "version | awk '{print $2}' | sed -n 1P",
	zipped = true,
	default_path = "/usr/bin/xray",
	match_fmt_str = "linux%%-%s",
	file_tree = {
		x86_64 = "64",
		x86    = "32",
		mips   = "mips32",
		mipsel = "mips32le",
		mips64el = "mips64le"
	}
}

_M["chinadns-ng"] = {
	name = "ChinaDNS-NG",
	repo = "zfl9/chinadns-ng",
	get_url = gh_release_url,
	cmd_version = "-V | awk '{print $2}'",
	zipped = false,
	default_path = "/usr/bin/chinadns-ng",
	match_fmt_str = "%s",
	file_tree = {
		x86_64  = "wolfssl@x86_64.*x86_64@",
		x86     = "wolfssl@i386.*i686",
		mips    = "wolfssl@mips%-.*mips32%+soft_float@",
		mips64  = "wolfssl@mips64%-.*mips64%+soft_float@",
		mipsel  = "wolfssl@mipsel.*mips32%+soft_float@",
		mips64el = "wolfssl@mips64el%-.*mips64%+soft_float@",
		aarch64 = "wolfssl_noasm@aarch64.*v8a",
		rockchip = "wolfssl@aarch64.*v8a",
		armv5   = "wolfssl@arm.*v5te",
		armv6   = "wolfssl@arm.*v6t2",
		armv7   = "wolfssl@arm.*eabihf.*v7a",
		armv8   = "wolfssl_noasm@aarch64.*v8a",
		riscv64 = "wolfssl@riscv64.*"
	}
}

return _M
