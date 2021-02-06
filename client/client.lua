local ReportSound = true
local toggleStaff = true

RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, names2)
  TriggerEvent('chat:addMessage', { args = {"^5[Reply]", "^*^2Reply sent to: ["..tPID.."] "..names2} })
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(source, textmsg, names2, names3 )
  TriggerEvent('chat:addMessage', { args = {Config.PrefixReply, "^*^2"..names3 ..": " .. textmsg} })
end)

RegisterNetEvent("toggleSound")
AddEventHandler('toggleSound', function(source, textmsg, names2, names3 )
  if ReportSound then
    ReportSound = false
    TriggerEvent('chat:addMessage', { args = {"^5[JD_Report]", "^*^1Report Sound ^1Disabled"} })
  else
    ReportSound = true
    TriggerEvent('chat:addMessage', { args = {"^5[JD_Report]", "^*^1Report Sound ^2Enabled"} })
  end  
end)

RegisterNetEvent("toggleStaff")
AddEventHandler('toggleStaff', function(source, textmsg, names2, names3 )
  if toggleStaff then
    toggleStaff = false
    ReportSound = false
    TriggerEvent('chat:addMessage', { args = {"^5[JD_Report]", "^*^1Disabled"} })
  else
    toggleStaff = true
    ReportSound = true
    TriggerEvent('chat:addMessage', { args = {"^5[JD_Report]", "^*^2Enabled"} })
  end  
end)

RegisterNetEvent('sendHelp')
AddEventHandler('sendHelp', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', { args = {Config.Prefix2, "^1^*Help Request sent to the staff online!"} })
	  TriggerServerEvent("checkSupport", name, message, id)
  elseif pid ~= myId then
    TriggerServerEvent("checkSupport", name, message, id)
  end
end)

RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', { args = {Config.Prefix, "^1^*Report sent to the admins online!"} })
	  TriggerServerEvent("checkadmin", name, message, id)
  elseif pid ~= myId then
    TriggerServerEvent("checkadmin", name, message, id)
  end
end)

RegisterNetEvent('sendPCD')
AddEventHandler('sendPCD', function(id, name, msg)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', { args = {Config.Prefix, "^1^*PCD Requested!"} })
	  TriggerServerEvent("checkadmin3", name, msg , id)
  elseif pid ~= myId then
    TriggerServerEvent("checkadmin3", name, msg, id)
  end
end)

RegisterNetEvent('sendStaffChat')
AddEventHandler('sendStaffChat', function(id, name, message)
    TriggerServerEvent("checkadmin2", name, message, id)
end)

RegisterNetEvent('sendStaffChatToAllAdmins')
AddEventHandler('sendStaffChatToAllAdmins', function(id, name, message, i)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    local iName = string.gsub(tostring(name), "~.-~", "")
    TriggerEvent('chat:addMessage', { args = {Config.PrefixStaffChat, "^*^2"..i.." | "..iName .."  "..":  " .. message} })
  end
end)

RegisterNetEvent('sendReportToAllAdmins')
AddEventHandler('sendReportToAllAdmins', function(id, name, message, i)
  if toggleStaff then
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    if pid == myId then
      local iName = string.gsub(tostring(name), "~.-~", "")
      TriggerEvent('chat:addMessage', { args = {Config.Prefix, "^*^3======================================================="} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix, "^*^3PlayerID: ^0"..i.." ^0| ^3PlayerName: ^0"..iName} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix, message} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix, "^*^3======================================================="} })
      if ReportSound then
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        Citizen.Wait(300)
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        Citizen.Wait(300)
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
      end
    end
  end
end)

RegisterNetEvent('sendReportToAllAdmins2')
AddEventHandler('sendReportToAllAdmins2', function(id, name, message, i)
  if toggleStaff then
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    if pid == myId then
      local iName = string.gsub(tostring(name), "~.-~", "")
      TriggerEvent('chat:addMessage', { args = {"[PCD]", "^*^3======================================================="} })
      TriggerEvent('chat:addMessage', { args = {"[PCD]", "^*^3PlayerID: ^0".. i .." ^0| ^3PlayerName: ^0"..iName.." ^3Requested: "..message..""} })
      TriggerEvent('chat:addMessage', { args = {"[PCD]", "^*^3======================================================="} })
      if ReportSound then
        PlaySound(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
      end
    end
  end
end)

RegisterNetEvent('sendReportToAllSupport')
AddEventHandler('sendReportToAllSupport', function(id, name, message, i)
  if toggleStaff then
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    if pid == myId then
      local iName = string.gsub(tostring(name), "~.-~", "")
      TriggerEvent('chat:addMessage', { args = {Config.Prefix2, "^*^2======================================================="} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix2, "^*^2PlayerID: ^0"..i.." ^0| ^2PlayerName: ^0"..iName} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix2, message} })
      TriggerEvent('chat:addMessage', { args = {Config.Prefix2, "^*^2======================================================="} })
    end
  end
end)