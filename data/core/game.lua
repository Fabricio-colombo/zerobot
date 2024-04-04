-- Table to represent Game actions and its associated functions
Game = {
    Events = {
        TALK = 1,
        MAGIC_EFFECT = 2,
        HUD_CLICK = 3,
        HOTKEY_SHORTCUT_PRESS = 4,
        TEXT_MESSAGE = 5,
        MODAL_WINDOW = 6
    },
    RegisteredEvents = {},
    CallbacksCount = 0
}

--- Turn the player in a specified direction.
-- This function is a wrapper around the external function gameTurn.
-- @param direction (number) - The direction to turn the player, refer the parameter as Enums.Directions
function Game.turn(direction)
    gameTurn(direction)
end

--- Send a message or perform a certain type of talk action.
-- This function is a wrapper around the external function gameTalk.
-- @param message (string) - The message to send or the talk action to perform.
-- @param type (number) - The type of talk action to perform, if applicable. Refer the parameter as Enums.TalkTypes
function Game.talk(message, type)
    gameTalk(message, type)
end

--- Send a message to a specific channelId.
-- This function is a wrapper around the external function gameTalkChannel.
-- To get history of openned channels use Game.getChannelsHistory
-- @param message (string) - The message to be sent.
-- @param channelId (number) - The id of channel.
function Game.talkChannel(message, channelId)
    gameTalkChannel(message, channelId)
end

--- Send a private message to a specific player by name.
-- This function is a wrapper around the external function gameTalkPrivate.
-- @param message (string) - The message to be sent.
-- @param receiver (string) - The player name.
function Game.talkPrivate(message, receiver)
    gameTalkPrivate(message, receiver)
end

--- Move the player in a specified direction.
-- This function is a wrapper around the external function gameWalk.
-- @param direction (string) - The direction to move the player. Refer the parameter as Enums.Directions
function Game.walk(direction)
    gameWalk(direction)
end

--- Attack a specified creature.
-- This function is a wrapper around the external function gameAttack.
-- @param creatureId (number) - The ID of the creature to attack.
function Game.attack(creatureId)
    gameAttack(creatureId)
end

--- Get item count of specified ID.
-- This function is a wrapper around the external function gameGetItemCount.
-- @param itemId (number) - The ID of item.
function Game.getItemCount(itemId)
	return gameGetItemCount(itemId)
end

--- Get all items stored on player inventory.
-- This function is a wrapper around the external function gameGetInventoryItems.
-- @return a table containing all available inventory items, every item follow this format: {id=0,count=0,tier=0}
function Game.getInventoryItems()
	return gameGetInventoryItems()
end

--- Use an item on the ground.
-- This function is a wrapper around the external function gameUseItemOnGround.
-- It allows the use of a specified item on the ground at a particular position.
-- @param itemId (number) - The ID of the item to be used.
-- @param x (number) - The x-coordinate of the position where the item is to be used.
-- @param y (number) - The y-coordinate of the position where the item is to be used.
-- @param z (number) - The z-coordinate of the position where the item is to be used.
-- @return true if used item correctly, false otherwise.
function Game.useItemOnGround(itemId, x, y, z)
    return gameUseItemOnGround(itemId, x, y, z)
end

--- Use an item from ground.
-- This function is a wrapper around the external function gameUseItemFromGround.
-- It allows the use of a item located in a specific position.
-- @param x (number) - The x-coordinate of the position where the item is located.
-- @param y (number) - The y-coordinate of the position where the item is located.
-- @param z (number) - The z-coordinate of the position where the item is located.
-- @return true if it was possible to use item, false otherwise.
function Game.useItemFromGround(x, y, z)
    return gameUseItemFromGround(x, y, z)
end

-- Get channels history of current session
-- This information will be available if you logged in with bot injected, so it can gather channels informations
-- @return table containing history of openned channels with id and name
function Game.getChannelsHistory()
    return gameGetChannelsHistory()
end

-- Answer current modal window
-- This function is a wrapper around the external function gameUseItemFromGround.
-- @return true if was sent successfully sent the action, if not failed
function Game.modalWindowAnswer(id, button, choice)
    return gameModalWindowAnswer(id, button, choice)
end

-- Use item with creature by id
-- This function is a wrapper around the external function gameUseItemWithCreature.
-- @return true if was sent successfully sent the action, if not failed
function Game.useItemWithCreature(id, creatureId)
    return gameUseItemWithCreature(id, creatureId)
end

-- Loot a corpse at specific map coordinate
-- This function is a wrapper around the external function gameLootCorpse.
-- @param x (number) - The x-coordinate of the map destination position.
-- @param y (number) - The y-coordinate of the map destination position.
-- @param z (number) - The z-coordinate of the map destination position.
-- @return true if was sent successfully sent the action, if not failed
function Game.lootCorpse(x, y, z)
    return gameLootCorpse(x, y, z)
end

--- Equip an item.
-- This function is a wrapper around the external function gameEquipItem.
-- Equip a specific item by id and tier.
-- @param itemId (number) - The ID of the item to be equiped.
-- @param tier (number) - The tier of item to be equiped.
function Game.equipItem(itemId, tier)
    gameEquipItem(itemId, tier)
end

--- Use an item.
-- This function is a wrapper around the external function gameUseItem.
-- It allows the use of a specified item.
-- @param itemId (number) - The ID of the item to be used.
function Game.useItem(itemId)
    gameUseItem(itemId)
end

----------------------- INTERNAL EVENTS (DON'T TOUCH) -----------------------
function Game.executeEvents(hookType, ...)
    for index, callback in pairs(Game.RegisteredEvents[hookType] or {}) do
        callback(...)
    end
end

-- Register a game event
-- Example: Game.registerEvent(Game.Events.TALK, myTalkEvent)
function Game.registerEvent(type, fn)
    if not Game.RegisteredEvents[type] then
        Game.RegisteredEvents[type] = {}
    end
    table.insert(Game.RegisteredEvents[type], fn)
    Game.CallbacksCount = Game.CallbacksCount + 1
    if Game.CallbacksCount == 1 then
        callbacksEnabled(true)
    end
    return fn
end

-- Unregister a game event
-- Example: Game.unregisterEvent(Game.Events.TALK, myTalkEvent)
function Game.unregisterEvent(type, fn)
    local t = Game.RegisteredEvents[type] or {}
    for i, v in pairs(t) do
        if v == fn then
            table.remove(t, i)
            Game.CallbacksCount = Game.CallbacksCount - 1
        end
    end

    if Game.CallbacksCount == 0 then
        callbacksEnabled(false)
    end
end

----------------------- INTERNAL FUNCTIONS (DON'T TOUCH) -----------------------
-- triggered when receive a message in-game
-- @param authorName - The author that said the message
-- @param authorLevel - The level of the author (generally used to identify player level on chat)
-- @param type - The type of the message, you can base it on Enums.TalkTypes
-- @param x - The x-coordinate of the map position
-- @param y - The y-coordinate of the map position
-- @param z - The z-coordinate of the map position
-- @Param text - the content of the message
function onInternalTalk(authorName, authorLevel, type, x, y, z, text)
    Game.executeEvents(Game.Events.TALK, authorName, authorLevel, type, x, y, z, text)
end

-- triggered when receive a magic effect in-game
-- if you are using this event in a situation with many effects, dependending of your code can affect the performance, in that case you can use sometype of delay/queue for processing
-- @param type - The ID of magic effect
-- @param x - The x-coordinate of the map position.
-- @param y - The y-coordinate of the map position.
-- @param z - The z-coordinate of the map position.
function onInternalMagicEffect(type, x, y, z)
    Game.executeEvents(Game.Events.MAGIC_EFFECT, type, x, y, z)
end

-- triggered when press any possible shortcut
-- key = code of the key pressed, modifier = is the modifier pressed (example: CTRL)
-- you can base on HotkeyManager.parseKeyCombination function on how to work with key/modifier
function onInternalHotkeyShortcutPress(key, modifier)
    Game.executeEvents(Game.Events.HOTKEY_SHORTCUT_PRESS, key, modifier)
end

-- triggered when receive a text message in-game
-- messageData param is a table containing structure following the sample:
-- {
--     "channelId": 0,
--     "messagePrimaryValue": 13048,
--     "messagePrimaryColor": 180,
--     "messageSecondaryValue": 0,
--     "x": 32424,
--     "y": 32147,
--     "z": 7,
--     "text": "A monk loses 4 hitpoints due to your attack.",
--     "messageSecondaryColor": 255,
--     "messageType": 23
-- }
--
-- messageType field you can base it on Enums.MessageTypes
-- these message types can change dependending of the client version
function onInternalTextMessage(messageData)
    Game.executeEvents(Game.Events.TEXT_MESSAGE, messageData)
end

-- triggered when receive a modal window in-game
-- modalWindowData param is a table containing structure following the sample:
-- {
--     "defaultEscapeButton": 255,
--     "defaultEnterButton": 255,
--     "priority": 0,
--     "title": "Select an option",
--     "buttons": [
--         {
--             "text": "First",
--             "id": 1
--         },
--         {
--             "text": "Second",
--             "id": 2
--         },
--         {
--             "text": "Third",
--             "id": 3
--         },
--         {
--             "text": "Fourth",
--             "id": 4
--         }
--     ],
--     "id": 1,
--     "message": "Hello",
--     "choices": []
-- }
function onInternalModalWindow(modalWindowData)
    Game.executeEvents(Game.Events.MODAL_WINDOW, modalWindowData)
end

-- triggered when receive a click event on any HUD
-- @param id - The ID of HUD that was clicked
function onInternalHudClick(id)
    Game.executeEvents(Game.Events.HUD_CLICK, id)
end