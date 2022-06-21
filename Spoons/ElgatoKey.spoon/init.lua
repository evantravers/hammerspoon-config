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
  M.findServices()

  return self
end

function M.findServices()
  local browser = hs.bonjour.new()
  M.cache = {}

  browser:findServices('_elg._tcp', function(browserObject, domain, advertised, service, terminated)
    M.service = service
    service:resolve(function(serviceObj, result)
      if result == "resolved" then
        M.cache.ip   = service:addresses()[1]
        M.cache.port = service:port()
        browserObject:stop()

        return M.cache
      end
    end)
  end)
end

function M.ip()
  if M.cache.ip then
    return M.cache.ip
  else
    return M.findServices()["ip"]
  end
end

function M.port()
  if M.cache.port then
    return M.cache.port
  else
    return M.findServices()["port"]
  end
end

local function onOff(i)
  local status, body, headers = hs.http.get("http://" .. M.ip() .. ":" .. M.port() .. "/elgato/lights")
  local settings        = hs.json.decode(body)
  settings.lights[1].on = i
  local status, response, header = hs.http.doRequest("http://" .. M.ip() .. ":" .. M.port() .. "/elgato/lights", "PUT", hs.json.encode(settings))
end

function M:off()
  onOff(0)

  return self
end

function M:on()
  onOff(1)

  return self
end

function M.isConnected()
  return M.cache.ip
end

return M
