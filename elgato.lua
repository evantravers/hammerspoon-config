local M = {}
local browser = hs.bonjour.new()

browser:findServices('_elg._tcp', function(browserObject, domain, advertised, service, terminated)
  M.service = service
  service:resolve(function(serviceObj, result)
    if result == "resolved" then
      M.ip = service:addresses()[1] -- 192.168.1.113
      M.port = service:port() --9123
      browserObject:stop()
    end
  end)
end)

M.stop = function()
  local status, body, headers = hs.http.get("http://" .. M.ip .. ":" .. M.port .. "/elgato/lights")
  settings = hs.json.decode(body)
  settings.lights[1].on = 0
  local status, response, header = hs.http.doRequest("http://" .. M.ip .. ":" .. M.port .. "/elgato/lights", "PUT", hs.json.encode(settings))
end

return M
