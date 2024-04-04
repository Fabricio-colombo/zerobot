-- Table to represent a Container and its associated functions
Container = {}
Container.__index = Container

-- Set up the constructor call
setmetatable(Container, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

--- Constructor for the Container class
-- @param containerIndex The index for the container
-- @return A new Container object
function Container.new(containerIndex)
    local self = setmetatable({}, Container)
    self.cid = containerIndex  -- Store the container index
    return self
end

--- Get the container's index.
-- @return The container's index
function Container:getIndex()
    return self.cid
end

--- Get the container's name.
-- This function gets the container's name.
-- @return The container's name, or nil if container doesn't exists
function Container:getName()
    return containerGetName(self.cid)
end

--- Get the container items.
-- This function gets the container items.
-- @return A table containing all container items, or nil if container doesn't exists
function Container:getItems()
    return containerGetItems(self.cid)
end

--- Move item from container to inventory.
-- This function moves item from a specific container to a specific inventory slot.
-- @param containerSlot The slot that contains the item.
-- @param inventorySlot The destination inventory slot to move.
-- @param itemCount The item count to move.
-- @return True if succeeds, or nil if container/item/inventory slot doesn't exists
function Container:moveItemToInventory(containerSlot, inventorySlot, itemCount)
    return containerMoveItemToInventory(self.cid, containerSlot, inventorySlot, itemCount)
end

--- Move item from container to map position.
-- This function moves item from a specific container to a specific map position.
-- @param containerSlot The slot that contains the item.
-- @param itemCount The item count to move.
-- @param toX (number) - The x-coordinate of the map position destination.
-- @param toY (number) - The y-coordinate of the map position destination.
-- @param toZ (number) - The z-coordinate of the map position destination.
-- @return True if succeeds, or nil if container/item/inventory slot/tile doesn't exists
function Container:moveItemToGround(containerSlot, itemCount, toX, toY, toZ)
    return containerMoveItemToGround(self.cid, containerSlot, itemCount, toX, toY, toZ)
end

--- Move item from container to other container.
-- This function moves item from a specific container to other specific container.
-- @param containerSlot The slot that contains the item.
-- @param itemCount The item count to move.
-- @param toContainerIndex (number) - The index of other container.
-- @param toContainerSlot (number) - The slot of other container.
-- @return True if succeeds, or nil if container/item/inventory slot/tile doesn't exists
function Container:moveItemToContainer(containerSlot, itemCount, toContainerIndex, toContainerSlot)
    return containerMoveItemToContainer(self.cid, containerSlot, itemCount, toContainerIndex, toContainerSlot)
end

--- Use an item from specified slot.
-- This function uses an item from a specified slot, if the item is a container you can specify if should open on same window.
-- @param containerSlot (number) - The slot that contains the item.
-- @param openNewWindow (boolean) - If should open the item (container) in a new window
-- @return True if succeeds, or nil if container/item doesn't exists
function Container:useItem(containerSlot, openNewWindow)
    return containerUseItem(self.cid, containerSlot, openNewWindow and openNewWindow or false)
end

--- Show higher container.
-- This function request the server to show the previous/higher container.
function Container:moveUp()
    return containerMoveUp(self.cid)
end

--- Close container.
-- This function request the server to close a specific container.
function Container:close()
    return containerClose(self.cid)
end

--- Get the container items capacity.
-- This function gets the container items capacity.
-- @return The container items capacity, or nil if container doesn't exists
function Container:getCapacity()
    return containerGetCapacity(self.cid)
end

--- Get the container items count.
-- This function gets the container items count.
-- @return The container items count, or nil if container doesn't exists
function Container:getItemCount()
    return containerGetItemCount(self.cid)
end