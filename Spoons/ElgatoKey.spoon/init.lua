--- === Elgato Key Light ===
--- I wanted to control my Key light depending on whether I'm in a meeting or
--- not.
local M = {
  name = "Elgato Key Light Controls",
  version = "0.5",
  author = "Evan Travers <evantravers@gmail.com>",
  license = "MIT <https://opensource.org/licenses/MIT>"
}

function M:start()
  local browser = hs.bonjour.new()

  browser:findServices('_elg._tcp', function(browserObject, domain, advertised, service, terminated)
    M.service = service
    service:resolve(function(serviceObj, result)
      if result == "resolved" then
        M.ip = hs.fnutils.find(service:addresses(), function(addr)
          return addr:match("%d%d%d.%d%d%d.%d.%d+")
        end)
        M.port = service:port()
        browserObject:stop()
      end
    end)
  end)

  return self
end

local function onOff(i)
  local status, body, headers = hs.http.get("http://" .. M.ip .. ":" .. M.port .. "/elgato/lights")
  local settings = hs.json.decode(body)
  settings.lights[1].on = i
  local status, response, header = hs.http.doRequest("http://" .. M.ip .. ":" .. M.port .. "/elgato/lights", "PUT", hs.json.encode(settings))
end

function M:off()
  onOff(0)

  return self
end

function M:on()
  onOff(1)

  return self
end

return M
