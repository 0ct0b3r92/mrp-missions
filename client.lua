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
local Active      = 0
local securing    = false
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
                time = 10000
                TriggerServerEvent("sv:one", input, time)
                TriggerEvent("SpawnPed", input)
            end
        end
    end
end, false)

RegisterCommand("stop", function(source, args, rawCommand)
    if Active == 0 then
        TriggerEvent('chatMessage', "^1[MISSIONS]: ^2There is not a Mission in Progress.")
    else
        Active = 0
        message = "^1[MISSIONS]: ^2".. MissionName .."^0 has been completed! Great work."
        TriggerServerEvent("sv:two", message2)
        TriggerEvent("DONE", MissionName)
        aliveCheck()
        MissionName = "N/A"
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

RegisterNetEvent("mt:missiontext2")
AddEventHandler("mt:missiontext2", function(input, time)
    text = input
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
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
        local ped  = Config.Missions[MissionName].Peds[i].id
        local blip = GetBlipFromEntity(ped)
        RemoveBlip(blip)
        DeleteEntity(Config.Missions[MissionName].Peds[i].id)
    end
    for i=1, #Config.Missions[MissionName].Vehicles do
        local veh  = Config.Missions[MissionName].Vehicles[i].id
        local ped  = Config.Missions[MissionName].Vehicles[i].id2
        local blip = GetBlipFromEntity(veh)
        RemoveBlip(blip)
        DeleteEntity(ped)
        DeleteEntity(veh)
    end
    for i, blip in pairs(Blips) do
		RemoveBlip(blip)
    end
    securing    = false
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
        ped = AddBlipForEntity(Config.Missions[input].Peds[i].id)
        local Size     = 0.9
        SetBlipScale  (ped, Size)
        SetBlipAsShortRange(ped, false)
        blip = GetBlipFromEntity(ped)
        SetAiWeaponDamageModifier(1.0) -- 1.0 == Normal Damage. 
        -- ^ Sets Custom NPC Damage. ^
    end
    for i=1, #Config.Missions[input].Vehicles do
        veh         =  Config.Missions[input].Vehicles[i].Vehicle
        vehiclehash = GetHashKey(veh)
        RequestModel(vehiclehash)
        RequestModel(GetHashKey(Config.Missions[input].Vehicles[i].modelHash))
        while not HasModelLoaded(vehiclehash) do
          Wait(1)
        end
        while not HasModelLoaded(GetHashKey(Config.Missions[input].Vehicles[i].modelHash)) do
          Wait(1)
        end
        Config.Missions[MissionName].Vehicles[i].id = CreateVehicle(vehiclehash, Config.Missions[input].Vehicles[i].x, Config.Missions[input].Vehicles[i].y, Config.Missions[input].Vehicles[i].z,  Config.Missions[input].Vehicles[i].heading, 1, 0)
        Config.Missions[input].Vehicles[i].id2 = CreatePed(2, Config.Missions[input].Vehicles[i].modelHash, Config.Missions[input].Vehicles[i].x, Config.Missions[input].Vehicles[i].y, Config.Missions[input].Vehicles[i].z, Config.Missions[input].Vehicles[i].heading, true, true)
        SetPedRelationshipGroupHash(Config.Missions[input].Vehicles[i].id2, GetHashKey("HATES_PLAYER"))
        SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
        SetPedDropsWeaponsWhenDead(Config.Missions[input].Vehicles[i].id2, false)
        SetPedDiesWhenInjured(Config.Missions[input].Vehicles[i].id2, true)
        GiveWeaponToPed(Config.Missions[input].Vehicles[i].id2, Config.Missions[input].Vehicles[i].Weapon, 2800, false, true)
        ResetAiWeaponDamageModifier()
        SetPedIntoVehicle(Config.Missions[input].Vehicles[i].id2, Config.Missions[MissionName].Vehicles[i].id, -1)
        ped = AddBlipForEntity(Config.Missions[input].Vehicles[i].id)
        local Size     = 0.9
        SetBlipScale(ped, Size)
        SetBlipAsShortRange(ped, false)
        blip = GetBlipFromEntity(ped)
        SetAiWeaponDamageModifier(1.0) -- 1.0 == Normal Damage. 
        -- ^ Sets Custom NPC Damage. ^
    end
    aliveCheck()
end)

function aliveCheck()
    MissionName = MissionName
    while Active == 1 do
        for i=1, #Config.Missions[MissionName].Peds do
            if IsEntityDead(Config.Missions[MissionName].Peds[i].id) then
                local ped  = Config.Missions[MissionName].Peds[i].id
                local blip = GetBlipFromEntity(ped)
                RemoveBlip(blip)
            end
        end
        for i=1, #Config.Missions[MissionName].Vehicles do
            if IsEntityDead(Config.Missions[MissionName].Vehicles[i].id) then
                local veh  = Config.Missions[MissionName].Vehicles[i].id
                local blip = GetBlipFromEntity(veh)
                RemoveBlip(blip)
            end
        end
        Citizen.Wait(2500)
    end
end

function SecureObj()
    local SecureTime = 5
    while securing == true do
        PLY = PlayerId()
        PLYN = GetPlayerName(PLY)
        if SecureTime > 0 then
            message  = "~u~(~g~Capture Progress: ~r~".. SecureTime .."~u~)"
            SecureTime = SecureTime - 1
            TriggerEvent("mt:missiontext2", message, 1000)
            Citizen.Wait(1000)
        end
        if SecureTime == 0 then
            securing = false
            message  = "^1[MISSIONS]: ^2".. PLYN .."^0 has captured the objective!"
            message2 = "^1[MISSIONS]: ^2".. MissionName .."^0 has been completed! Great work."
            TriggerServerEvent("sv:two", message)
            TriggerServerEvent("sv:two", message2)
            Active = 0
            TriggerEvent("DONE", MissionName)
            aliveCheck()
            MissionName = "N/A"
        end
        
        if SecureTime == 5 then
            TriggerEvent("chatMessage", "You are now capturing the objective.")
            message  = "^1[MISSIONS]: ^2".. PLYN .."^0 is now capturing the objective."
            message2  = "^1[MISSIONS]: ^1(Capture Progress: ".. SecureTime .." )"
            TriggerServerEvent("sv:two", message)
            TriggerEvent("chatMessage", message2)
            SecureTime = SecureTime - 1
            Citizen.Wait(1000)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if MissionName ~= "N/A" then
            for k,v in pairs(Config.Missions[MissionName].Marker) do
                local coords = GetEntityCoords(GetPlayerPed(-1))
                if(GetDistanceBetweenCoords(coords, Config.Missions[MissionName].Marker.Position.x, Config.Missions[MissionName].Marker.Position.y, Config.Missions[MissionName].Marker.Position.z, true) < Config.Missions[MissionName].Marker.DrawDistance) then
                    DrawMarker(Config.Missions[MissionName].Marker.Type, Config.Missions[MissionName].Marker.Position.x, Config.Missions[MissionName].Marker.Position.y, Config.Missions[MissionName].Marker.Position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Missions[MissionName].Marker.Size.x, Config.Missions[MissionName].Marker.Size.y, Config.Missions[MissionName].Marker.Size.z, Config.Missions[MissionName].Marker.Color.r, Config.Missions[MissionName].Marker.Color.g, Config.Missions[MissionName].Marker.Color.b, 100, false, true, 2, false, false, false, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Active == 1 and MissionName ~="N/A" then
            for k,v in pairs(Config.Missions[MissionName].Marker) do
                if Active == 1 and MissionName ~="N/A" then
                    ply = PlayerId()
                    coords = GetEntityCoords(GetPlayerPed(ply))
                    if(GetDistanceBetweenCoords(coords, Config.Missions[MissionName].Marker.Position.x, Config.Missions[MissionName].Marker.Position.y, Config.Missions[MissionName].Marker.Position.z, true) < Config.Missions[MissionName].Marker.Size.x / 2) and not securing then
                        securing = true
                        SecureObj()
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Active == 1 and MissionName ~="N/A" then
            for k,v in pairs(Config.Missions[MissionName].Marker) do
                if Active == 1 and MissionName ~="N/A" then
                    ply = PlayerId()
                    coords = GetEntityCoords(GetPlayerPed(ply))
                    if(GetDistanceBetweenCoords(coords, Config.Missions[MissionName].Marker.Position.x, Config.Missions[MissionName].Marker.Position.y, Config.Missions[MissionName].Marker.Position.z, true) > Config.Missions[MissionName].Marker.Size.x / 2) then
                        securing = false
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    	roundx = tonumber(string.format("%.2f", x))
    	roundy = tonumber(string.format("%.2f", y))
    	roundz = tonumber(string.format("%.2f", z))
        SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~X:~s~ "..roundx)
		DrawText(0.33, 0.00)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Y:~s~ "..roundy)
		DrawText(0.44, 0.00)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Z:~s~ "..roundz)
		DrawText(0.55, 0.00)
		heading = GetEntityHeading(GetPlayerPed(-1))
		roundh = tonumber(string.format("%.2f", heading))
        SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Heading:~s~ "..roundh)
		DrawText(0.40, 0.05)
		speed = GetEntitySpeed(PlayerPedId())
		rounds = tonumber(string.format("%.2f", speed)) 
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Player Speed: ~s~"..rounds)
		health = GetEntityHealth(PlayerPedId())
		DrawText(0.40, 0.90)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Player Health: ~s~"..health)
		DrawText(0.40, 0.85)
		veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
		vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
		if IsPedInAnyVehicle(PlayerPedId(), 1) then
		vehenground = tonumber(string.format("%.2f", veheng))
		vehbodround = tonumber(string.format("%.2f", vehbody))
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Engine Health: ~s~"..vehenground)
		DrawText(0.0, 0.73)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.70)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("~r~Body Health: ~s~"..vehbodround)
		DrawText(0.0, 0.69) --hehe
	end
    end
end)
