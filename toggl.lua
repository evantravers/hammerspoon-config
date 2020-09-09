-- TOGGL
--
-- Relies on a toggl api key in `hs.settings.get('secrets').toggl.key`.

local module = {}

module.key = function()
  if hs.settings.get("secrets").toggl.key then
    return hs.settings.get("secrets").toggl.key
  else
    print("You need to load a Toggl.com API key in to hs.settings under secrets.toggl.key")
  end
end

module.start_timer = function(project_id, description)
  local key = module.key()
  hs.http.asyncPost(
    "https://www.toggl.com/api/v8/time_entries/start",
    hs.json.encode(
      {
        ['time_entry'] = {
          ['description'] = description,
          ['pid'] = project_id,
          ['created_with'] = 'hammerspoon'
        }
      }
    ),
    {
      ["Content-Type"] = "application/json; charset=UTF-8",
      ["Authorization"] = "Basic " .. hs.base64.encode(key .. ":api_token")
    },
    function(http_number, body, headers)
      print("Timer started...")
      print(hs.inspect(body))
    end
  )
end

module.current_timer = function()
  local key = module.key()
  http_number, body, headers = hs.http.get(
    "https://www.toggl.com/api/v8/time_entries/current",
    {
      ["Content-Type"] = "application/json; charset=UTF-8",
      ["Authorization"] = "Basic " .. hs.base64.encode(key .. ":api_token")
    }
  )
  if http_number == 200 then
    if body == '{"data":null}' then
      return nil
    else
      return hs.json.decode(body)
    end
  else
    print("problems!")
    print(http_number)
    print(body)
  end
end

module.get_project = function(pid)
  local key = module.key()
  http_number, body, headers = hs.http.get(
    "https://www.toggl.com/api/v8/projects/" .. pid,
    {
      ["Content-Type"] = "application/json; charset=UTF-8",
      ["Authorization"] = "Basic " .. hs.base64.encode(key .. ":api_token")
    }
  )
  if http_number == 200 then
    return hs.json.decode(body)
  else
    print("problems!")
    print(http_number)
    print(body)
  end
end

module.stop_timer = function()
  local current = module.current_timer()
  if current then
    local key = module.key()
    http_number, body, headers = hs.http.doRequest(
      "https://www.toggl.com/api/v8/time_entries/" .. current['data']['id'] .. "/stop",
      "PUT",
      nil,
      {
        ["Content-Type"] = "application/json; charset=UTF-8",
        ["Authorization"] = "Basic " .. hs.base64.encode(key .. ":api_token")
      }
    )
    if http_number == 200 then
      return hs.json.decode(body)
    else
      print("problems!")
      print(http_number)
      print(body)
    end
  else
    print("No timer running!")
  end
end

return module
