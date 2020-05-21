module = {}

module.get_key = function()
  local file = io.open('.toggl_key')
  io.input(file)
  return io.read()
end

module.start = function()
  module.key = module.get_key()
end

return module
