local SceneMenuTop = {}

function SceneMenuTop:init()
  SceneMenuTop.text = "Congrats! You created your first window!"
  SceneMenuTop.font = GetFontDefault()
  SceneMenuTop.systems = {}
  SceneMenuTop.systemsImages = {}
  SceneMenuTop.currentSystem = 1
  for dir in io.popen('ls games'):lines() do
    table.insert(SceneMenuTop.systems, dir)
    table.insert(SceneMenuTop.systemsImages, rl.LoadTexture("games/" .. dir .. "/icon.png"))
  end
end

function SceneMenuTop:update()
  if buttonOnce("a") then
    setScene(SceneMenuList)
  end

  if buttonOnce("right") then
    SceneMenuTop.currentSystem = SceneMenuTop.currentSystem + 1
  end
  if buttonOnce("left") then
    SceneMenuTop.currentSystem = SceneMenuTop.currentSystem - 1
  end

  if SceneMenuTop.currentSystem < 1 then
    SceneMenuTop.currentSystem = table.getn(SceneMenuTop.systems)
  end
  if SceneMenuTop.currentSystem > table.getn(SceneMenuTop.systems) then
    SceneMenuTop.currentSystem = 1
  end
end

function SceneMenuTop:draw()
  rl.ClearBackground(rl.BLACK)
  rl.DrawTexture(SceneMenuTop.systemsImages[SceneMenuTop.currentSystem], (screenWidth/2) - (SceneMenuTop.systemsImages[SceneMenuTop.currentSystem].width / 2), (screenHeight/2) - (SceneMenuTop.systemsImages[SceneMenuTop.currentSystem].height / 2), WHITE)
  local textSize = MeasureTextEx(SceneMenuTop.font, SceneMenuTop.systems[SceneMenuTop.currentSystem], 20, 1)
  rl.DrawText(SceneMenuTop.systems[SceneMenuTop.currentSystem], (screenWidth/2) - (textSize.x/2), 20, 20, rl.WHITE)
end

function SceneMenuTop:destroy()
  for i, image in pairs(SceneMenuTop.systemsImages) do
    rl.UnloadTexture(image)
  end
end

return SceneMenuTop