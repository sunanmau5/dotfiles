local m1ddc = "/opt/homebrew/bin/m1ddc"
local modifiers = { "ctrl", "alt", "cmd" }

local function switchInput(input)
  hs.task.new(m1ddc, nil, {
    "display",
    "1",
    "set",
    "input",
    input,
  }):start()
end

hs.hotkey.bind(modifiers, "1", function()
  switchInput("15")
end)

hs.hotkey.bind(modifiers, "2", function()
  switchInput("17")
end)

hs.hotkey.bind(modifiers, "3", function()
  switchInput("18")
end)
