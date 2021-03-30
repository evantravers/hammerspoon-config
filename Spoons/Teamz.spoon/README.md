# Teamz

Microsoft Teams is difficult to work with... they don't name their windows
consistently. This is a wrapper that keeps track of a Microsoft Teams
application, and isolating the hs.window that contains the call.

```lua
Teamz = spoon.Teamz:start()

-- to focus the working call...
if Teamz:isRunning() then
  Teamz:callWindow():focus()
end
```
