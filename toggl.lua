module = {}

module.get_key = function()
  local file = io.open('.toggl_key')
  io.input(file)
  return io.read()
end

module.projects = {
  communications = "160553883",
  meetings = "160775332",
  planning = "160831759",
  reading  = "160934258",
  design   = "160553877",
  research = "160553882"
}

module.start_timer = function(project_id, description)
  command = [[curl -v -u ]] .. module.key .. [[:api_token \
  -H "Content-Type: application/json" \
  -d '{"time_entry":{"description":"]] .. description .. [[","pid":]] .. project_id .. [[,"created_with":"curl"}}' \
  -X POST https://www.toggl.com/api/v8/time_entries/start]]

   os.execute(command)
end

module.start = function()
  module.key = module.get_key()
end

return module
