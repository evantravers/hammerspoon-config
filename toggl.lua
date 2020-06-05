local json = require('hs.json')
local http = require('hs.http')

module = {}

module.start_timer = function(project_id, description)
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    hs.http.asyncPost(
      "https://www.toggl.com/api/v8/time_entries/start",
      json.encode(
        {
          ['time_entry'] = {
            ['description'] = description,
            ['pid'] = project_id,
            ['created_with'] = 'hammerspoon'
          }
        }
      ),
      {["Content-Type"] = "application/json; charset=UTF-8"},
      function(http_number, body, headers)
        print(http_number)
      end
    )
  else
    print("You need to put a `toggl_key` value in your .secrets file.")
  end
end

module.current_timer = function()
  local command = [[curl -v -u ]] .. hs.settings.get("toggl_key") .. [[:api_token \
  -H "Content-Type: application/json" \
  -X GET https://www.toggl.com/api/v8/time_entries/current]]
  local handle = io.popen(command)
  local result = handle:read("*a")
  local value = JSON:decode(result)
  if value['data'] then
    return value['data']
  else
    print('There was a problem with the timer.')
    return nil
  end
end

module.stop_timer = function()
  local current = module.current_timer()
  if current then
    local id = module.current_timer['id']
    local command = [[curl -v -u ]] .. hs.settings.get("toggl_key") .. [[:api_token \
    -H "Content-Type: application/json" \
    -X GET https://www.toggl.com/api/v8/time_entries/current]]
    os.execute(command)
  end
end

return module
