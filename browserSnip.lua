-- https://stackoverflow.com/questions/19326368/iterate-over-lines-including-blank-lines
local function magiclines(s)
  if s:sub(-1)~="\n" then s=s.."\n" end
  return s:gmatch("(.-)\n")
end

-- Snip current highlight
Hyper:bind({}, 's', nil, function()
  local win = hs.window.focusedWindow()

  -- get the window title
  local title = win:title()
                   :gsub("- Brave", "")
                   :gsub("- Google Chrome", "")
  -- get the highlighted item
  hs.eventtap.keyStroke('command', 'c')
  local highlight = hs.pasteboard.readString()
  local quote = ""
  for line in magiclines(highlight) do
    quote = quote .. "> " .. line .. "\n"
  end
  -- get the URL
  hs.eventtap.keyStroke('command', 'l')
  hs.eventtap.keyStroke('command', 'c')
  local url = hs.pasteboard.readString():gsub("?utm_source=.*", "")
  --
  local template = string.format([[%s

%s
[%s](%s)]], title, quote, title, url)
  -- format and send to drafts
  hs.urlevent.openURL("drafts://x-callback-url/create?tag=links&text=" .. hs.http.encodeForQuery(template))
  hs.notify.show("Snipped!", "The snippet has been sent to Drafts", "")
end)
