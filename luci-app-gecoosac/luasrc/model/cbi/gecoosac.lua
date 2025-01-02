
function program_exists(program)
	local handle = io.popen('which ' .. program)
	local result = handle:read('*a')
	handle:close()
	return result ~= ''
end

if program_exists("/usr/bin/gecoosac") then
	m = Map("gecoosac", translate("Gecoos AC"), translate("Batch management Gecoos AP,Default password:admin") .. "<br>" .. translatef("The current AC version %s, only supports AP 7.6 and above.","2.x"))
else
	m = Map("gecoosac", translate("Gecoos AC"), translate("Batch management Gecoos AP,Default password:admin") .. "<br>" .. translate("The AC program does not exist, please check."))
end

m:section(SimpleSection).template  = "gecoosac/gecoosac_status"

s = m:section(TypedSection, "gecoosac", translate("Global Settings"))
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enabled", translate("Enabled AC"))
enable.rmempty = false

o = s:option(Value, "port", translate("Set interface port"))
o.placeholder = 60650
o.default     = 60650
o.datatype    = "port"
o.rmempty     = false

o = s:option(Flag, "isonlyoneprot", translate("Single Port Mode"), translate("Do not enable the independent management port, only use one port for management."))
o.default = 1

o = s:option(Value, "m_port", translate("Set management port"))
o.placeholder = 8080
o.default     = 8080
o.datatype    = "port"
o.rmempty     = false
o:depends("isonlyoneprot", false)

o = s:option(Flag, "https", translate("Enable HTTPS service"), translate("A certificate file must be specified, otherwise it will fail to start."))
o.default = 0
o:depends("isonlyoneprot", false)

o = s:option(Value, "crt_file", translate("Specify crt certificate file"))
o.placeholder = "/etc/gecoosac/1.crt"
o.default     = "/etc/gecoosac/1.crt"
o.rmempty     = false
o:depends("https", true)

o = s:option(Value, "key_file", translate("Specify key certificate file"))
o.placeholder = "/etc/gecoosac/1.key"
o.default     = "/etc/gecoosac/1.key"
o.rmempty     = false
o:depends("https", true)

o = s:option(Value, "upload_dir", translate("Upload dir path"), translate("The path to upload AP upgrade firmware"))
o.placeholder = "/tmp/gecoosac/upload/"
o.default     = "/tmp/gecoosac/upload/"
o.rmempty     = false

o = s:option(Value, "db_dir", translate("Database dir path"), translate("The path to store the config database"))
o.placeholder = "/etc/gecoosac/"
o.default     = "/etc/gecoosac/"
o.rmempty     = false

o = s:option(Flag, "log", translate("Enable Log"))
o.default = 1
o.rmempty = false

return m
