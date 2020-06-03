module = {}

module.start_timer = function(project_id, description)
  if hs.fnutils.contains(hs.settings.getKeys(), "toggl_key") then
    command = [[curl -v -u ]] .. hs.settings.get("toggl_key") .. [[:api_token \
    -H "Content-Type: application/json" \
    -d '{"time_entry":{"description":"]] .. description .. [[","pid":]] .. project_id .. [[,"created_with":"curl"}}' \
    -X POST https://www.toggl.com/api/v8/time_entries/start]]
    os.execute(command)
  else
    print("You need to put a `toggl_key` value in your .secrets file.")
  end
end

return module
