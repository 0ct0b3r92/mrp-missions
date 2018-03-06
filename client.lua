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

Blips = {}

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(mission, time)
    for i=1, #Config.Missions[mission].MissionMessage do
        text = Config.Missions[mission].MissionMessage
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
    end
end)

RegisterCommand("stop", function(source, args, rawCommand)
    mission = args[1]
    TriggerEvent('chatMessage', "^1[MISSIONS]: ^2".. mission .."^0 has been completed! Great work.")
    TriggerServerEvent("cancelcooldown")
    TriggerEvent("DONE", mission)
    TriggerEvent("DELBlips")
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
AddEventHandler('missionBlips', function(mission)
    local blip = AddBlipForCoord(Config.Missions[mission].Blip.Position.x, Config.Missions[mission].Blip.Position.y, Config.Missions[mission].Blip.Position.z)
    SetBlipSprite (blip, Config.Missions[mission].Blip.Icon)
    SetBlipDisplay(blip, Config.Missions[mission].Blip.Display)
    SetBlipScale  (blip, Config.Missions[mission].Blip.Size)
    SetBlipColour (blip, Config.Missions[mission].Blip.Color)
    SetBlipAsShortRange(blip, false)
    local btitle = Config.Missions[mission].Blip.Title
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(btitle)
    EndTextCommandSetBlipName(blip)
    table.insert(Blips, blip)
end)

RegisterNetEvent('DONE')
AddEventHandler('DONE', function(mission)
    for i=1, #Config.Missions[mission].Peds do
        SetEntityHealth(Config.Missions[mission].Peds[i].id, 0)
    end
    for i, blip in pairs(Blips) do
		RemoveBlip(blip)
	end
end)

RegisterNetEvent('SpawnPed')
AddEventHandler('SpawnPed', function(mission)
    for i=1, #Config.Missions[mission].Peds do
        RequestModel(GetHashKey(Config.Missions[mission].Peds[i].modelHash))
    while not HasModelLoaded(GetHashKey(Config.Missions[mission].Peds[i].modelHash)) do
          Wait(1)
      end
      Config.Missions[mission].Peds[i].id = CreatePed(2, Config.Missions[mission].Peds[i].modelHash, Config.Missions[mission].Peds[i].x, Config.Missions[mission].Peds[i].y, Config.Missions[mission].Peds[i].z, Config.Missions[mission].Peds[i].heading, true, true)
      SetPedRelationshipGroupHash(Config.Missions[mission].Peds[i].id, GetHashKey("HATES_PLAYER"))
      SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
      SetPedDropsWeaponsWhenDead(Config.Missions[mission].Peds[i].id, false)
      SetPedDiesWhenInjured(Config.Missions[mission].Peds[i].id, true)
      GiveWeaponToPed(Config.Missions[mission].Peds[i].id, Config.Missions[mission].Peds[i].Weapon, 2800, false, true)
      ResetAiWeaponDamageModifier()
      -- SetAiWeaponDamageModifier(10) 
      -- ^ Sets Custom NPC Damage. ^
    end
end)

RegisterCommand("mission", function(source, args, rawCommand)
    mission = args[1]
        if cooldown > 0 then
            TriggerEvent('chatMessage', "^1[MISSIONS]: ^0There is a mission currently in progress.", -1)
        else
            TriggerEvent('chatMessage', "^1[MISSIONS]: ^2".. mission .."^0 has been launched.")
            TriggerServerEvent('cooldownt')
            TriggerEvent("SpawnPed", mission)
            TriggerEvent("mt:missiontext", mission, 10000) -- 10000 = 10 Seconds.
            TriggerEvent('missionBlips', mission)
        end
end, false)

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