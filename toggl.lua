-- TOGGL
--
-- Relies on a toggl api key in hs.settings.get('toggl_key')

local module = {}

module.start_timer = function(project_id, description)
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    local key = hs.settings.get('toggl_key')
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
        print(http_number)
      end
    )
  else
    print("You need to put a `toggl_key` in hs.settings.")
  end
end

module.current_timer = function()
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    local key = hs.settings.get('toggl_key')
    http_number, body, headers = hs.http.get(
      "https://www.toggl.com/api/v8/time_entries/current",
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
    end
  else
    print("You need to put a `toggl_key` in hs.settings.")
  end
end

module.get_project = function(pid)
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    local key = hs.settings.get('toggl_key')
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
    end
  else
    print("You need to put a `toggl_key` in hs.settings.")
  end
end

module.stop_timer = function()
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    local current = module.current_timer()
    local key = hs.settings.get('toggl_key')
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
    end
  else
    print("You need to put a `toggl_key` in hs.settings.")
  end
end

return module
