local m, s = ...

local api = require "luci.passwall.api"

if not api.finded_com("hysteria1") then
	return
end

local type_name = "Hysteria1"

local option_prefix = "hysteria1_"

local function _n(name)
	return option_prefix .. name
end

-- [[ Hysteria1 ]]

s.fields["type"]:value(type_name, "Hysteria1")

o = s:option(ListValue, _n("protocol"), translate("Protocol"))
o:value("udp", "UDP")
o:value("faketcp", "faketcp")
o:value("wechat-video", "wechat-video")

o = s:option(Value, _n("address"), translate("Address (Support Domain Name)"))

o = s:option(Value, _n("port"), translate("Port"))
o.datatype = "port"

o = s:option(Value, _n("hop"), translate("Additional ports for hysteria hop"))
o.rewrite_option = o.option

o = s:option(Value, _n("obfs"), translate("Obfs Password"))
o.rewrite_option = o.option

o = s:option(ListValue, _n("auth_type"), translate("Auth Type"))
o:value("disable", translate("Disable"))
o:value("string", translate("STRING"))
o:value("base64", translate("BASE64"))
o.rewrite_option = o.option

o = s:option(Value, _n("auth_password"), translate("Auth Password"))
o.password = true
o:depends({ [_n("auth_type")] = "string"})
o:depends({ [_n("auth_type")] = "base64"})
o.rewrite_option = o.option

o = s:option(Value, _n("alpn"), translate("QUIC TLS ALPN"))
o.rewrite_option = o.option

o = s:option(Flag, _n("fast_open"), translate("Fast Open"))
o.default = "0"

o = s:option(Value, _n("tls_serverName"), translate("Domain"))

o = s:option(Flag, _n("tls_allowInsecure"), translate("allowInsecure"), translate("Whether unsafe connections are allowed. When checked, Certificate validation will be skipped."))
o.default = "0"

o = s:option(Value, _n("up_mbps"), translate("Max upload Mbps"))
o.rewrite_option = o.option

o = s:option(Value, _n("down_mbps"), translate("Max download Mbps"))
o.rewrite_option = o.option

o = s:option(Value, _n("recv_window"), translate("QUIC stream receive window"))
o.rewrite_option = o.option

o = s:option(Value, _n("recv_window_conn"), translate("QUIC connection receive window"))
o.rewrite_option = o.option

o = s:option(Value, _n("handshake_timeout"), translate("Handshake Timeout"))
o.rewrite_option = o.option

o = s:option(Value, _n("idle_timeout"), translate("Idle Timeout"), translate("Example:") .. "30s (4s-120s)")
o.rewrite_option = o.option

o = s:option(Value, _n("hop_interval"), translate("Hop Interval"))
o.rewrite_option = o.option

o = s:option(Flag, _n("disable_mtu_discovery"), translate("Disable MTU detection"))
o.default = "0"
o.rewrite_option = o.option

o = s:option(Flag, _n("lazy_start"), translate("Lazy Start"))
o.default = "0"
o.rewrite_option = o.option

api.luci_types(arg[1], m, s, type_name, option_prefix)
