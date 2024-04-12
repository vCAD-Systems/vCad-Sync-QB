local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('vCAD-Sync:SetBloodGroup')
AddEventHandler('vCAD-Sync:SetBloodGroup', function(blood)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    BloodGroup[xPlayer.PlayerData.citizenid] = blood
end)

RegisterServerEvent('vCAD-Sync:SetPhoneNumber')
AddEventHandler('vCAD-Sync:SetPhoneNumber', function(number)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    PhoneNumber[xPlayer.PlayerData.citizenid] = number
end)

local function internalSyncPlayer(ident, xPlayer)
    -- PREPARING DATA
    local senddata = {}
    senddata["name"] = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
    --senddata["size"] = 'UNAVAILABLE' -- not available in QB
    senddata["dateofbirth"] = xPlayer.PlayerData.charinfo.birthdate

    if Config.CharSync.Aliases ~= nil or Config.CharSync.Aliases ~= 'nil' then
        senddata["aliases"] = GetAliases(ident)
    else
        senddata["aliases"] = ""
    end

    senddata["gender"] = xPlayer.PlayerData.charinfo.gender
    if senddata["gender"] == 0 then
        senddata["gender"] = "Männlich"
    elseif senddata["gender"] == 1 then
        senddata["gender"] = "Weiblich"
    elseif senddata["gender"] == 2 then
        senddata["gender"] = "Divers"
    end

    if Config.CharSync.Multichar then
        for _, y in pairs(Users) do
            if y.owner == ident then
                senddata["unique"] = y.id
                break
            end
        end
    else
        senddata["unique"] = ident
    end

    if Config.CharSync.Phone_Number ~= nil or Config.CharSync.Phone_Number ~= 'nil' then
        senddata["phone"] = GetPhoneNumber(ident)
    end
    
    if Config.CharSync.EyeColor then
        senddata["eyecolor"] = GetEyeColor(ident, eyecolor)
    end
    if Config.CharSync.HairColor then
        senddata["haircolor"] = GetHairColor(ident, haircolor)
    end
    --[[ if BloodGroup[ident] ~= nil then ]]
        senddata["blood"] = xPlayer.PlayerData.metadata['bloodtype']
    --[[ end ]]


    -- CHECKING DATA
    if (senddata["unique"] == nil) then
        print("[vCAD][CharSync] No User found with Citizenid (" .. tostring(ident) .. ")!")
        return
    end


    -- SENDING DATA
    local header = {}
    header["content-type"] = "application/json"
    header["apikey"] = tostring(Config.ApiKey)
    
    if Config.Computer == 'all' then
        senddata["computer"] = 'all'
        Register_HttpRequest(senddata, header)
    else
        for k, v in pairs(Config.Computer) do
            senddata["computer"] = v
            Register_HttpRequest(senddata, header)
        end
    end
end

function syncPlayer()
    local xPlayers = QBCore.Functions.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        local ident = xPlayer.PlayerData.citizenid

        if xPlayer ~= nil then
            internalSyncPlayer(ident, xPlayer)
        elseif Config.Debug then
            print("[vCAD][CharSync] xPlayer Error!")
        end
    end

    if Config.Debug then
        print("[vCAD]: Player Sync beendet...")
    end
end

function Register_HttpRequest(senddata, header)
    if Config.Debug then
        print("[vCAD][CharSync][senddata]:"..json.encode(senddata))
    end
    PerformHttpRequest("https://api.vcad.li/files/addfile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print("errorCode:" ..errorCode)
            print("resultData:" ..resultData)
        end
        Wait(100)
        resultData2 = json.decode(resultData)
        

        if resultData2["data"]["insteadupdate"] == true then
            Update_HttpRequest(senddata, header)
        end
    end, 'POST', json.encode(senddata), header)
end

function Update_HttpRequest(senddata, header)
    PerformHttpRequest("https://api.vcad.li/files/updatefile?json_file=1", function (errorCode, resultData, resultHeaders)
        if Config.Debug then
            print(errorCode)
            print(resultData)
        end
    end, 'POST', json.encode(senddata), header)
end