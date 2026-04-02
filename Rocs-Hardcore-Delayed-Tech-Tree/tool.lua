local Public = {}

--- @param name_settings string
--- @param setting_type "startup"|"runtime-global"|"runtime-per-user"
--- @param player? string|integer|LuaPlayer
--- @return any|nil
function Public.settings_mods(name_settings, setting_type, player)
	allow = settings.startup["rocs-hardcore-allow-mods-change-settings"].value -- Я бы заменил бы, но на что?

	if not allow then return false end

	local setting_object = nil

	if allow and setting_type == "startup" then
		setting_object = settings.startup[name_settings]
	elseif allow and setting_type == "runtime-global" then
		setting_object = settings.global[name_settings]
	elseif allow and setting_type == "runtime-per-user" then
		p = game.players[player]
		if not (p.valid and p) then return false end

		setting_object = settings.get_player_settings(p)[name_settings]
	end

	return setting_object and setting_object.value
end

return Public