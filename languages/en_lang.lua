--------------------------------------------------------------------------------------
---------------------------------- ENGLISH -------------------------------------------
--VORP admin lua

Locales["en_lang"] = {
    ------------------------------------------------
    -- MAIN MENU
    MenuTitle                 = "VORP ADMIN",
    MenuSubTitle              = "Main menu",
    Administration            = "Administration",
    Booster                   = "Boosters",
    Database                  = "Database",
    Teleport                  = "Teleports",
    administration_desc       = "Administration ",
    booster_desc              = "Admin boosters",
    database_desc             = "Access to database",
    teleport_desc             = "Teleports ",
    confirm                   = "Confirm", -- for all inputs
    empty                     = "its empty", --for all inputs
    MenuTitle_desc            = "Player Manegement",
    SimpleAction              = "simple actions",
    AdvancedAction            = "advanced actions",
    ------------------------------------------------
    -- Player status
    SteamName                 = "Steam Name: ",
    ServerID                  = "Server ID: ",
    PlayerGroup               = "Player Group: ",
    PlayerJob                 = "Player Job: ",
    Grade                     = "Grade: ",
    Identifier                = "Identifier: ",
    PlayerMoney               = "Player Money: ",
    PlayerGold                = "Player Gold: ",
    PlayerStaticID            = "Player Static ID: ",
    PlyaerWhitelist           = "Player Is whitelist: ",
    PlayerWarnings            = "Player warnings: ",
    ------------------------------------------------
    -- submenu ADMIN ACTIONS
    MenuSubtitle2             = "Players online",
    kick_p                    = "Kick",
    freeze_p                  = "Freeze/unfreeze",
    unfreeze_p                = "Unfreeze ",
    ban_p                     = "Ban ",
    spectate_p                = "Spectate ",
    revive_p                  = "Revive ",
    respawn_p                 = "Respawn ",
    heal_p                    = "Heal ",
    gotoback_p                = "Goback",
    bring_p                   = "Bring ",
    warn_p                    = "Warn ",
    unwarn_p                  = "Unwarn",
    unban_p                   = "Unban",
    whitelist_p               = "whitelist",
    unwhitelist_p             = "unwhitelist",
    setjob_p                  = "setjob",
    setgroup_p                = "setgroup",
    -- the description of the above ^^
    kick_desc                 = "Kick: ",
    freeze_desc               = "Freeze; ",
    unfreeze_desc             = "Unfreeze: ",
    ban_desc                  = "Ban: ",
    unban_desc                = "unban:  ",
    spectate_desc             = "Spectate: ",
    revive_desc               = "Revive: ",
    respawn_desc              = "Respawn: ",
    heal_desc                 = "Heal: ",
    gotoback_desc             = "Go back to were you were",
    bring_desc                = "Bring: ",
    warn_desc                 = "give a short reason yes it must be short.",
    unwarn_desc               = "unwarn: ",
    whitelist_desc            = "whitelist: ",
    setjob_desc               = "set job to: ",
    setgroup_desc             = "set group to: ",
    banunban                  = "BAN/UNBAN",
    whiteunwhite              = "WHITE/UNWHITE",
    warnunwarn                = "WARN/UNWARN",
    banunban_desc             = "type = ban/unban<br> StaticID = number NOT server ID <br> Time example 1h,1d,1w,1m,1y permaban 0 <br>DONT USE IF TYPE IS UNBAN",
    whiteunwhite_desc         = "type = whitelist/unwhitelist <br> StaicID = number<br> check discord to get his static ID or databse",
    typestaticid              = "TYPE STATICID",
    typestaticidtime          = "TYPE STATICID *Time",
    cantwarnstaff             = "you cant warn staff",
    cantkickstaff             = "you cant kick staff",
    cantbanstaff              = "you cant ban staff",
    whiteset                  = "whitelist was set",
    whiteremove               = "whitelist was remove",
    incorrecttype             = "incorrect type",
    incorrect                 = "incorrect",
    missing                   = "missing one argument add type and staticID",
    -------------------------------------------------
    --BOOSTERS
    Boosters                  = "Boosters",
    godMode                   = "GOD MODE",
    noclipMode                = "NO CLIP",
    goldenCores               = "GOLDEN CORES",
    infiniteammo              = "INFINITE AMMO",
    godMode_desc              = "set yourself as god ",
    move                      = "W/A/S/D/Q/Z- MOVE ",
    speedMode                 = " LShift to Change speed ",
    Cammode                   = " H-Relative mode ",
    goldCores_desc            = "set golden cores ",
    infammo_desc              = "set infinite ammo<br> make sure to have weapon in hand ",
    switchedon                = "Switched on",
    switchedoff               = "Switched off",
    noweapon                  = " you need a weapon in hand",
    selfrevive                = "Revive",
    selfrevive_desc           = "revive yourself ",
    selfheal                  = "Heal",
    selfheal_desc             = "heal yourself ",
    goto_p                    = "Go to player",
    goback_p                  = "Go back to Last location",
    goback_desc               = "GO back to Last location ",
    inserthashmodel           = "insert hashmodel",
    spawnhorse_desc           = "spawn a horse",
    spawnwagon_desc           = "spawn a wagon",
    ---------------------------------------------------
    -- TELEPORTS
    teleports                 = "Teleports",
    insert                    = "INSERT X Y Z",
    tpm                       = "TPM",
    tptocoords                = "TP to Coords",
    tptoplayer                = "TP to Player",
    tpbackadmin               = "Teleport Back",
    bringplayer               = "Bring Player",
    teleporttomarker_desc     = "teleport to way point",
    teleporttocoords_desc     = "Teleport to location",
    teleportplayer_desc       = "Teleport to the player",
    bringplayer_desc          = "Bring player to you",
    insertid                  = "Insert player ID",
    sendback                  = "send player back",
    sendback_desc             = "send player back to his/hers last location",
    goto_desc                 = "go to player",
    sendadmin_desc            = "go back to your last location",
    gotoplayerfirst           = "go to player first",
    -----------------------------------------------------
    --ADMIN ACTIONS
    playerslist               = "Players List ",
    adminactions              = "Admin Actions",
    offLineactions            = "Offline Actions",
    offlineplayers_desc       = "Actions to be made if players are offline",
    --submenu
    playerlist_desc           = "list of players online",
    adminactions_desc         = "Admin acitions menu",
    objectmenu                = "Object Menu",
    printmodel                = "PRINT the Object",
    deletemodel               = "Delete Object",
    printmodel_desc           = "Print the hash model",
    deletemodel_desc          = "delete the object model no it wont save to DB",
    closestobject             = "Object hash: ",
    spawnpedanimal            = "spawn ped/animal",
    spawnhorse                = "SPAWN HORSE",
    spawnpedanimal_desc       = "spawn ped or an animal",
    objectsubmenu             = "object menu",
    objectsubmenu_desc        = "delte or print objects",
    deletehorse               = "deletehorse",
    deletehorse_desc          = "you must be seteaded",
    deletewagon               = "del wagons",
    deletewagon_desc          = "you must be in drivers seat",
    deletewagonradius         = "delete wagons with a radius",
    deletewagonradius_desc    = "use number between 1 and 100",
    getcoords                 = "Get Coords",
    getcoords_desc            = "Get coords of location",
    youdeletedhorse           = "You have deleted a horse",
    youneedtobeseatead        = "You need to be in the drivers seat",
    advalue                   = "add a value",
    XYZ                       = "X Y Z",
    insertcoords              = "INSERT COORDS",
    copyclipboardcoords_desc  = "copy to clipboard",
    vector3                   = "Vector3",
    copyclipboardvector3_desc = "copy to clipboard",
    vector4                   = "Vector4",
    copyclipboardvector4_desc = "copy to clipboard",
    heading                   = "Heading",
    copyclipboardheading_desc = "copy to clipboard players heading direction",
    ---------------------------------------------------
    -- DEVTOOLS
    spawnwagon                = "Spawn Wagon",
    devtoolssubmenu           = "Dev Tools",
    insertpedhash             = "Insert ped hash",
    spawnentity               = "SPAWN ENTITY",
    insertmodel               = "Insert model",
    SpawnWagon                = "SPAWN WAGON",
    devtools                  = "Dev Tools",
    devtools_desc             = "tools for Developers",
    ----------------------------------------------------------------
    --DATABASE
    Playerinventory           = "Player Inventory", --submenu title
    give                      = "Give menu",
    Give_desc                 = "give stuff to player",
    remove                    = "Remove menu",
    Remove_desc               = "remove stuff from players",
    GiveItems                 = "Give Items",
    GiveWeapons               = "Give weapons",
    GiveMoneyGold             = "Give money/gold",
    GiveHorse                 = "Give horse",
    GiveWagon                 = "Give wagon",
    giveitem_desc             = "give item to: ",
    giveweapon_desc           = "give weapon to: ",
    givemoney_desc            = "givemoney to: ",
    givehorse_des             = "give horse to: ",
    givewagon_desc            = "givewagon to : ",
    showInventory             = "Show Inventory items",
    Removemoney               = "Remove all Money",
    RemoveGold                = "Remove all Gold",
    Clearallitems             = "Clear all Items",
    Clearallweapons           = "Clear all Weapons",
    accessinventory_desc      = "inventory items from player",
    givenwagon                = "you gave a wagon to the player",
    accessplayers_desc        = " access players inventory items",
    removemoney_desc          = "remove all pocket money.<br> does not remove from bank money",
    removegold_desc           = "remove all pocket gold.<br> does not remove from bank",
    clearallitems_desc        = "clear all player items",
    clearallweapons_desc      = "clear all player weapons and ammo",
    showinventory_desc        = "sow player inventory",
    ------------------------------------------------------------------------------
    -- USERSMENU
    Scoreboard                = "ScoreBoard",
    scoreboard_desc           = "list of players online",
    Report                    = "Report",
    reportoptions_desc        = "Report options",
    requeststaff              = "Request staff",
    Requeststaff_desc         = "Request staff if you need help they will reach out to you",
    requeststaff_disc         = "Player requested a staff",
    requeststaff_bug          = "Player found a bug",
    requeststaff_rulesbroke   = "Player reported rules were broken",
    requeststaff_cheating     = "Player reported someone is cheating",
    createticket              = "create ticket",
    tickectdiscord_desc       = " create a tick to discord",
    showMyInfo                = "Show my info",
    showmyinfo_desc           = "your winfo will be displayed",
    showJobsOnline            = "Jobs Online",
    showjobsonline_desc       = "Show waht jobs are online ",
    --------------------------------------------------------------------------
    -- NOTIFY
    goldremoved               = "gold has been removed",
    goldremovedfromyou        = "an admin removed your pocket gold",
    moneyremoved              = "money has been removed from player",
    moneyremovedfromyou       = "an admin removed your pocket money",
    weaponswiped              = "Weapons have been wiped",
    itemswiped                = "Items have been wiped",
    itemgiven                 = "the item was given",
    weapongiven               = "the Weapon was given",
    sent                      = "Sent!!",
    horsegiven                = "you gave a horse to the player",
    kickednotify              = "YOU HAVE BEEN KICKED",
    banned                    = "YOU HAVE BEEN BANNED",
    kickednotify1             = "please follow th rules!",
    respawned                 = "YOU WILL RESPAWN",
    lostall                   = " you will loose all your items",
    received                  = "you have received: ~o~",
    of                        = "~q~ of: ~o~",
    itemlimit                 = "player cannot carry this item reached limit",
    inventoryfull             = "~e~ player inventory is full",
    doesnotexist              = "ITEM does not exist in the DATABASE",
    receivedweapon            = "You have received a ~o~weapon",
    cantcarryweapon           = "~e~player cant carry more weapons",
    money                     = "~q~ in Cash",
    gold                      = "~q~ in Gold",
    horsereceived             = "received a horse, head to the stables. might have to relog!",
    wagonreceived             = "received a wagon, head to the stables. might have to relog!",
    itemwipe                  = "~e~all your items have been wiped by an ~o~admin",
    weaponwipe                = "all your weapons and ammo have been wiped by an admin",
    groupgiven                = "you have been given the Group: ~o~",
    jobgiven                  = "you have been given the Job: ~o~",
    gradegiven                = "Grade of: ~o~",
    noperms                   = "~e~you dont have permmision for this action",
    givehorse_desc            = "Gave a horse",
    copied                    = "coords copied to clipboard",
    notyetavailable           = "~e~not yet available",
    insertnumber              = "Insert a number",
    radius                    = "Radius",
    addquantity               = "add quantity",
    announce                  = "Announcement",
    announce_desc             = "send an Annoucement to everyone",
    lettersandnumbers         = "only letters and numbers no dots no commas etc",
    ---------------------------------------------------------------------------
    -- webhooks
    titlebooster              = "📋` /BOOSTERS`",
    usedgod                   = "used GodMode",
    usedgoldcores             = "used GOLDCORES",
    usednoclip                = "used NOCLIP",
    usedrevive                = "used self REVIVE",
    usedheal                  = "used self HEAL",
    usedinfinitammo           = "used INFINITE AMMO",
    spawn                     = "SPAWNED A: ",
    titleadmin                = "📋` /ADMIN ACTIONS`",
    usedfreeze                = "used freeze on player ",
    usedbring                 = "used bring on player ",
    usedgoto                  = "used goto on player ",
    usedreviveplayer          = "used revive on player ",
    usedhealplayer            = "used heal on player ",
    warned                    = "warned player ",
    unwarned                  = "unwarned player ",
    usedspectate              = "used spectate on player ",
    usedrespawn               = "used respawn on player ",
    usedkick                  = "used kick on player ",
    usedban                   = "used ban on player ",
    usedunban                 = "used unban on player ",
    usedwhitelist             = "used whitelist on player ",
    usedunwhitelist           = "used unwhitelist on player ",
    usedsetgroup              = "used setgroup on player ",
    usedsetjob                = "used setjob on player ",
    usedannounce              = "used Announce: ",
    titleteleport             = "📋` /TELEPORTS`",
    usedtpm                   = "used TPM",
    usedtptocoords            = "used TP TO COORDS ",
    usedtptoplayer            = "used TP TO Player ",
    usedbringplayer           = "used Bring Player ",
    titledatabase             = "📋` /DATABASE`",
    usedgiveitem              = "used giveitem on player ",
    usedgiveweapon            = "used giveweapon on player ",
    usedgivecurrency          = "used givecurrency on player ",
    usedgivehorse             = "used givehorse on player ",
    usedgivewagon             = "used givewagon on player ",
    usedclearmoney            = "used clearmoney on player ",
    usedcleargold             = "used cleargold on player ",
    usedclearitems            = "used clearitems on player ",
    usedclearweapons          = "used clear weapons on player ",
    report                    = "📋` /REPORTS`",
    reportitle                = "REPORTED",
    reportsent                = "report has been ~t6~sent~q~ to discord. a staff memember will be in contact if needed more details.",
    reportheader              = "REPORT SITUATION",
    message                   = "your message here!",
    requestTitle              = "REQUEST STAFF",
    requestsent               = "your request has been ~t6~sent",
    requestsubtitle           = "Request staff",
    needhelp                  = "I need Help",
    needhelp_desc             = " if you are new and need some help on the server",
    foundbug                  = "I found a Bug",
    foundbug_desc             = "make sure to relog first. if you found a bug worth mentioning",
    rulesbroken               = "Rules Were Broken",
    rulesbroken_desc          = "If someone broke the rules. you can also report it",
    someonecheating           = "Someone is Cheating",
    someonecheating_desc      = "if someone is cheating or you found an exploit. you can also reporte it",
    playerreported            = "Player reported: ",
    reportedtodiscord         = "~q~ has made a report to discord",
    player                    = "player: ~o~",
    requestingassistance      = " is requesting assistance ",
    New                       = " ~t6~new player need help",
    Foundbug                  = " have found a bug",
    Someonebrokerules         = " somone is breaking the rules",
    Someonecheating           = " someone is cheating",
    delhorse                  = "Del horse",
    usercommands              = "user commands",
    delwagon                  = "Del wagon",
    hideui                    = "Hide UI",
    cancelanimation           = "Cancel animation",
    commands                  = "Commands",
    object_desc               = " object menu"

}
