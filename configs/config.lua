Config = {}
--[[
    Für weitere Details steht euch auch die Dokumentation zur Verfügung.
    gehe dazu einfach auf 
]]

--[[
    Setze das auf True um die vCAD-Server Antworten in eurer Server Console zu sehen.
]]
Config.Debug = true

--[[
    Trage hier dein PrivateKey ein!
    Config.ApiKey = "KEY"
]]
Config.ApiKey = ""

--[[
    Setze die Computer ID ein um es an ein bestimmten PC zu senden.
    z.B 
    Computer = {1, 5} oder {1}
    oder
    Computer = "all"
]]
Config.Computer = "all"

Config.CharSync = {
    --[[
        Wenn Ihr nur den Fahrzeug Sync haben wollt, stellt das "Activated einfach auf false, dann werden keine Charakter gesynct.
    ]]
    Activated = true,
    --[[
        Ihr nutzt ein Multichar System und habt wechselnde Identifier, setzt "Multichar" auf true.
    ]]
    Multichar = true,


    --[[
        Wollt Ihr das die Aktuellen Haare in der Akte eingetragen wird?
        Beachtet die hair.lua
        Deaktiviert: false
        Aktivieren: true
    ]]
    HairColor = false, -- AKTUELL NICHT SUPPORTED!!

    --[[
        Wollt Ihr das die Aktuellen Augenfarbe in der Akte eingetragen wird?
        Beachtet die eye.lua
        Deaktiviert: false
        Aktivieren: true
    ]]
    EyeColor = false, -- AKTUELL NICHT SUPPORTED!!

    --[[
        Ihr habt bereits eine Spalte mit AUTO_INCREMENT, und diese Spalte ist als UNIQUE Makiert, screibt sie statt nil in Anführungszeichen (") bei Id_Spalte rein.
        Ihr habt keine Ahnung davon? lasst es auf nil und die ID Spalte wird Automatisch in eurer Datenbank hinzugefügt.
        Wird nur benötigt wenn "Multichar = true"
    ]]
    Id_Spalte = nil,
    --[[
        Ihr habt noch eine Spalte wo z.B der Steamnamen drin steht in eurer users Tabelle?
        schreibt den Spalten namen nach dem gleichzeichen in Anführungszeichen und der wird mit in der Akte eingetragen.
        Deaktiviert = nil
        Standard = "steamname"
    ]]

    Aliases = nil,

    --[[
        Ihr habt eure Handynummer in der users Tabelle gespeichert? tragt hier den Spalten namen ein.
        Aus = nil
        Standard  = "phone_number"
    ]]
    Phone_Number = nil
}

Config.Vehicle = {
    --[[
        Solltet Ihr den Vehicle Sync nutzen wollen, schaltet diesen hier ein.
        An = true
        Aus = false
    ]]
    Activated = true,

    HU_spalte = nil
}
--[[
    Ändern Sie den Befehl nach Belieben
    Config.Command = nil | Deaktiviert
]]
Config.Command = "vCAD-Car" -- Ändern Sie den Befehl nach Belieben

--[[
    User rechte für den Command
    Trage hier die User ein die Rechte haben deine Config Fahrzeuge hinzuzufügen.
]]
Config.Admins = {
    {
        identifier = "BFH88808",  -- citizenid
        name = "Asus",
    }
}