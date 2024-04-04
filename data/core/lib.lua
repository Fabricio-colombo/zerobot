-- lua functions
print = function(...)
    local args = {...}
    local message = table.concat(args, "\t")
    debugPrint(message)
end

local originalRequire = require
require = function(module)
    if module == "ffi" then
        error("the loading of the 'ffi' module is prohibited in production scripts due to security restrictions. Its usage is permitted only for personal projects with acknowledged consent")
    end
    return originalRequire(module)
end

os.execute = function(...) print("os.execute function disabled!") end
io.popen = function(...) print("io.popen function disabled!") end
os.remove = function(...) print("os.remove function disabled!") end

function wait(ms)
    local target = ms / 1000 + os.clock()
    while os.clock() < target do
        -- busy-wait loop
    end
end

math.randomseed(os.time())

dofile("core/enums.lua")
dofile("core/json.lua")
dofile("core/hotkeymanager.lua")
dofile("core/sound.lua")
dofile("core/timer.lua")
dofile("core/game.lua")
dofile("core/hud.lua")
dofile("core/engine.lua")
dofile("core/container.lua")
dofile("core/inventory.lua")
dofile("core/player.lua")
dofile("core/spells.lua")
dofile("core/creature.lua")
dofile("core/map.lua")
dofile("core/npc.lua")
dofile("core/client.lua")
