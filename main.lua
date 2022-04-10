rl = require("lib/raylib")
SceneMenuTop = require("scenes/menutop/init")
SceneMenuList = require("scenes/menulist/init")

screenWidth = 320
screenHeight = 240

rl.SetTraceLogLevel(rl.LOG_WARNING)
rl.InitWindow(screenWidth, screenHeight, "Pakémon")
rl.SetTargetFPS(60)

local currentScene = nil

function setScene(scene)
  if currentScene and currentScene.destroy then
    currentScene:destroy()
  end
  if scene and scene.init then
    scene:init()
  end
  currentScene = scene
end

local buttons = {}
buttons.right = { val = false, key = rl.KEY_RIGHT }
buttons.left = { val = false, key = rl.KEY_LEFT }
buttons.up = { val = false, key = rl.KEY_UP }
buttons.down = { val = false, key = rl.KEY_DOWN }
buttons.a = { val = false, key = rl.KEY_X }
buttons.b = { val = false, key = rl.KEY_Z }
buttons.x = { val = false, key = rl.KEY_A }
buttons.y = { val = false, key = rl.KEY_S }
buttons.l = { val = false, key = rl.KEY_W }
buttons.r = { val = false, key = rl.KEY_Q }
buttons.start = { val = false, key = rl.KEY_ENTER }
buttons.select = { val = false, key = rl.KEY_TAB }

function buttonOnce(button)
  for i, b in pairs(buttons) do
    if rl.IsKeyUp(b.key) then
      b.val = false
    end
    if button == i and rl.IsKeyDown(b.key) and not b.val then
      b.val = true
      return true
    end
  end
  return false
end

setScene(SceneMenuTop)

while not rl.WindowShouldClose() do
  if currentScene and currentScene.update then
    currentScene:update()
  end
  rl.BeginDrawing()
  if currentScene and currentScene.draw then
    currentScene:draw()
  end
  rl.EndDrawing()
end

if currentScene and currentScene.destroy then
  currentScene:destroy()
end
rl.CloseWindow()


