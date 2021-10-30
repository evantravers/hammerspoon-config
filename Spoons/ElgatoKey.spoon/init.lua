--- === Elgato Key Light ===
--- I wanted to control my Key light depending on whether I'm in a meeting or
--- not.
local m = {
  name = "Elgato Key Light Controls",
  version = "0.5",
  author = "Evan Travers <evantravers@gmail.com>",
  license = "MIT <https://opensource.org/licenses/MIT>"
}

function m:start()
  local browser = hs.bonjour.new()

  browser:findServices('_elg._tcp', function(browserObject, domain, advertised, service, terminated)
    m.service = service
    service:resolve(function(serviceObj, result)
      if result == "resolved" then
        m.ip = service:addresses()[1] -- 192.168.1.113
        m.port = service:port() --9123
        browserObject:stop()
      end
    end)
  end)

  return self
end

local function onOff(i)
  local status, body, headers = hs.http.get("http://" .. m.ip .. ":" .. m.port .. "/elgato/lights")
  settings = hs.json.decode(body)
  settings.lights[1].on = i
  local status, response, header = hs.http.doRequest("http://" .. m.ip .. ":" .. m.port .. "/elgato/lights", "PUT", hs.json.encode(settings))
end

function m:off()
  onOff(0)

  return self
end

function m:on()
  onOff(1)

  return self
end

return m
