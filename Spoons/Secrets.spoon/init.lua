-- === SECRETS ===
--
-- Really stupid simple loading of secrets into `hs.settings`.

local module = {}

--- Secrets:start(filename)
--- Method
--- Loads a .json file into hs.settings for easy retrieval.
---
--- Parameters:
---  * filename - A string containing the name of a json file (.secrets.json)
---
--- Returns:
---  * self
function module:start(filename)
  if hs.fs.attributes(filename) then
    hs.settings.set("secrets", hs.json.read(filename))
  else
    print("You need to create a file at " .. filename)
  end

  return self
end

--- Secrets:get(key)
--- Method
--- Returns a value from hs.settings.
---
--- Parameters:
---  * key - A table or string containing the address of something loaded into secrets.
---    * string - dot separated "json style" selector
---    * table - the orderd set of keys for the nested selector
---
--- Returns:
---  * Any
module.get = function(user_key)
  if type(user_key) == "string" then
    user_key = hs.fnutils.split(user_key, ".", true)
  end

  return hs.fnutils.reduce(user_key, function(tbl, key)
    return tbl[key]
  end, hs.settings.get("secrets"))
end

return module
