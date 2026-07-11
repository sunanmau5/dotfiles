require("hs.ipc")

local confDir = hs.configdir .. "/conf.d"
if hs.fs.attributes(confDir) then
  for file in hs.fs.dir(confDir) do
    if file:match("%.lua$") then dofile(confDir .. "/" .. file) end
  end
end

hs.alert.show("hammerspoon loaded")
