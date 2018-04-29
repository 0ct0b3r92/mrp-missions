Config = {}
Config.Missions = {

  Mission1 = {
    
    MissionMessage = "ATTACK THE OBJECTIVE!",

    Blip = {
      Title = "Objective",
      Position = { x = -146.84, y = -1080.72, z = 42.02 },
      Icon     = 58,
      Display  = 4,
      Size     = 1.2,
      Color    = 1,
    },

    Marker = {
      Type     = 1,
      Position = { x = -146.84, y = -1080.72, z = 41.02 },
      Size     = {x = 5.0, y = 5.0, z = 2.0},
      Color    = {r = 100, g = 100, b = 204},
      DrawDistance = 100.0,
    },

    Peds = {
        -- ID: id of NPC | name: Name of Blip | BlipID: Icone of Blip | VoiceName: NPC Talk When near it | Ambiance: Ambiance of Shop | Weapon: Hash of Weapon | modelHash: Model | X: Position x | Y: Position Y | Z: Position Z | heading: Where Npc look
        {id = 1, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -187.2, y = -1091.96, z = 27.16, heading = 27.16},
        {id = 2, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 30.14, heading = 82.01},
        {id = 3, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 30.14, heading = 60.94},
        {id = 4, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 30.14, heading = 3.31448912620544},
        {id = 5, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 30.14, heading = 3.31448912620544},
        {id = 6, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 36.13, heading = 82.01},
        {id = 7, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 36.13, heading = 60.94},
        {id = 8, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 36.13, heading = 3.31448912620544},
        {id = 9, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 36.13, heading = 3.31448912620544},
        {id = 10, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 42.13, heading = 82.01},
        {id = 11, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 42.13, heading = 60.94},
        {id = 12, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 42.13, heading = 3.31448912620544},
        {id = 13, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 42.13, heading = 3.31448912620544},
    },

    Vehicles = {
      -- ID: id of NPC | name: Name of Blip | BlipID: Icone of Blip | VoiceName: NPC Talk When near it | Ambiance: Ambiance of Shop | Weapon: Hash of Weapon | modelHash: Model | X: Position x | Y: Position Y | Z: Position Z | heading: Where Npc look
      {id = 1, id2 = 1, Vehicle = "rhino", modelHash = "s_m_y_ammucity_01", x = -203.92, y = -1096.21, z = 21.16, heading = 143.9},
    }
  },

--   Mission2 = {
    
--     MissionMessage = "ATTACK THE OBJECTIVE!",

--     Blip = {
--       Title = "Objective",
--       Position = { x = -187.2, y = -1091.96, z = 27.16 },
--       Icon     = 58,
--       Display  = 4,
--       Size     = 1.2,
--       Color    = 1,
--     },

--     Peds = {
--         -- ID: id of NPC | name: Name of Blip | BlipID: Icone of Blip | VoiceName: NPC Talk When near it | Ambiance: Ambiance of Shop | Weapon: Hash of Weapon | modelHash: Model | X: Position x | Y: Position Y | Z: Position Z | heading: Where Npc look
--         {id = 1, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -187.2, y = -1091.96, z = 27.16, heading = 27.16},
--         {id = 2, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 30.14, heading = 82.01},
--         {id = 3, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 30.14, heading = 60.94},
--         {id = 4, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 30.14, heading = 3.31448912620544},
--         {id = 5, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 30.14, heading = 3.31448912620544},
--         {id = 6, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 36.13, heading = 82.01},
--         {id = 7, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 36.13, heading = 60.94},
--         {id = 8, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 36.13, heading = 3.31448912620544},
--         {id = 9, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 36.13, heading = 3.31448912620544},
--         {id = 10, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -179.47, y = -1078.39, z = 42.13, heading = 82.01},
--         {id = 11, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -173.8, y = -1062.78, z = 42.13, heading = 60.94},
--         {id = 12, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -160.2, y = -1067.93, z = 42.13, heading = 3.31448912620544},
--         {id = 13, Weapon = 0x83BF0278, modelHash = "s_m_y_ammucity_01", x = -165.83, y = -1083.26, z = 42.13, heading = 3.31448912620544},
--     },

--    Vehicles = {
--        {id = 1, id2 = 1, Vehicle = "rhino", modelHash = "s_m_y_ammucity_01", x = -203.92, y = -1096.21, z = 21.16, heading = 143.9},
--    }

--   },

}
