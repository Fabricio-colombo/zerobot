-- Table to hold map-related functions
Map = {}

--- Get the IDs of creatures on the map.
-- This function is a wrapper around the external function mapGetCreatureIds.
-- @param sameFloor (boolean) - Whether to only consider creatures on the same floor.
-- @param onlyPlayer (boolean) - Whether to only consider player creatures.
-- @return A table of creature IDs, or nil if there's no creatures on screen.
function Map.getCreatureIds(sameFloor, onlyPlayer)
    return mapGetCreatureIds(sameFloor, onlyPlayer)
end

--- Get all map tiles on screen
-- This function is a wrapper around the external function mapGetTiles.
-- @return A table of all tiles containing things and their position.
function Map.getTiles()
    return mapGetTiles()
end

--- Get the things at a specific map position.
-- This function is a wrapper around the external function mapGetThings.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @return A table of things at the specified position, or nil if tile doesn't exists or there's no map information available.
function Map.getThings(x, y, z)
    return mapGetThings(x, y, z)
end

--- Get the things count at a specific map position.
-- This function is a wrapper around the external function mapGetThings.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @return Things count of specific position, or nil if tile doesn't exists or there's no map information available.
function Map.getThingsCount(x, y, z)
    return mapGetThingsCount(x, y, z)
end

--- Move item from map position to inventory slot.
-- This function is a wrapper around the external function mapMoveItemToInventory.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @param count (number) - The item count to move.
-- @param slot (number) - The inventory slot destination to move.
-- @return True if succeeded, or nil if tile/item/inventory slot doesn't exists or there's no map information available.
function Map.moveItemToInventory(x, y, z, count, slot)
    return mapMoveItemToInventory(x, y, z, count, slot)
end

--- Move item from map position to container slot.
-- This function is a wrapper around the external function mapMoveItemToContainer.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @param count (number) - The item count to move.
-- @param index (number) - The container index to move.
-- @param slot (number) - The container slot destination to move.
-- @return True if succeeded, or nil if tile/item/container slot doesn't exists or there's no map information available.
function Map.moveItemToContainer(x, y, z, count, index, slot)
    return mapMoveItemToContainer(x, y, z, count, index, slot)
end

--- Move item from map position to destination map position.
-- This function is a wrapper around the external function mapMoveItemToGround.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @param count (number) - The item count to move.
-- @param toX (number) - The x-coordinate of the map position destination.
-- @param toY (number) - The y-coordinate of the map position destination.
-- @param toZ (number) - The z-coordinate of the map position destination.
-- @return True if succeeded, or nil if tile/item/container slot doesn't exists or there's no map information available.
function Map.moveItemToGround(x, y, z, count, toX, toY, toZ)
    return mapMoveItemToGround(x, y, z, count, toX, toY, toZ)
end

--- Move creature from map position to destination map position.
-- This function is a wrapper around the external function mapMoveCreatureToGround.
-- @param x (number) - The x-coordinate of the map position.
-- @param y (number) - The y-coordinate of the map position.
-- @param z (number) - The z-coordinate of the map position.
-- @param toX (number) - The x-coordinate of the map position destination.
-- @param toY (number) - The y-coordinate of the map position destination.
-- @param toZ (number) - The z-coordinate of the map position destination.
-- @return True if succeeded, or nil if tile/creature doesn't exists or there's no map information available.
function Map.moveCreatureToGround(x, y, z, toX, toY, toZ)
    return mapMoveCreatureToGround(x, y, z, toX, toY, toZ)
end

-- Walk to a specific position using Tibia map click algorithm
-- @param x (number) - The x-coordinate of the map destination position.
-- @param y (number) - The y-coordinate of the map destination position.
-- @param z (number) - The z-coordinate of the map destination position.
function Map.goTo(x, y, z)
    mapGoto(x, y, z)
end

-- Stop server auto walking
function Map.stopAutoWalk()
    mapStopAutoWalk()
end

-- Browse Field specific tile by map position
-- @param x (number) - The x-coordinate of the map destination position.
-- @param y (number) - The y-coordinate of the map destination position.
-- @param z (number) - The z-coordinate of the map destination position.
function Map.browseField(x, y, z)
    mapBrowseField(x, y, z)
end

-- Check if a specific position is walkable
-- @param x (number) - The x-coordinate of the map destination position.
-- @param y (number) - The y-coordinate of the map destination position.
-- @param z (number) - The z-coordinate of the map destination position.
-- @param ignoreBlockPath (boolean) - If is true will consider block path tiles as walkable
-- @param ignoreMagicField (boolean) - If is true will not consider magic field as a blockable obstacle on tile
-- @param ignoreMonsters (boolean) - If is true will not consider monster as a blockable obstacle on tile
-- @param ignoreNpcs (boolean) - If is true will not consider npc as a blockable obstacle on tile
function Map.canWalk(x, y, z, ignoreBlockPath, ignoreMagicField, ignoreMonsters, ignoreNpcs)
    return mapCanWalk(x, y, z, ignoreBlockPath or false, ignoreMagicField or false, ignoreMonsters or false, ignoreNpcs or false)
end

-- Get current map world camera position
-- This function is useful if you wanna a real-time position of your character
-- The game takes some time to update the position of a creature directly, so in specific cases that can be useful
-- Example of good cases: pathfinding
function Map.getCameraPosition()
    return mapCameraPosition()
end

--- Get a player creature on the screen, either by ID or name.
-- @param var (number|string) - The player ID if a number, or the player name if a string.
-- @return The player creature if found, or nil if not found.
function Map.getPlayerOnScreen(var)
    local playerId, playerName
    if type(var) == "number" then
        playerId = var
    else
        playerName = var:lower()
    end

    local creatures = Map.getCreatureIds(true, true)
    if not creatures then return end

    for i, cid in pairs(creatures) do
        local creature = Creature(cid)
        if (playerId and playerId == cid) or
            (playerName and playerName == creature:getName()) then
            return creature
        end
    end
end
