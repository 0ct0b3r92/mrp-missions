------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------
local cooldown = 0
local ispriority = false
  
-- Mission Text
RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

-- Reset Clock
RegisterCommand("cancelmission", function()
    TriggerServerEvent("cancelcooldown")
    TriggerEvent("KP")
end, false)

RegisterNetEvent('UpdateCooldown')
AddEventHandler('UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterNetEvent('UpdateTimer')
AddEventHandler('UpdateTimer', function(newispriority)
    ispriority = newispriority
end)

RegisterNetEvent('missionBlips')
AddEventHandler('missionBlips', function()
    x = -187.2
    y = -1091.96
    z = 27.16
    SetNewWaypoint(x, y)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if cooldown == 0 then
            DrawText2("")
        elseif ispriority == false then
            DrawText2("Mission Timer: ~r~".. cooldown .." ~w~Mins")
        end
	end
end)

	function DrawText2(text)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.45)
        SetTextDropshadow(1, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.174, 0.855)
    end