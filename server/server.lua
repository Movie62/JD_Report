function isAdmin(player)
	local allowed = false
	if IsPlayerAceAllowed(player, Config.StaffAce) then -- Don't change this you monkey
		allowed = true
	end
	return allowed
end

function isSupport(player)
	local allowed = false
	if IsPlayerAceAllowed(player, Config.SupportAce) then
		allowed = true
	end
	return allowed
end

RegisterCommand("s", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, Config.StaffAce) then
		if args[1] ~= nil then
			TriggerClientEvent("sendStaffChat", -1, source, GetPlayerName(source), rawCommand:sub(3))
			exports.JD_logs:discord('Staff Chat: `'..rawCommand:sub(3)..'`', source, 0, '0', 'staffchat')
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/s [message]^0!"} })	
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Insuficient Premissions!"} })
	end
end)

RegisterCommand("help", function(source, args, rawCommand)
	if args[1] ~= nil then
		TriggerClientEvent("sendHelp", -1, source, GetPlayerName(source), rawCommand:sub(6))
		if Config.Discord then
			if Config.PingRole then
				ping = "<@&"..Config.Ping2..">"
			end
			PerformHttpRequest(Config.webhook2, function(err, text, headers) end, 'POST', json.encode({username = Config.username2, content = ping, embeds = {{["color"] = 16711680, ["author"] = {["name"] = GetPlayerName(source),["icon_url"] = "https://eu.ui-avatars.com/api/?background=0D8ABC&color=fff&name="..source..""}, ["description"] = "".. rawCommand:sub(6) .."",["footer"] = {["text"] = "© JokeDevil.com - "..os.date("%x %X %p"),["icon_url"] = "https://www.jokedevil.com/img/logo.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/help [message]^0!"} })
	end
end)

RegisterCommand("report", function(source, args, rawCommand)
	if args[1] ~= nil then
		TriggerClientEvent("sendReport", -1, source, GetPlayerName(source), rawCommand:sub(8))
		if Config.Discord then
			if Config.PingRole then
				ping = "<@&"..Config.Ping..">"
			end
			PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.username, content = ping, embeds = {{["color"] = 16711680, ["author"] = {["name"] = GetPlayerName(source),["icon_url"] = "https://eu.ui-avatars.com/api/?background=0D8ABC&color=fff&name="..source..""}, ["description"] = "".. rawCommand:sub(8) .."",["footer"] = {["text"] = "© JokeDevil.com - "..os.date("%x %X %p"),["icon_url"] = "https://www.jokedevil.com/img/logo.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/report [message]^0!"} })
	end
end)

RegisterCommand("pcd", function(source, args, rawCommand)
	if args[1] ~= nil then
		TriggerClientEvent("sendPCD", -1, source, GetPlayerName(source), rawCommand:sub(5))
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/pcd [time/inprogress]^0!"} })
	end
end)

RegisterCommand("r", function(source, args, rawCommand)
	if args[1] ~= nil then
		if args[2] ~= nil then
			local tPID = tonumber(args[1])
			if isSupport(source) then
				local str = rawCommand:sub(3)
				local str, i = str:gsub("2", "",2)  
				msg  = (i>0) and str or str:gsub("^.-%s", "",1)
				TriggerClientEvent('textmsg', tPID, source, msg, GetPlayerName(tPID), GetPlayerName(source))
				TriggerClientEvent('textsent', source, tPID, GetPlayerName(tPID))
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Insuficient Premissions!"} })
			end
		else 
			TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/r [id] [message]^0!"} })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Please use ^1/r [id] [message]^0!"} })
	end
end)

RegisterCommand("reportSound", function(source, args, rawCommand)
	if isAdmin(source) then
		TriggerClientEvent('toggleSound', source)
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Insuficient Premissions!"} })
	end
end)

RegisterCommand("toggleStaff", function(source, args, rawCommand)
	if isAdmin(source) then
		TriggerClientEvent('toggleStaff', source)
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^5[JD_Report]", "Insuficient Premissions!"} })
	end
end)

RegisterServerEvent('checkSupport') -- /help check
AddEventHandler('checkSupport', function(pPID, tmsg, tPID)
	local id = source
	if isSupport(id) then
		TriggerClientEvent("sendReportToAllSupport", -1, source, pPID, tostring(tmsg), tPID)
	else
	end
end)

RegisterServerEvent('checkadmin') -- /report Check
AddEventHandler('checkadmin', function(pPID, tmsg, tPID)
	local id = source
	if isSupport(id) then
		TriggerClientEvent("sendReportToAllAdmins", -1, source, pPID, tostring(tmsg), tPID)
	else
	end
end)

RegisterServerEvent('checkadmin2') -- staff chat check
AddEventHandler('checkadmin2', function(pPID, tmsg, tPID)
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("sendStaffChatToAllAdmins", -1, source, pPID, tostring(tmsg), tPID)
	else
	end
end)

RegisterServerEvent('checkadmin3') -- /PCD Check
AddEventHandler('checkadmin3', function(pPID, tmsg, tPID)
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("sendReportToAllAdmins2", -1, source, pPID, tostring(tmsg), tPID)
	else
	end
end)