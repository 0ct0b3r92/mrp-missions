local cooldown = 0
local ispriority = false

-------------------------------------------------------------------------------------
---------------------------------- MISSION ONE --------------------------------------
-------------------------------------------------------------------------------------

local Mission1Ped = {
    -- ID: id of NPC | name: Name of Blip | BlipID: Icone of Blip | VoiceName: NPC Talk When near it | Ambiance: Ambiance of Shop | Weapon: Hash of Weapon | modelHash: Model | X: Position x | Y: Position Y | Z: Position Z | heading: Where Npc look
    {id = 1, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -187.2, y = -1091.96, z = 27.16, heading = 27.16},
    {id = 2, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 30.14, heading = 82.01},
    {id = 3, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 30.14, heading = 60.94},
    {id = 4, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 30.14, heading = 3.31448912620544},
    {id = 5, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 30.14, heading = 3.31448912620544},
    {id = 6, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 36.13, heading = 82.01},
    {id = 7, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 36.13, heading = 60.94},
    {id = 8, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 36.13, heading = 3.31448912620544},
    {id = 9, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 36.13, heading = 3.31448912620544},
    {id = 10, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 42.13, heading = 82.01},
    {id = 11, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 42.13, heading = 60.94},
    {id = 12, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 42.13, heading = 3.31448912620544},
    {id = 13, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 42.13, heading = 3.31448912620544},
}

RegisterNetEvent('Mission1SpawnPed')
AddEventHandler('Mission1SpawnPed', function()
    for i=1, #Mission1Ped do
        RequestModel(GetHashKey(Mission1Ped[i].modelHash))
    while not HasModelLoaded(GetHashKey(Mission1Ped[i].modelHash)) do
          Wait(1)
      end
      Mission1Ped[i].id = CreatePed(2, Mission1Ped[i].modelHash, Mission1Ped[i].x, Mission1Ped[i].y, Mission1Ped[i].z, Mission1Ped[i].heading, true, true)
      SetPedRelationshipGroupHash(Mission1Ped[i].id, GetHashKey("HATES_PLAYER"))
      SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
      SetPedDropsWeaponsWhenDead(Mission1Ped[i].id, false)
      SetPedDiesWhenInjured(Mission1Ped[i].id, true)
      GiveWeaponToPed(Mission1Ped[i].id, Mission1Ped[i].Weapon, 2800, false, true)
      ResetAiWeaponDamageModifier()
      -- SetAiWeaponDamageModifier(10) 
      -- ^ Sets Custom NPC Damage. ^
    end
end)

-------------------------------------------------------------------------------------------------
---------------------------------- Custom Mission Template --------------------------------------
-------------------------------------------------------------------------------------------------

-- local Mission1Ped = {
--     -- ID: id of NPC | name: Name of Blip | BlipID: Icone of Blip | VoiceName: NPC Talk When near it | Ambiance: Ambiance of Shop | Weapon: Hash of Weapon | modelHash: Model | X: Position x | Y: Position Y | Z: Position Z | heading: Where Npc look
--     {id = 1, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -187.2, y = -1091.96, z = 27.16, heading = 27.16},
--     {id = 2, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 30.14, heading = 82.01},
--     {id = 3, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 30.14, heading = 60.94},
--     {id = 4, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 30.14, heading = 3.31448912620544},
--     {id = 5, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 30.14, heading = 3.31448912620544},
--     {id = 6, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 36.13, heading = 82.01},
--     {id = 7, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 36.13, heading = 60.94},
--     {id = 8, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 36.13, heading = 3.31448912620544},
--     {id = 9, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 36.13, heading = 3.31448912620544},
--     {id = 10, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 42.13, heading = 82.01},
--     {id = 11, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 42.13, heading = 60.94},
--     {id = 12, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 42.13, heading = 3.31448912620544},
--     {id = 13, VoiceName = "GENERIC_HI", Ambiance = "AMMUCITY", Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 42.13, heading = 3.31448912620544},
-- }

-- RegisterNetEvent('Mission1SpawnPed')
-- AddEventHandler('Mission1SpawnPed', function()
--     for i=1, #Mission1Ped do
--         RequestModel(GetHashKey(Mission1Ped[i].modelHash))
--     while not HasModelLoaded(GetHashKey(Mission1Ped[i].modelHash)) do
--           Wait(1)
--       end
--       Mission1Ped[i].id = CreatePed(2, Mission1Ped[i].modelHash, Mission1Ped[i].x, Mission1Ped[i].y, Mission1Ped[i].z, Mission1Ped[i].heading, true, true)
--       SetPedRelationshipGroupHash(Mission1Ped[i].id, GetHashKey("HATES_PLAYER"))
--       SetRelationshipBetweenGroups(5, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
--       SetPedDropsWeaponsWhenDead(Mission1Ped[i].id, false)
--       SetPedDiesWhenInjured(Mission1Ped[i].id, true)
--       GiveWeaponToPed(Mission1Ped[i].id, Mission1Ped[i].Weapon, 2800, false, true)
--       ResetAiWeaponDamageModifier()
--       -- SetAiWeaponDamageModifier(10) 
--       -- ^ Sets Custom NPC Damage. ^
--     end
-- end)

--------------------------------------------------------------------------------------------
---------------------------------- STARTS NEW MISSION --------------------------------------
--------------------------------------------------------------------------------------------

RegisterCommand("mission", function(source, args, rawCommand)
    print("Mission was started by: " .. ((source == 0) and 'console' or GetPlayerName(source)) )
    mission = args[1]
    TriggerEvent('chatMessage', "^1[MISSIONS]: ^0Mission ".. mission .." has been launched.")
    if mission == "1" and cooldown == 0 then
        TriggerServerEvent('cooldownt')
        TriggerEvent("Mission1SpawnPed")
        TriggerEvent("mt:missiontext", "~g~ Go to the Construction Site and Clear out the Resistance Forces.", 10000) -- 10000 = 10 Seconds.
        TriggerEvent('missionBlips')

-- Add new option to command --

-- if mission == "2" then
    -- TriggerServerEvent('cooldownt')
    -- TriggerEvent("Mission2SpawnPed")
    -- TriggerEvent("mt:missiontext", "~g~ (PLACE TEXT HERE)", 500)
	elseif cooldown > 0 then
		TriggerEvent('chatMessage', "^1[MISSIONS]: ^0There is a mission currently in progress.", -1)
	else 
		TriggerEvent('chatMessage', "^1[MISSIONS]: ^0This is not a mission.", -1)
    end

end, false)

-------------------------------------------------------------------------------------------------------
---------------------------------- KILL PEDS AFTER CANCELMISSION --------------------------------------
-------------------------------------------------------------------------------------------------------

RegisterNetEvent('KP')
AddEventHandler('KP', function()
    for i=1, #Mission1Ped do
    SetEntityHealth(Mission1Ped[i].id, 0)
    end
    -- Add new option to command --
    -- for i=1, #Mission2Ped do
    --     SetEntityHealth(Mission2Ped[i].id, 0)
    -- end
end)