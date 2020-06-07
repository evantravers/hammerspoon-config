-- SECRETS
--
-- Really stupid simple loading of secrets into `hs.settings`.

module = {}

module.start = function(filename)
  hs.settings.set("secrets", hs.json.read(filename))
end

return module
