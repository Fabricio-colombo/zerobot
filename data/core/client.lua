Client = {}

--- Check if the client is currently connected.
-- This function is a wrapper around the external function clientIsConnected.
-- @return true if the client is currently connected, false otherwise.
function Client.isConnected()
    return clientIsConnected()
end

--- Check if a specified hotkey is currently pressed.
-- This function is a wrapper around the external function clientIsKeyPressed.
-- @param key (number) - The key code. Example: A (0x65)
-- @param flags (string) - The flags for modifiers. Refer the parameter value as Enums.FlagModifiers, apply bit or operation for multiple flags
-- @return true if the specified key is currently pressed, false otherwise.
function Client.isKeyPressed(key, flags)
	return clientIsKeyPressed(key, flags)
end

--- Show a message on center of game screen.
-- This function is a wrapper around the external function clientShowMessage.
-- @param message (string) - The message to be shown
function Client.showMessage(message)
	clientShowMessage(message)
end
