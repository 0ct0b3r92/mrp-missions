------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
---------------------------------- DON'T EDIT THESE LINES --------------------------------------
------------------------------------------------------------------------------------------------

local MissionName = "N/A"

Blips = {}

----------------------------
--------- Commands ---------
----------------------------

RegisterCommand("mission", function(source, args, rawCommand)
    input = args[1]
        for i, v in pairs(Config.Missions) do
            if input == i then
                if Active == 1 then
                    TriggerEvent('chatMessage', "^1[MISSIONS]: ^2There is a mission already in progress.")
                else
                Active = 1
                MissionName = input
                TriggerEvent('chatMessage', "^1[MISSIONS]: ^2".. MissionName .."^0 has been launched.")
                TriggerEvent("SpawnPed", input)
                TriggerEvent("mt:missiontext", input, 10000) -- 10000 = 10 Seconds.
                TriggerEvent('missionBlips', input)
            end
        end
    end
end, false)

RegisterCommand("stop", function(source, args, rawCommand)
    if Active == 0 then
        TriggerEvent('chatMessage', "^1[MISSIONS]: ^2There is not a Mission in Progress.")
    else
        TriggerEvent('chatMessage', "^1[MISSIONS]: ^2".. MissionName .."^0 has been completed! Great work.")
        TriggerEvent("DONE", MissionName)
        MissionName = "N/A"
        Active = 0
    end
end, false)

RegisterCommand("list", function(source, rawCommand)
    for i, v in pairs(Config.Missions) do
        TriggerEvent('chatMessage', "^1[MISSION LIST]: ^2".. i .."")
    end 
end, false)

--------------------------
--------- Events ---------
--------------------------

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(input, time)
    for i=1, #Config.Missions[input].MissionMessage do
        text = Config.Missions[input].MissionMessage
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
    end
end)

RegisterNetEvent('missionBlips')
AddEventHandler('missionBlips', function(input)
    local blip = AddBlipForCoord(Config.Missions[input].Blip.Position.x, Config.Missions[input].Blip.Position.y, Config.Missions[input].Blip.Position.z)
    SetBlipSprite (blip, Config.Missions[input].Blip.Icon)
    SetBlipDisplay(blip, Config.Missions[input].Blip.Display)
    SetBlipScale  (blip, Config.Missions[input].Blip.Size)
    SetBlipColour (blip, Config.Missions[input].Blip.Color)
    SetBlipAsShortRange(blip, false)
    local btitle = Config.Missions[input].Blip.Title
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(btitle)
    EndTextCommandSetBlipName(blip)
    table.insert(Blips, blip)
end)

RegisterNetEvent('DONE')
AddEventHandler('DONE', function(MissionName)
    for i=1, #Config.Missions[MissionName].Peds do
        SetEntityHealth(Config.Missions[MissionName].Peds[i].id, 0)
    end
    for i, blip in pairs(Blips) do
		RemoveBlip(blip)
    end
end)

RegisterNetEvent('SpawnPed')
AddEventHandler('SpawnPed', function(input)
    for i=1, #Config.Missions[input].Peds do
        RequestModel(GetHashKey(Config.Missions[input].Peds[i].modelHash))
    while not HasModelLoaded(GetHashKey(Config.Missions[input].Peds[i].modelHash)) do
          Wait(1)
      end
      Config.Missions[input].Peds[i].id = CreatePed(2, Config.Missions[input].Peds[i].modelHash, Config.Missions[input].Peds[i].x, Config.Missions[input].Peds[i].y, Config.Missions[input].Peds[i].z, Config.Missions[input].Peds[i].heading, true, true)
      SetPedRelationshipGroupHash(Config.Missions[input].Peds[i].id, GetHashKey("HATES_PLAYER"))
      SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
      SetPedDropsWeaponsWhenDead(Config.Missions[input].Peds[i].id, false)
      SetPedDiesWhenInjured(Config.Missions[input].Peds[i].id, true)
      GiveWeaponToPed(Config.Missions[input].Peds[i].id, Config.Missions[input].Peds[i].Weapon, 2800, false, true)
      ResetAiWeaponDamageModifier()
      -- SetAiWeaponDamageModifier(10) 
      -- ^ Sets Custom NPC Damage. ^
    end
end)

-----------------------------
--------- Functions ---------
-----------------------------

--------------------
--Mission Debugger--
--------------------

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5000)
--         TriggerEvent('chatMessage', ""..MissionName.."")
--     end
-- end)