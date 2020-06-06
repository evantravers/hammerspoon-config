module = {}

module.start = function()
  hs.settings.set("secrets", hs.json.read(".secrets.json"))
end

return module
