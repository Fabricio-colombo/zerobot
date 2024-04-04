-- Table to represent a HUD and its associated functions
HUDList = {}
HUDCount = 0
HUD = {}
HUD.__index = HUD

-- Set up the constructor call
setmetatable(HUD, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

-- Don't touch it
function onHudClick(id)
    local hudItem = HUDList[id]
    if not hudItem then return end

    hudItem:onClick()
end

-- Don't touch it
function HUD:onClick()
    if not self.callback then return end

    self.callback()
end

--- Constructor for the HUD class
-- @param x coordinate of the game window on the x-axis
-- @param y coordinate of the game window on the y-axis
-- @param value the text or itemid to draw on the screen
-- @return A new HUD object
-- @important Please, don't use HUDItem functions in HUDText element and vice-versa
function HUD.new(x, y, value)
    local self = setmetatable({}, HUD)
	if (type(value) == 'number') then
		self.id = hudItemCreate()
        self.isItem = true
        self:setItemId(value)
	else
		self.id = hudTextCreate()
        self.isItem = false
        self:setText(value)
	end

    self:setPos(x, y)
    HUDList[self.id] = self
    HUDCount = HUDCount + 1
    if HUDCount == 1 then
        Game.registerEvent(Game.Events.HUD_CLICK, onHudClick)
    end
    return self
end

setmetatable(HUD, {__call = function(_, ...) return HUD.new(...) end})

--- Get the hud's ID.
-- @return The hud's ID
function HUD:getId()
    return self.id
end

-- Get current hud position
function HUD:getPos()
    return hudGetPos(self.id)
end

-- Set current hud position
function HUD:setPos(x, y)
    hudSetPos(self.id, x, y)
end

-- Set draggable state of specific hud
function HUD:setDraggable(draggable)
    hudSetDraggable(self.id, draggable)
end

-- Set hud text, only works if hud is a text
function HUD:setText(text)
    if self.isItem then return end
    hudTextSetText(self.id, text)
end

-- Set hud text color
function HUD:setColor(r, g, b)
    if self.isItem then return end
    hudTextSetColor(self.id, r, g, b)
end

-- Set hud item id
function HUD:setItemId(id)
    if not self.isItem then return end
    hudItemSetItemId(self.id, id)
end

-- Set hud item size
function HUD:setSize(width, height)
    hudSetSize(self.id, width, height)
end

-- Set hud on click callback
function HUD:setCallback(callback)
    self.callback = callback
end

-- Destroy the hud
function HUD:destroy()
    hudDestroy(self.id)
    HUDCount = HUDCount - 1
    HUDList[self.id] = nil
    if HUDCount == 0 then
        Game.unregisterEvent(Game.Events.HUD_CLICK, onHudClick)
    end
    self = nil
end