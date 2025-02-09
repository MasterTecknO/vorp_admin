---@diagnostic disable: undefined-global

-- has updated inventory
local hasResourceStarted = GetResourceState("vorp_inventory") == "started"
if not hasResourceStarted then
    print("vorp_inventory not started ensure vorp inventory is started before vorp_admin")
    return
end

local resourceVersion = GetResourceMetadata("vorp_inventory", "version", 0)
if tonumber(resourceVersion) < 2.9 then
    print("vorp_inventory is not up to date this resource will stop")
    StopResource("vorp_admin")
    return
end

local Core = {}
local VORPwl = {}
local stafftable = {}
local PlayersTable = {}

TriggerEvent("getCore", function(core)
    Core = core
end)

TriggerEvent("getWhitelistTables", function(cb)
    VORPwl = cb
end)

local ServerRPC = exports.vorp_core:ServerRpcCall() --[[@as ServerRPC]]

local function getUserData(User, _source)
    local Character = User.getUsedCharacter
    local group = Character.group

    local playername = (Character.firstname or "no name") .. ' ' .. (Character.lastname or "noname")
    local job = Character.job
    local identifier = Character.identifier
    local PlayerMoney = Character.money
    local PlayerGold = Character.gold
    local JobGrade = Character.jobGrade
    local getid = VORPwl.getEntry(identifier).getId()
    local getstatus = VORPwl.getEntry(identifier).getStatus()
    local warnstatus = User.getPlayerwarnings()

    local data = {
        serverId = _source,
        name = GetPlayerName(_source),
        Group = group,
        PlayerName = playername,
        Job = job,
        SteamId = identifier,
        Money = PlayerMoney,
        Gold = PlayerGold,
        Grade = JobGrade,
        staticID = tonumber(getid),
        WLstatus = tostring(getstatus),
        warns = tonumber(warnstatus),
    }
    return data
end

-- Register CallBack
ServerRPC.Callback.Register("vorp_admin:Callback:getplayersinfo", function(source, cb, args)
    if next(PlayersTable) then
        if args.search == "search" then -- is for unique player
            if PlayersTable[args.id] then
                local User = Core.getUser(args.id)
                if User then
                    local data = getUserData(User, args.id)
                    PlayersTable[args.id] = data
                    return cb(PlayersTable[args.id])
                end
                return cb(false)
            else
                return cb(false)
            end
        end

        for id, v in pairs(PlayersTable) do
            local User = Core.getUser(id)
            if User then
                local data = getUserData(User, id)
                PlayersTable[id] = data
            end
        end
        return cb(PlayersTable)
    end
    return cb(false)
end)

-------------------------------------------------------------------------------
--------------------------------- EVENTS TELEPORTS -----------------------------
--TP TO
RegisterServerEvent("vorp_admin:TpToPlayer", function(targetID)
    local _source = source
    if Core.getUser(targetID) then
        local targetCoords = GetEntityCoords(GetPlayerPed(targetID))
        TriggerClientEvent('vorp_admin:gotoPlayer', _source, targetCoords)
    else
        Core.NotifyRightTip(_source, "user dont exist", 8000)
    end
end)

--SENDBACK
RegisterServerEvent("vorp_admin:sendAdminBack", function()
    local _source = source
    TriggerClientEvent('vorp_admin:sendAdminBack', _source)
end)


--FREEZE
RegisterServerEvent("vorp_admin:freeze", function(targetID, freeze)
    local _source = targetID
    local state = freeze
    if Core.getUser(targetID) then
        TriggerClientEvent("vorp_admin:Freezeplayer", _source, state)
    end
end)
---------------------------------------------------------------
--BRING
RegisterServerEvent("vorp_admin:Bring", function(targetID, adminCoords)
    if Core.getUser(targetID) then
        TriggerClientEvent("vorp_admin:Bring", targetID, adminCoords)
    end
end)

--TPBACK
RegisterServerEvent("vorp_admin:TeleportPlayerBack", function(targetID)
    if Core.getUser(targetID) then
        TriggerClientEvent('vorp_admin:TeleportPlayerBack', targetID)
    end
end)

----------------------------------------------------------------------------------
---------------------------- ADVANCED ADMIN ACTIONS ---------------------------------------

--KICK
RegisterServerEvent("vorp_admin:kick", function(targetID, reason)
    local _source = targetID
    if Core.getUser(targetID) then
        TriggerClientEvent('vorp:updatemissioNotify', _source, _U("kickednotify"), _U("notify"), 8000)
        Wait(8000)
        DropPlayer(_source, reason)
    end
end)

--UNWARN WARN
RegisterServerEvent("vorp_admin:warns", function(targetID, status, staticid, msg)
    local _source = targetID
    local staticID = staticid
    local stats = status
    local reason = msg
    if Core.getUser(targetID) then
        if stats == "warn" then
            TriggerClientEvent("vorp:warn", _source, staticID)
            Core.NotifyRightTip(_source, reason, 8000)
        elseif stats == "unwarn" then
            TriggerClientEvent("vorp:unwarn", _source, staticID)
        end
    end
end)

--BAN
RegisterServerEvent("vorp_admin:BanPlayer", function(targetID, staticid, time)
    local _source = targetID
    local targetStaticId = tonumber(staticid)
    local datetime = os.time(os.date("!*t"))
    local banTime
    if Core.getUser(targetID) then
        if time:sub(-1) == 'd' then
            banTime = tonumber(time:sub(1, -2))
            banTime = banTime * 24
        elseif time:sub(-1) == 'w' then
            banTime = tonumber(time:sub(1, -2))
            banTime = banTime * 168
        elseif time:sub(-1) == 'm' then
            banTime = tonumber(time:sub(1, -2))
            banTime = banTime * 720
        elseif time:sub(-1) == 'y' then
            banTime = tonumber(time:sub(1, -2))
            banTime = banTime * 8760
        else
            banTime = tonumber(time)
        end
        if banTime == 0 then
            datetime = 0
        else
            datetime = datetime + banTime * 3600
        end

        TriggerClientEvent('vorp:updatemissioNotify', _source, _U("banned"),
            _U("notify"), 8000)
        SetTimeout(8000, function()
            TriggerClientEvent("vorp:ban", _source, targetStaticId, datetime)
        end)
    end
end)

--RESPAWN
RegisterServerEvent("vorp_admin:respawnPlayer", function(targetID)
    if not Core.getUser(targetID) then
        return
    end
    TriggerEvent("vorp:PlayerForceRespawn", targetID)
    TriggerClientEvent("vorp:PlayerForceRespawn", targetID)
    exports.vorp_inventory:closeInventory(source)
    exports.vorp_inventory:closeInventory(targetID)
    TriggerClientEvent('vorp:updatemissioNotify', targetID, _U("respawned"), _U("lostall"), 8000)
    SetTimeout(8000, function()
        TriggerClientEvent("vorp_core:respawnPlayer", targetID) --remove player
        TriggerClientEvent("vorp_admin:respawn", targetID)      --add effects
    end)
end)



--------------------------------------------------------------------
--------------------------------------------------------------------
-- DATABASE GIVE ITEM

RegisterServerEvent("vorp_admin:givePlayer", function(targetID, action, data1, data2, data3)
    local _source = source
    local user = Core.getUser(targetID)
    if not user then
        return
    end

    local Character = user.getUsedCharacter

    if action == "item" then
        local item = data1
        local qty = data2
        local itemCheck = exports.vorp_inventory:getItemDB(item)
        local canCarryItem = exports.vorp_inventory:canCarryItem(targetID, item, qty)
        local canCarryInv = exports.vorp_inventory:canCarryItems(targetID, qty)

        if not qty then
            return Core.NotifyRightTip(_source, "INVALID add: ITEM and AMOUNT", 5000)
        end

        if not itemCheck then
            return Core.NotifyRightTip(_source, _U("doesnotexist"), 5000)
        end

        if not canCarryInv then
            return Core.NotifyRightTip(_source, _U("inventoryfull"), 5000)
        end

        if not canCarryItem then
            return Core.NotifyRightTip(_source, _U("itemlimit"), 5000)
        end

        exports.vorp_inventory:addItem(targetID, item, qty)

        Core.NotifyRightTip(targetID, _U("received") .. qty .. _U("of") .. itemCheck.label .. "~q~", 5000)
        Core.NotifyRightTip(_source, _U("itemgiven"), 4000)
        return
    end

    if action == "weapon" then
        local weapon = data1

        local canCarryWeapons = exports.vorp_inventory:canCarryWeapons(targetID, 1, nil, weapon)

        if not canCarryWeapons then
            return Core.NotifyRightTip(_source, _U("cantcarryweapon"), 5000)
        end

        exports.vorp_inventory:createWeapon(targetID, weapon)

        Core.NotifyRightTip(targetID, _U("receivedweapon"), 5000)
        Core.NotifyRightTip(_source, _U("weapongiven"), 4000)
        return
    end

    if action == "moneygold" then
        local CurrencyType = data1
        local qty = data2

        if not qty then
            return Core.NotifyRightTip(_source, _U("addquantity"), 5000)
        end

        Character.addCurrency(tonumber(CurrencyType), tonumber(qty))
        if CurrencyType == 0 then
            Core.NotifyRightTip(targetID, _U("received") .. qty .. _U("money"), 5000)
        elseif CurrencyType == 1 then
            Core.NotifyRightTip(targetID, _U("received") .. qty .. _U("gold"), 5000)
        elseif CurrencyType == 2 then
            Core.NotifyRightTip(targetID, _U("received") .. qty .. " of roll ", 5000)
        end
        Core.NotifyRightTip(_source, _U("sent"), 4000)

        return
    end

    if action == "horse" then
        local identifier = Character.identifier
        local charid = Character.charIdentifier
        local hash = data1
        local name = data2
        local sex = data3
        if not Config.VorpStable then
            MySQL.insert(
                "INSERT INTO horses ( `identifier`, `charid`, `name`, `model`, `sex`) VALUES ( @identifier, @charid, @name, @model, @sex)"
                , {
                    identifier = identifier,
                    charid = charid,
                    name = tostring(name),
                    model = hash,
                    sex = sex
                })
        else
            MySQL.insert(
                "INSERT INTO stables ( `identifier`, `charidentifier`, `name`, `modelname`,`type`,`inventory` ) VALUES ( @identifier, @charid, @name, @modelname, @type, @inventory)"
                , {
                    identifier = identifier,
                    charid = charid,
                    name = tostring(name),
                    modelname = hash,
                    type = "horse",
                    inventory = json.encode({})
                })
        end
        Core.NotifyRightTip(targetID, _U("horsereceived"), 5000)
        Core.NotifyRightTip(_source, _U("horsegiven"), 4000)
        return
    end

    if action == "wagon" then
        local identifier = Character.identifier
        local charid = Character.charIdentifier
        local hash = data1
        local name = data2

        if not Config.VorpStable then
            MySQL.insert(
                "INSERT INTO wagons ( `identifier`, `charid`, `name`, `model`) VALUES ( @identifier, @charid, @name, @model)"
                , {
                    identifier = identifier,
                    charid = charid,
                    name = tostring(name),
                    model = hash
                })
        else
            MySQL.insert(
                "INSERT INTO stables ( `identifier`, `charidentifier`, `name`, `modelname`,`type`,`inventory` ) VALUES ( @identifier, @charid, @name, @modelname, @type, @inventory)"
                , {
                    identifier = identifier,
                    charid = charid,
                    name = tostring(name),
                    modelname = hash,
                    type = "wagon",
                    inventory = json.encode({})
                })
        end
        Core.NotifyRightTip(targetID, _U("wagonreceived"), 5000)
        Core.NotifyRightTip(_source, _U("givenwagon"), 4000)
    end
end)


--REMOVE DB

RegisterServerEvent("vorp_admin:ClearAllItems", function(type, targetID)
    local _source = source

    if not Core.getUser(targetID) then
        return
    end
    exports.vorp_inventory:closeInventory(targetID)

    if type == "items" then
        local inv = exports.vorp_inventory:getUserInventoryItems(targetID)
        if not inv then
            return print("empty inventory ")
        end

        for key, inventoryItems in pairs(inv) do
            Wait(10)
            exports.vorp_inventory:subItem(targetID, inventoryItems.name, inventoryItems.count)
        end
        Core.NotifyRightTip(_source, _U("itemswiped"), 4000)
        Core.NotifyRightTip(targetID, _U("itemwipe"), 5000)
    end

    if type == "weapons" then
        local weaponsPlayer = exports.vorp_inventory:getUserInventoryWeapons(targetID)
        for key, value in pairs(weaponsPlayer) do
            local id = value.id
            exports.vorp_inventory:subWeapon(targetID, id)
            exports.vorp_inventory:deleteWeapon(targetID, id)
            TriggerClientEvent('syn_weapons:removeallammo', targetID)  -- syn script
            TriggerClientEvent('vorp_weapons:removeallammo', targetID) -- vorp
        end
        Core.NotifyRightTip(_source, _U("weaponswiped"), 4000)
        Core.NotifyRightTip(targetID, _U("weaponwipe"), 5000)
    end
end)

--GET ITEMS FROM INVENTORY
RegisterServerEvent("vorp_admin:checkInventory", function(targetID)
    local _source = source
    if not Core.getUser(targetID) then
        return
    end
    local inv = exports.vorp_inventory:getUserInventoryItems(targetID)
    TriggerClientEvent("vorp_admin:getplayerInventory", _source, inv)
end)

--REMOVE CURRENCY
RegisterServerEvent("vorp_admin:ClearCurrency", function(targetID, type)
    local _source = source

    local Character = Core.getUser(targetID)
    if not Character then
        return
    end

    local money = Character.getUsedCharacter.money
    local gold = Character.getUsedCharacter.gold

    if type == "money" then
        Character.removeCurrency(0, money)
        Core.NotifyRightTip(_source, _U("moneyremoved"), 4000)
        Core.NotifyRightTip(targetID, _U("moneyremovedfromyou"), 4000)
    else
        Character.removeCurrency(1, gold)
        Core.NotifyRightTip(_source, _U("goldremoved"), 4000)
        Core.NotifyRightTip(targetID, _U("goldremovedfromyou"), 4000)
    end
end)

-----------------------------------------------------------------------------------------------------------------
--ADMINACTIONS
--GROUP
RegisterServerEvent("vorp_admin:setGroup", function(targetID, newgroup)
    local _source = targetID
    local NewPlayerGroup = newgroup
    local user = Core.getUser(_source)
    if not user then
        return
    end
    local character = user.getUsedCharacter
    character.setGroup(NewPlayerGroup)
    user.setGroup(NewPlayerGroup)
    TriggerEvent("vorp:setGroup", _source, NewPlayerGroup)
    Core.NotifyRightTip(_source, _U("groupgiven") .. NewPlayerGroup, 5000)
end)
-- JOB
RegisterServerEvent("vorp_admin:setJob", function(targetID, newjob, newgrade)
    local _source = targetID

    TriggerEvent("vorp:setJob", _source, newjob, newgrade)
    local user = Core.getUser(_source)
    if not user then
        return
    end
    local character = user.getUsedCharacter
    character.setJob(newjob)
    character.setJobGrade(newgrade)
    Core.NotifyRightTip(_source, _U("jobgiven") .. newjob, 5000)
    Core.NotifyRightTip(_source, _U("gradegiven") .. newgrade, 5000)
end)

-- WHITELIST
RegisterServerEvent("vorp_admin:Whitelist", function(targetID, staticid, type)
    local staticID = staticid
    if type == "addWhiteList" then
        TriggerEvent("vorp:whitelistPlayer", staticID)
    else
        TriggerEvent("vorp:unwhitelistPlayer", staticID)
    end
end)

RegisterServerEvent("vorp_admin:Whitelistoffline", function(staticid, type)
    local staticID = staticid

    if type == "whiteList" then
        TriggerEvent("vorp:whitelistPlayer", staticID)
    else
        TriggerEvent("vorp:unwhitelistPlayer", staticID)
    end
end)

--REVIVE
RegisterServerEvent("vorp_admin:revive", function(targetID)
    local _source = targetID
    if Core.getUser(_source) then
        TriggerClientEvent('vorp:resurrectPlayer', _source)
    end
end)

--HEAL
RegisterServerEvent("vorp_admin:heal", function(targetID)
    local _source = targetID
    if Core.getUser(_source) then
        TriggerClientEvent('vorp:heal', _source)
    end
end)

--SPECTATE
RegisterServerEvent("vorp_admin:spectate", function(targetID)
    local _source = source
    local targetCoords = GetEntityCoords(GetPlayerPed(targetID))
    TriggerClientEvent("vorp_sdmin:spectatePlayer", _source, targetID, targetCoords)
end)


RegisterServerEvent("vorp_admin:announce", function(announce)
    Core.NotifySimpleTop(-1, _U("announce"), announce, 10000)
end)



local function CheckTable(group, group1, object)
    for key, value in ipairs(Config.AllowedGroups) do
        for k, v in ipairs(value.group) do
            if v == group or v == group1 then
                if value.command == object then
                    return true
                end
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------
--PERMISSIONS
--OPEN MAIN MENU
RegisterServerEvent('vorp_admin:opneStaffMenu', function(object)
    local _source = source
    local ace = IsPlayerAceAllowed(_source, object) -- this feature allows to have discord role permissions
    local Character = Core.getUser(_source).getUsedCharacter
    local User = Core.getUser(_source)
    local group = Character.group
    local group1 = User.getGroup
    if ace or CheckTable(group, group1, object) then
        Perm = true
        TriggerClientEvent('vorp_admin:OpenStaffMenu', _source, Perm)
    else
        Perm = false
        TriggerClientEvent('vorp_admin:OpenStaffMenu', _source, Perm)
    end
end)


-------------------------------------------------------------------------------------------------------------------
-------------------------- Troll Actions--------------------------------------------------------------------------
RegisterServerEvent('vorp_admin:ServerTrollKillPlayerHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTrollKillPlayerHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerTrollInvisibleHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTrollInvisbleHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerTrollLightningStrikePlayerHandler', function(playerserverid)
    local playerPed = GetPlayerPed(playerserverid)
    local coords = GetEntityCoords(playerPed)
    TriggerClientEvent('vorp_admin:ClientTrollLightningStrikePlayerHandler', -1, coords)
end)

RegisterServerEvent('vorp_admin:ServerTrollSetPlayerOnFireHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTrollSetPlayerOnFireHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerTrollTPToHeavenHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTrollTPToHeavenHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerTrollRagdollPlayerHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTrollRagdollPlayerHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerDrainPlayerStamHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientDrainPlayerStamHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerHandcuffPlayerHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientHandcuffPlayerHandler', playerserverid)
end)

RegisterServerEvent('vorp_admin:ServerTempHighPlayerHandler', function(playerserverid)
    TriggerClientEvent('vorp_admin:ClientTempHighPlayerHandler', playerserverid)
end)

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- DISCORD --------------------------------------------------------

function GetIdentity(source, identity)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len(identity .. ":")) == identity .. ":" then
            return v
        end
    end
end

RegisterServerEvent('vorp_admin:logs', function(webhook, title, description)
    local _source = source
    local Identifier = GetPlayerIdentifier(_source, 1)
    local discordIdentity = GetIdentity(_source, "discord")
    local discordId = string.sub(discordIdentity, 9)
    local ip = GetPlayerEndpoint(_source)
    local steamName = GetPlayerName(_source)

    local message = "**Steam name: **`" ..
        steamName ..
        "`**\nIdentifier**`" ..
        Identifier ..
        "` \n**Discord:** <@" ..
        discordId ..
        ">**\nIP: **`" .. ip .. "`\n `" .. description .. "`"
    Core.AddWebhook(title, webhook, message, Config.webhookColor, Config.name, Config.logo, Config.footerLogo,
        Config.Avatar)
end)



-- alert staff of report
RegisterServerEvent('vorp_admin:alertstaff', function(source)
    local _source = source
    local Character = Core.getUser(_source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname --player char name

    for _, staff in pairs(stafftable) do
        Core.NotifyRightTip(staff, _U("player") .. playername .. _U("reportedtodiscord"), 4000)
    end
end)


RegisterServerEvent("vorp_admin:getStaffInfo", function(source)
    local _source = source

    local Staff = Core.getUser(_source).getUsedCharacter
    local User = Core.getUser(_source)
    local staffgroup1 = User.getGroup
    local staffgroup = Staff.group

    if staffgroup and staffgroup ~= "user" or staffgroup1 and staffgroup1 ~= "user" then
        stafftable[_source] = _source
    end
    local data = getUserData(User, _source)
    PlayersTable[_source] = data
end)

RegisterNetEvent("vorp_admin:requeststaff", function(source, type)
    local _source = source
    local playerID = _source
    local Character = Core.getUser(_source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname --player char name
    for id, staff in pairs(stafftable) do
        if type == "new" then
            Core.NotifyRightTip(staff, playername .. " ID: " .. playerID .. _U("requestingassistance") .. _U("New"),
                4000)
        elseif type == "bug" then
            Core.NotifyRightTip(staff,
                playername .. " ID: " .. playerID .. _U("requestingassistance") .. _U("Foundbug"), 4000)
        elseif type == "rules" then
            Core.NotifyRightTip(staff,
                playername .. " ID: " .. playerID .. _U("requestingassistance") .. _U("Someonebrokerules"), 4000)
        elseif type == "cheating" then
            Core.NotifyRightTip(staff,
                playername .. " ID: " .. playerID .. _U("requestingassistance") .. _U("Someonecheating"), 4000)
        end
    end
end)


AddEventHandler('playerDropped', function()
    local _source = source
    if _source then
        if stafftable[_source] then
            stafftable[_source] = nil
        end
        if PlayersTable[_source] then
            PlayersTable[_source] = nil
        end
    end
end)
