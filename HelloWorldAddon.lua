HelloWorldAddon = {}
HelloWorldAddon.name = "HelloWorldAddon"

function HelloWorldAddon.Initialize()
	HelloWorldAddon.inCombat = IsUnitInCombat("player")

	-- register events the addon handles
	EVENT_MANAGER:RegisterForEvent(HelloWorldAddon.name, EVENT_PLAYER_COMBAT_STATE, HelloWorldAddon.OnPlayerCombatState)
end

function HelloWorldAddon.OnAddOnLoaded(event, addonName)
	-- event fires each time any addon loads
	-- we only care when our own addon loads
	if addonName == HelloWorldAddon.name then
		HelloWorldAddon.Initialize()
		-- unregister the event again as our addon is loaded
		-- we don't want to run it for each other addon that will load
		EVENT_MANAGER:UnregisterForEvent(HelloWorldAddon.name, EVENT_ADD_ON_LOADED)
	end
end

function HelloWorldAddon.OnPlayerCombatState(event, inCombat)
	if inCombat ~= HelloWorldAddon.inCombat then
		HelloWorldAddon.inCombat = inCombat
	end

	if inCombat then
		d("Entering combat.")
	else
		d("Exiting combat.")
	end
end

EVENT_MANAGER:RegisterForEvent(HelloWorldAddon.name, EVENT_ADD_ON_LOADED, HelloWorldAddon.OnAddOnLoaded)
