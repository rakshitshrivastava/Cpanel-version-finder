local cpanel = require "cpanel"

function prerule()
  return true, {host=stdnse.get_script_args(SCRIPT_NAME .. ".host")}
end

action = function(host)
  local response = cpanel.get_cpanel_version(host)
  if response and response.status == 200 and response.body then
    local version = response.body:match("cPanel Version ([%d%.]+)")
    if version then
      return stdnse.format_output(true, "cPanel version: %s", version)
    end
  end
  return stdnse.format_output(false, "cPanel version not found")
end
