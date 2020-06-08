-- SECRETS
--
-- Really stupid simple loading of secrets into `hs.settings`.

module = {}

module.start = function(filename)
  if hs.fs.attributes(filename) then
    hs.settings.set("secrets", hs.json.read(filename))
  else
    print("You need to create a file at " .. filename)
  end
end

return module
