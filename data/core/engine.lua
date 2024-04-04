--- Engine table to manage various engine functionalities.
Engine = {}

--- Returns if healing function is enabled
-- This function is a wrapper around the external function engineIsHealingEnabled.
function Engine.isHealingEnabled()
    return engineIsHealingEnabled()
end

--- Returns if heal friend function is enabled
-- This function is a wrapper around the external function return IsHealFriendEnabled.
function Engine.isHealFriendEnabled()
    return engineIsHealFriendEnabled()
end

--- Returns current bot version
-- This function is a wrapper around the external function engineGetBotVersion.
function Engine.getBotVersion()
    return engineGetBotVersion()
end

--- Returns if bot is enabled
-- This function is a wrapper around the external function engineIsBotEnabled.
function Engine.isBotEnabled()
    return engineIsBotEnabled()
end

--- Returns if targeting function is enabled
-- This function is a wrapper around the external function engineIsTargetingEnabled.
function Engine.isTargetingEnabled()
    return engineIsTargetingEnabled()
end

--- Returns if magic shooter function is enabled
-- This function is a wrapper around the external function engineIsMagicShooterEnabled.
function Engine.isMagicShooterEnabled()
    return engineIsMagicShooterEnabled()
end

--- Returns if equipment function is enabled
-- This function is a wrapper around the external function engineIsEquipmentEnabled.
function Engine.isEquipmentEnabled()
    return engineIsEquipmentEnabled()
end

--- Returns if timer function is enabled
-- This function is a wrapper around the external function engineIsTimerEnabled.
function Engine.isTimerEnabled()
    return engineIsTimerEnabled()
end

--- Enables or disables the targeting system.
-- This function is a wrapper around the external function engineTargetingEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the targeting system.
function Engine.enableTargeting(enable)
    engineTargetingEnable(enable)
end

--- Enables or disables the magic shooter system.
-- This function is a wrapper around the external function engineMagicShooterEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the magic shooter system.
function Engine.enableMagicShooter(enable)
    engineMagicShooterEnable(enable)
end

--- Enables or disables the heal friend system.
-- This function is a wrapper around the external function engineHealFriendEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the heal friend system.
function Engine.enableHealFriend(enable)
    engineHealFriendEnable(enable)
end

--- Enables or disables the healing system.
-- This function is a wrapper around the external function engineHealingEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the healing system.
function Engine.enableHealing(enable)
    engineHealingEnable(enable)
end

--- Enables or disables the equipment system.
-- This function is a wrapper around the external function engineEquipmentEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the equipment system.
function Engine.enableEquipment(enable)
    engineEquipmentEnable(enable)
end

--- Enables or disables the timer system.
-- This function is a wrapper around the external function engineTimerEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) the timer system.
function Engine.enableTimer(enable)
    engineTimerEnable(enable)
end

--- Enables or disables all bot functions.
-- This function is a wrapper around the external function engineBotEnable.
-- @param enable (boolean) - A flag indicating whether to enable (true) or disable (false) all bot functions.
function Engine.enableBot(enable)
    engineBotEnable(enable)
end

--- Switches the profile of magic shooter by index.
-- This function is a wrapper around the external function engineMagicShooterSwitchProfile.
-- @param profileIndex (number) - The index of the profile to switch to (from 0 to 9).
function Engine.magicShooterSwitchProfile(profileIndex)
    engineMagicShooterSwitchProfile(profileIndex)
end

--- Gets the current profile index selected on magic shooter.
-- This function is a wrapper around the external function engineMagicShooterGetProfile.
-- @return (number) - The index of current selected profile.
function Engine.magicShooterGetProfile()
    return engineMagicShooterGetProfile()
end

--- Gets the default scripts directory.
-- This function is a wrapper around the external function engineGetScriptsDirectory.
-- @return (string) - The path to default scripts directory.
function Engine.getScriptsDirectory()
    return engineGetScriptsDirectory()
end

--- Gets the last user ID.
-- This function is useful to identify current user. You can use engineGetUserId directly if you need to avoid hooks.
-- @return (string) - The last generated user ID, non-sensitive data.
function Engine.getUserId()
    return engineGetUserId()
end