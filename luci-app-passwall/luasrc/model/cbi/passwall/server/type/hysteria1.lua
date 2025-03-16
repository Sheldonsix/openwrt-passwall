local m, s = ...

local api = require "luci.passwall.api"

if not api.finded_com("hysteria1") then
	return
end

local fs = api.fs

local type_name = "Hysteria1"

local option_prefix = "hysteria1_"

local function _n(name)
	return option_prefix .. name
end

-- [[ Hysteria1 ]]

s.fields["type"]:value(type_name, "Hysteria1")

o = s:option(Value, _n("port"), translate("Listen Port"))
o.datatype = "port"

o = s:option(ListValue, _n("protocol"), translate("Protocol"))
o:value("udp", "UDP")
o:value("faketcp", "faketcp")
o:value("wechat-video", "wechat-video")

o = s:option(Value, _n("obfs"), translate("Obfs Password"))
o.rewrite_option = o.option

o = s:option(ListValue, _n("auth_type"), translate("Auth Type"))
o:value("disable", translate("Disable"))
o:value("string", translate("STRING"))
o.rewrite_option = o.option

o = s:option(Value, _n("auth_password"), translate("Auth Password"))
o.password = true
o:depends({ [_n("auth_type")] = "string" })
o.rewrite_option = o.option

o = s:option(Value, _n("alpn"), translate("QUIC TLS ALPN"))

o.rewrite_option = o.option

o = s:option(Flag, _n("udp"), translate("UDP"))
o.default = "1"
o.rewrite_option = o.option

o = s:option(Value, _n("up_mbps"), translate("Max upload Mbps"))
o.rewrite_option = o.option

o = s:option(Value, _n("down_mbps"), translate("Max download Mbps"))
o.rewrite_option = o.option

o = s:option(Value, _n("recv_window_conn"), translate("QUIC stream receive window"))
o.rewrite_option = o.option

o = s:option(Value, _n("recv_window"), translate("QUIC connection receive window"))
o.rewrite_option = o.option

o = s:option(Flag, _n("disable_mtu_discovery"), translate("Disable MTU detection"))
o.rewrite_option = o.option

o = s:option(Flag, option_name("tls"), translate("TLS"))
o.default = 0
o.validate = function(self, value, t)
	if value then
		if value == "1" then
			local ca = s.fields[_n("tls_certificateFile")]:formvalue(t) or ""
			local key = s.fields[_n("tls_keyFile")]:formvalue(t) or ""
			if ca == "" or key == "" then
				return nil, translate("Public key and Private key path can not be empty!")
			end
		end
		return value
	end
end

o = s:option(FileUpload, _n("tls_certificateFile"), translate("Public key absolute path"), translate("as:") .. "/etc/ssl/fullchain.pem")
o.default = m:get(s.section, "tls_certificateFile") or "/etc/config/ssl/" .. arg[1] .. ".pem"
o:depends({ [_n("tls")] = true })
o.validate = function(self, value, t)
	if value and value ~= "" then
		if not fs.access(value) then
			return nil, translate("Can't find this file!")
		else
			return value
		end
	end
	return nil
end

o = s:option(FileUpload, _n("tls_keyFile"), translate("Private key absolute path"), translate("as:") .. "/etc/ssl/private.key")
o.default = m:get(s.section, "tls_keyFile") or "/etc/config/ssl/" .. arg[1] .. ".key"
o:depends({ [_n("tls")] = true })
o.validate = function(self, value, t)
	if value and value ~= "" then
		if not fs.access(value) then
			return nil, translate("Can't find this file!")
		else
			return value
		end
	end
	return nil
end

o = s:option(Flag, _n("log"), translate("Log"))
o.default = "1"
o.rmempty = false

api.luci_types(arg[1], m, s, type_name, option_prefix)
