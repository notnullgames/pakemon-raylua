local SceneMenuList = {}

local pageSize = 8

function SceneMenuList:init()
  SceneMenuList.roms = {}
  SceneMenuList.romsDisplay = {}
  SceneMenuList.currentRom = 1
  for rom in io.popen("ls games/" .. SceneMenuTop.systems[SceneMenuTop.currentSystem] .. "/roms"):lines() do
    table.insert(SceneMenuList.roms, rom)
    local path, file, extension = rom:match("^(.-)([^\\/]-)%.([^\\/%.]-)%.?$")
    if path then
      table.insert(SceneMenuList.romsDisplay, file)
    else
      table.insert(SceneMenuList.romsDisplay, rom)
    end
  end
end

function SceneMenuList:update()
  if buttonOnce("b") then
    setScene(SceneMenuTop)
  end

  if buttonOnce("a") then
    -- load game
  end

  if buttonOnce("up") then
    SceneMenuList.currentRom = SceneMenuList.currentRom  + 1
  end
  if buttonOnce("down") then
    SceneMenuList.currentRom = SceneMenuList.currentRom  - 1
  end

  if SceneMenuList.currentRom < 1 then
    SceneMenuList.currentRom = table.getn(SceneMenuList.roms)
  end
  if SceneMenuList.currentRom > table.getn(SceneMenuList.roms) then
    SceneMenuList.currentRom = 1
  end
end

function SceneMenuList:draw()
  rl.ClearBackground(rl.BLACK)
  for r, rom in pairs(SceneMenuList.romsDisplay) do
    rl.DrawText(rom, 20, 20 + ((r-1) *24), 20, rl.WHITE)
  end
end

function SceneMenuList:destroy()
end

return SceneMenuList