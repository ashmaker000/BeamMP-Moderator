local MOD_NAME = "Moderator"
local PREFIX = "[Moderator] "
local CHAT_PREFIX = "^3[Moderator]^r "
local ROOT = "Resources/Server/Moderator"
local LOG_DIR = ROOT .. "/logs"
local OVERRIDES_PATH = ROOT .. "/config_overrides.json"
local BANS_PATH = ROOT .. "/bans.json"
local HISTORY_PATH = ROOT .. "/history.json"
local PUNISHMENTS_PATH = ROOT .. "/punishments.json"
local QUEUE_PATH = ROOT .. "/central_queue.jsonl"
local CENTRAL_CONFIG_PATH = ROOT .. "/central_config.json"

local SERVER_CONFIG_PATHS = {
  "/home/container/ServerConfig.toml",
  "ServerConfig.toml",
  "../ServerConfig.toml",
}

local defaultConfig = {
  server = {
    id = "",
    name = "",
    configPath = "",
  },

  adminNames = {},
  adminIdentifiers = {},
  trustedNames = {},
  trustedIdentifiers = {},

  bypassAdmins = true,
  bypassTrusted = true,
  notifyPlayer = true,
  logAllowedEvents = false,
  graceSecondsAfterJoin = 20,

  chat = {
    enabled = true,
    maxLength = 240,
    windowSeconds = 6,
    maxMessages = 5,
    duplicateWindowSeconds = 20,
    maxDuplicates = 2,
    muteAfterViolations = 4,
    muteSeconds = 30,
  },

  profanityFilter = {
    enabled = true,
    replacement = "*******",
    wholeWords = true,
    phrases = {
      "fuck",
      "fucking",
      "fucker",
      "fucked",
      "shit",
      "shitting",
      "bullshit",
      "bitch",
      "bastard",
      "dick",
      "dickhead",
      "cock",
      "pussy",
      "asshole",
      "arsehole",
      "wanker",
      "twat",
      "prick",
      "bellend",
      "slut",
      "whore",
      "motherfucker",
      "douche",
      "douchebag",
      "cum",
      "jizz",
      "bollocks",
      "bugger",
      "crap",
      "idiot",
      "moron",
      "retard",
      "retarded",
      "stupid cunt",
      "dumbass",
      "dipshit",
      "shithead",
      "fuckwit",
      "loser",
      "kys",
      "kill yourself",
      "go die",
      "die in a hole",
      "nigga",
      "nigger",
      "coon",
      "chink",
      "spic",
      "paki",
      "fag",
      "faggot",
      "tranny",
      "dyke",
      "kike",
      "gook",
      "raghead",
      "sandnigger",
      "rape",
      "rapist",
      "molest",
      "molester",
      "pedo",
      "pedophile",
      "nonce",
      "groomer",
      "porn",
      "onlyfans",
      "suck my",
      "suck dick",
      "suck my dick",
      "blowjob",
      "handjob",
      "deepthroat",
      "free nitro",
      "steam gift",
      "claim reward",
      "claim your prize",
      "click here",
      "bit.ly",
      "tinyurl",
      "discord.gift",
      "discord nitro",
      "crypto giveaway",
      "double your money",
      "cheap followers",
      "buy followers",
      "free robux",
      "free vbucks",
      "f u c k",
      "f.u.c.k",
      "f-u-c-k",
      "f_uck",
      "fu ck",
      "f*ck",
      "f**k",
      "sh1t",
      "s h i t",
      "b!tch",
      "c*nt",
      "n1gga",
      "n!gga",
      "k y s"
    },
    broadcastFilteredMessage = true,
    filteredMessageFormat = "<%name%> %message%",
    audit = true,
    addViolation = true,
    bypassAdmins = false,
    bypassTrusted = false,
    discordShowOriginal = true,
  },

  vehicleSpawn = {
    enabled = true,
    windowSeconds = 20,
    maxEvents = 4,
    violationCooldownSeconds = 3,
    lockSeconds = 45,
    deleteVehiclesOnLock = false,
  },

  vehicleEdit = {
    enabled = true,
    windowSeconds = 15,
    maxEvents = 5,
    violationCooldownSeconds = 2,
  },

  vehicleReset = {
    enabled = true,
    windowSeconds = 10,
    maxEvents = 12,
    warningCooldownSeconds = 5,
  },

  vehicleDelete = {
    enabled = true,
    windowSeconds = 10,
    maxEvents = 8,
    warningCooldownSeconds = 5,
  },

  vehicleRestrictions = {
    enabled = true,
    blockedModels = {},
    blockedPartConfigContains = {},
    maxDataBytes = 512000,
  },

  abuseScore = {
    enabled = true,
    decayPerMinute = 4,
    points = {
      chat = 8,
      vehicleSpawn = 12,
      vehicleEdit = 10,
      vehicleReset = 4,
      vehicleDelete = 4,
      vehicleRestriction = 18,
      chatProfanity = 4,
    },
    warnAt = 15,
    alertAt = 25,
    muteAt = 35,
    spawnLockAt = 45,
    kickAt = 70,
    banAt = 100,
    muteSeconds = 60,
    spawnLockSeconds = 120,
    banReason = "Automatic abuse protection",
    rules = {
      chat = {},
      vehicleSpawn = {},
      vehicleEdit = {},
      vehicleReset = {},
      vehicleDelete = {},
      vehicleRestriction = {},
      chatProfanity = {},
    },
  },

  progressiveHistory = {
    enabled = true,
    windowSeconds = 604800,
    repeatedOffenceBonus = 8,
    crossServerHandledByCentralApi = true,
  },

  escalation = {
    warnings = true,
    temporaryMute = true,
    spawnLock = true,
    kick = true,
    persistentBan = false,
  },

  moderatorAlerts = {
    enabled = true,
    minSecondsBetweenAlertsPerPlayer = 20,
  },

  persistentLogging = {
    enabled = true,
    filePrefix = "moderator",
  },

  discord = {
    enabled = false,
    webhookUrl = "",
    useCurl = false,
    username = "BeamMP Moderator",
    minScoreToSend = 25,
    sendEveryMute = true,
    sendEveryKickBan = true,
    sendViolationEvents = false,
    coalesceEscalations = true,
    minSecondsBetweenPlayerAlerts = 60,
    maskIps = true,
  },

  centralApi = {
    enabled = false,
    baseUrl = "",
    apiKey = "",
    useCurl = false,
    queueWhenDown = true,
    syncConfig = true,
  },

  clientCompanion = {
    enabled = true,
    resetLockOnMute = true,
    resetLockOnSpawnLock = true,
  },
}

local cfg = {}
local playerState = {}
local authByName = {}
local identifiersByPlayer = {}
local adminNameLookup = {}
local trustedNameLookup = {}
local adminIdentifierLookup = {}
local trustedIdentifierLookup = {}
local bans = {}
local history = {}
local activePunishments = {}
local runtimeOverrides = {}
local serverIdentity = { id = "unknown", name = "Unknown Server", map = "" }
local stateFor
local rebuildLookups
local historyCount
local recordHistory
local getIdentifiers
local identifierKeys

local function now()
  return os.time()
end

local function log(message)
  print(PREFIX .. tostring(message))
end

local function lower(value)
  return string.lower(tostring(value or ""))
end

local function shallowCopy(value)
  if type(value) ~= "table" then return value end
  local out = {}
  for k, v in pairs(value) do out[k] = shallowCopy(v) end
  return out
end

local function mergeInto(base, overlay)
  if type(overlay) ~= "table" then return base end
  for k, v in pairs(overlay) do
    if type(v) == "table" and type(base[k]) == "table" then
      mergeInto(base[k], v)
    else
      base[k] = shallowCopy(v)
    end
  end
  return base
end

local function jsonEncode(value)
  if Util and Util.JsonEncode then
    local ok, encoded = pcall(Util.JsonEncode, value)
    if ok then return encoded end
  end
  if type(value) == "string" then return '"' .. value:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"' end
  if type(value) == "number" or type(value) == "boolean" then return tostring(value) end
  if type(value) ~= "table" then return "null" end
  local isArray = true
  local count = 0
  for k in pairs(value) do
    count = count + 1
    if type(k) ~= "number" then isArray = false end
  end
  local parts = {}
  if isArray then
    for i = 1, count do parts[#parts + 1] = jsonEncode(value[i]) end
    return "[" .. table.concat(parts, ",") .. "]"
  end
  for k, v in pairs(value) do
    parts[#parts + 1] = jsonEncode(tostring(k)) .. ":" .. jsonEncode(v)
  end
  return "{" .. table.concat(parts, ",") .. "}"
end

local function jsonDecode(raw)
  if Util and Util.JsonDecode and type(raw) == "string" and raw ~= "" then
    local ok, decoded = pcall(Util.JsonDecode, raw)
    if ok then return decoded end
  end
  return nil
end

local function readFile(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local raw = f:read("*a")
  f:close()
  return raw
end

local function writeFile(path, content)
  local f = io.open(path, "w")
  if not f then return false end
  f:write(content)
  f:close()
  return true
end

local function appendFile(path, content)
  local f = io.open(path, "a")
  if not f then return false end
  f:write(content)
  f:close()
  return true
end

local function ensureDirectory(path)
  if FS and FS.Exists and FS.Exists(path) then return true end
  if FS and FS.CreateDirectory then
    local err = FS.CreateDirectory(path)
    if err == false or err == nil then return true end
  end
  os.execute('mkdir "' .. tostring(path) .. '" >NUL 2>NUL')
  return true
end

local function loadJsonTable(path)
  local decoded = jsonDecode(readFile(path) or "")
  if type(decoded) == "table" then return decoded end
  return {}
end

local function saveJsonTable(path, tbl)
  return writeFile(path, jsonEncode(tbl))
end

local function shellQuote(value)
  return '"' .. tostring(value or ""):gsub('"', '\\"') .. '"'
end

local function commandSucceeded(result, exitType, exitCode)
  if result == true then return true end
  if result == 0 then return true end
  if exitType == "exit" and exitCode == 0 then return true end
  return false
end

local function runCurlPost(url, body, tmpName, includeCentralAuth)
  if not url or url == "" then return false end
  ensureDirectory(LOG_DIR)
  local tmp = LOG_DIR .. "/" .. tostring(tmpName or "payload") .. ".json"
  if not writeFile(tmp, body) then return false end
  local auth = ""
  if includeCentralAuth and cfg.centralApi and cfg.centralApi.apiKey and cfg.centralApi.apiKey ~= "" then
    auth = ' -H "Authorization: Bearer ' .. tostring(cfg.centralApi.apiKey):gsub('"', '') .. '"'
  end
  local cmd = 'curl -fsS -H "Content-Type: application/json"' .. auth .. ' -X POST --data @'
    .. shellQuote(tmp) .. " " .. shellQuote(url)
  return commandSucceeded(os.execute(cmd))
end

local function runCurlGet(url, outPath)
  if not url or url == "" then return false end
  local auth = ""
  if cfg.centralApi and cfg.centralApi.apiKey and cfg.centralApi.apiKey ~= "" then
    auth = ' -H "Authorization: Bearer ' .. tostring(cfg.centralApi.apiKey):gsub('"', '') .. '"'
  end
  local cmd = 'curl -fsS' .. auth .. " " .. shellQuote(url) .. " -o " .. shellQuote(outPath) .. " >NUL 2>NUL"
  return commandSucceeded(os.execute(cmd))
end

local function parseTomlString(raw, key)
  if type(raw) ~= "string" then return nil end
  return raw:match('[\r\n]%s*' .. key .. '%s*=%s*"([^"]*)"')
      or raw:match('^%s*' .. key .. '%s*=%s*"([^"]*)"')
end

local function findServerConfigPath()
  if cfg.server and cfg.server.configPath and cfg.server.configPath ~= "" and readFile(cfg.server.configPath) then
    return cfg.server.configPath
  end
  for _, path in ipairs(SERVER_CONFIG_PATHS) do
    if readFile(path) then return path end
  end
  return nil
end

local function detectServerIdentity()
  local configuredId = tostring((cfg.server and cfg.server.id) or "")
  local configuredName = tostring((cfg.server and cfg.server.name) or "")
  local path = findServerConfigPath()
  local raw = path and readFile(path) or nil
  local cfgName = parseTomlString(raw, "Name") or parseTomlString(raw, "NamePrefix")
  local cfgMap = parseTomlString(raw, "Map") or ""

  local name = configuredName ~= "" and configuredName or cfgName or "Unknown Server"
  local id = configuredId ~= "" and configuredId or lower(name):gsub("[^%w]+", "-"):gsub("^-+", ""):gsub("-+$", "")
  if id == "" then id = "unknown" end

  serverIdentity = {
    id = id,
    name = name,
    map = cfgMap,
    configPath = path or "",
  }
end

local function encodePathPart(value)
  return tostring(value or ""):gsub("[^%w%-%._~]", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
end

local function recentCountsFor(playerID)
  local state = stateFor(playerID)
  local out = {}
  for name, bucket in pairs(state.buckets or {}) do
    out[name] = #bucket
  end
  return out
end

local function identifiersForAudit(playerID, name)
  local identifiers = getIdentifiers(playerID, name)
  return {
    raw = identifiers,
    keys = identifierKeys(identifiers),
  }
end

local function cleanDiscordText(value)
  local text = tostring(value or "")
  text = text:gsub("%^%a", "")
  text = text:gsub("%^%d", "")
  text = text:gsub("%s+", " ")
  text = text:gsub("^%s+", ""):gsub("%s+$", "")
  if text == "" then return "n/a" end
  return text
end

local function truncateDiscord(value, maxLen)
  local text = cleanDiscordText(value)
  local limit = tonumber(maxLen) or 1024
  if #text <= limit then return text end
  return text:sub(1, limit - 3) .. "..."
end

local function discordColorFor(eventName, action)
  local key = lower(action or eventName)
  if key == "kick" or key == "ban" then return 15158332 end
  if key == "mute" or key == "spawn_lock" then return 16753920 end
  if key == "vehicle_cleanup" then return 3447003 end
  if key == "discord_test" then return 5763719 end
  return 9807270
end

local function severityFor(eventName, action, source)
  if source == "manual" or source == "console" then return "MANUAL" end
  local key = lower(action or eventName)
  if key == "kick" or key == "ban" then return "REMOVAL" end
  if key == "mute" or key == "spawn_lock" or key == "vehicle_cleanup" then return "ACTION" end
  return "NOTICE"
end

local function maskIdentifier(identifier)
  local text = tostring(identifier or "")
  if cfg.discord and cfg.discord.maskIps ~= false then
    local ip = text:match("^ip:(%d+%.%d+)%.%d+%.%d+$")
    if ip then return "ip:" .. ip .. ".xxx.xxx" end
  end
  return text
end

local function maskedIdentifierList(keys)
  local out = {}
  for _, key in ipairs(keys or {}) do out[#out + 1] = maskIdentifier(key) end
  return out
end

local function formatCounts(counts)
  if type(counts) ~= "table" then return "n/a" end
  local parts = {}
  for key, value in pairs(counts) do
    parts[#parts + 1] = tostring(key) .. "=" .. tostring(value)
  end
  table.sort(parts)
  if #parts == 0 then return "n/a" end
  return table.concat(parts, ", ")
end

local function buildDiscordPayload(eventName, payload)
  local action = cleanDiscordText(payload.action or eventName)
  local player = cleanDiscordText(payload.playerName or "unknown")
  local score = math.floor(tonumber(payload.score or 0) or 0)
  local rule = cleanDiscordText(payload.rule or payload.kind or eventName)
  local reason = cleanDiscordText(payload.reason or "n/a")
  local chatMessage = payload.chatMessage and truncateDiscord(payload.chatMessage, 900) or nil
  local keys = maskedIdentifierList(payload.identifiers and payload.identifiers.keys or {})
  local serverName = cleanDiscordText(serverIdentity.name)
  local severity = severityFor(eventName, action, payload.actionSource)
  local description = "**Reason:** " .. reason
  if chatMessage then
    description = description .. "\n**In-game message:** " .. chatMessage
  end

  local embed = {
    title = severity .. " - " .. action:upper() .. " - " .. player,
    description = description,
    color = discordColorFor(eventName, action),
    timestamp = payload.time,
    footer = { text = serverName },
    fields = {
      { name = "Server", value = truncateDiscord(serverName, 1024), inline = true },
      { name = "Player", value = truncateDiscord(player, 1024), inline = true },
      { name = "Score", value = tostring(score), inline = true },
      { name = "Rule", value = truncateDiscord(rule, 1024), inline = true },
      { name = "Severity", value = severity, inline = true },
      { name = "Source", value = truncateDiscord(payload.actionSource or "automatic", 1024), inline = true },
      { name = "Event", value = truncateDiscord(eventName, 1024), inline = true },
      { name = "Identifiers", value = truncateDiscord(table.concat(keys, "\n"), 1024), inline = false },
      { name = "Recent Counts", value = truncateDiscord(formatCounts(payload.recentCounts), 1024), inline = false },
    },
  }

  if payload.seconds ~= nil then
    embed.fields[#embed.fields + 1] = { name = "Duration", value = tostring(payload.seconds) .. "s", inline = true }
  end
  if payload.removed ~= nil then
    embed.fields[#embed.fields + 1] = { name = "Vehicles Removed", value = tostring(payload.removed), inline = true }
  end
  if payload.historyCount ~= nil then
    embed.fields[#embed.fields + 1] = { name = "History", value = tostring(payload.historyCount), inline = true }
  end
  if type(payload.chain) == "table" and #payload.chain > 0 then
    embed.fields[#embed.fields + 1] = { name = "Actions Applied", value = truncateDiscord(table.concat(payload.chain, "\n"), 1024), inline = false }
  end
  if type(payload.matchedPhrases) == "table" and #payload.matchedPhrases > 0 then
    embed.fields[#embed.fields + 1] = { name = "Matched Phrase", value = truncateDiscord(table.concat(payload.matchedPhrases, "\n"), 1024), inline = false }
  end
  return jsonEncode({
    username = cfg.discord.username,
    embeds = { embed },
  })
end

local function discordShouldSend(eventName, payload)
  if not (cfg.discord and cfg.discord.enabled and cfg.discord.useCurl and cfg.discord.webhookUrl ~= "") then return false end
  if payload.suppressDiscord == true then return false end
  if eventName == "violation" and cfg.discord.sendViolationEvents ~= true and payload.forceDiscord ~= true then return false end
  local force = payload.forceDiscord == true
    or (eventName == "mute" and cfg.discord.sendEveryMute == true)
    or ((eventName == "kick" or eventName == "ban") and cfg.discord.sendEveryKickBan == true)
    or eventName == "punishment_summary"
  if payload.playerID ~= nil and payload.actionSource == "automatic" and eventName ~= "discord_test" then
    local state = stateFor(payload.playerID)
    local t = now()
    local cooldown = tonumber(cfg.discord.minSecondsBetweenPlayerAlerts or 0) or 0
    if payload.bypassDiscordCooldown ~= true then
      if cooldown > 0 and (t - tonumber(state.lastDiscordAlertAt or 0)) < cooldown then return false end
      state.lastDiscordAlertAt = t
    end
  end

  local score = tonumber(payload.score or 0) or 0
  return force or score >= tonumber(cfg.discord.minScoreToSend or 0)
end

local function sendDiscordEvent(eventName, payload)
  if not discordShouldSend(eventName, payload) then return end
  local body = buildDiscordPayload(eventName, payload)
  local ok = runCurlPost(cfg.discord.webhookUrl, body, "discord-payload", false)
  if not ok then
    log("Discord webhook post failed for event " .. tostring(eventName))
    if cfg.persistentLogging and cfg.persistentLogging.enabled then
      appendFile(LOG_DIR .. "/discord-failures.log", os.date("!%Y-%m-%dT%H:%M:%SZ") .. " " .. tostring(eventName) .. "\n")
    end
  end
end

local function queueCentralEvent(payload)
  if cfg.centralApi and cfg.centralApi.queueWhenDown then
    appendFile(QUEUE_PATH, jsonEncode(payload) .. "\n")
  end
end

local function centralEvent(payload)
  if not (cfg.centralApi and cfg.centralApi.enabled and cfg.centralApi.useCurl and cfg.centralApi.baseUrl ~= "") then return false end
  local ok = runCurlPost(cfg.centralApi.baseUrl .. "/events", jsonEncode(payload), "central-event", true)
  if not ok then queueCentralEvent(payload) end
  return ok
end

local function flushCentralQueue()
  if not (cfg.centralApi and cfg.centralApi.enabled and cfg.centralApi.useCurl and cfg.centralApi.baseUrl ~= "") then return false, 0, 0 end
  local raw = readFile(QUEUE_PATH)
  if not raw or raw == "" then return true, 0, 0 end

  local sent, failed = 0, 0
  local remaining = {}
  for line in raw:gmatch("[^\r\n]+") do
    if line ~= "" then
      local ok = runCurlPost(cfg.centralApi.baseUrl .. "/events", line, "central-queued-event", true)
      if ok then sent = sent + 1 else failed = failed + 1 remaining[#remaining + 1] = line end
    end
  end
  writeFile(QUEUE_PATH, table.concat(remaining, "\n") .. (#remaining > 0 and "\n" or ""))
  return failed == 0, sent, failed
end

local function syncCentralConfig()
  if not (cfg.centralApi and cfg.centralApi.enabled and cfg.centralApi.useCurl and cfg.centralApi.syncConfig and cfg.centralApi.baseUrl ~= "") then
    return false, "central config sync disabled"
  end
  local url = cfg.centralApi.baseUrl .. "/config/" .. encodePathPart(serverIdentity.id)
  if not runCurlGet(url, CENTRAL_CONFIG_PATH) then return false, "GET failed" end
  local remote = loadJsonTable(CENTRAL_CONFIG_PATH)
  if type(remote) ~= "table" then return false, "invalid JSON" end
  mergeInto(cfg, remote)
  mergeInto(cfg, runtimeOverrides)
  rebuildLookups()
  detectServerIdentity()
  return true, "synced"
end

function rebuildLookups()
  adminNameLookup = {}
  trustedNameLookup = {}
  adminIdentifierLookup = {}
  trustedIdentifierLookup = {}

  for _, name in ipairs(cfg.adminNames or {}) do adminNameLookup[lower(name)] = true end
  for _, name in ipairs(cfg.trustedNames or {}) do trustedNameLookup[lower(name)] = true end
  for _, ident in ipairs(cfg.adminIdentifiers or {}) do adminIdentifierLookup[tostring(ident)] = true end
  for _, ident in ipairs(cfg.trustedIdentifiers or {}) do trustedIdentifierLookup[tostring(ident)] = true end
end

local function loadConfig()
  local configPath = ROOT .. "/config.lua"
  if readFile(configPath) then
    local ok, err = pcall(dofile, configPath)
    if not ok then log("config.lua failed: " .. tostring(err)) end
  end
  runtimeOverrides = loadJsonTable(OVERRIDES_PATH)
  cfg = mergeInto(shallowCopy(defaultConfig), ModeratorConfig or {})
  mergeInto(cfg, runtimeOverrides)
  rebuildLookups()
  detectServerIdentity()
end

local function playerName(playerID)
  if MP and MP.GetPlayerName then
    local ok, name = pcall(MP.GetPlayerName, playerID)
    if ok and name then return tostring(name) end
  end
  return tostring(playerID)
end

function getIdentifiers(playerID, name)
  if identifiersByPlayer[tostring(playerID)] then return identifiersByPlayer[tostring(playerID)] end
  if MP and MP.GetPlayerIdentifiers then
    local ok, identifiers = pcall(MP.GetPlayerIdentifiers, playerID)
    if ok and type(identifiers) == "table" then
      identifiersByPlayer[tostring(playerID)] = identifiers
      return identifiers
    end
  end
  if name and authByName[lower(name)] then return authByName[lower(name)] end
  return {}
end

function identifierKeys(identifiers)
  local out = {}
  if type(identifiers) ~= "table" then return out end
  if identifiers.beammp then out[#out + 1] = "beammp:" .. tostring(identifiers.beammp) end
  if identifiers.discord then out[#out + 1] = "discord:" .. tostring(identifiers.discord) end
  if identifiers.ip then out[#out + 1] = "ip:" .. tostring(identifiers.ip) end
  return out
end

local function hasLookupIdentifier(lookup, identifiers)
  for _, key in ipairs(identifierKeys(identifiers)) do
    if lookup[key] then return true end
  end
  return false
end

local function send(playerID, message)
  if playerID == -2 then
    log(message)
    return
  end
  if MP and MP.SendChatMessage then
    MP.SendChatMessage(playerID, CHAT_PREFIX .. tostring(message))
  end
end

local function sendAdmins(message)
  if not MP or not MP.GetPlayers then return end
  for id, name in pairs(MP.GetPlayers() or {}) do
    if adminNameLookup[lower(name)] or hasLookupIdentifier(adminIdentifierLookup, getIdentifiers(id, name)) then
      send(id, message)
    end
  end
end

local function audit(eventName, payload)
  payload = payload or {}
  payload.time = os.date("!%Y-%m-%dT%H:%M:%SZ")
  payload.event = eventName
  payload.mod = MOD_NAME
  payload.server = {
    id = serverIdentity.id,
    name = serverIdentity.name,
    map = serverIdentity.map,
  }

  if payload.playerID ~= nil then
    payload.playerName = payload.playerName or playerName(payload.playerID)
    payload.identifiers = payload.identifiers or identifiersForAudit(payload.playerID, payload.playerName)
    payload.recentCounts = payload.recentCounts or recentCountsFor(payload.playerID)
  end

  local line = jsonEncode(payload)
  log("[" .. tostring(serverIdentity.name) .. "] " .. eventName .. " "
    .. tostring(payload.playerName or "") .. " " .. tostring(payload.reason or ""))

  if cfg.persistentLogging and cfg.persistentLogging.enabled then
    ensureDirectory(LOG_DIR)
    local day = os.date("!%Y-%m-%d")
    local path = LOG_DIR .. "/" .. tostring(cfg.persistentLogging.filePrefix or "moderator") .. "-" .. day .. ".jsonl"
    appendFile(path, line .. "\n")
  end

  centralEvent(payload)

  sendDiscordEvent(eventName, payload)
end

local function isAdmin(playerID, name)
  if playerID == -2 then return true end
  if adminNameLookup[lower(name or playerName(playerID))] then return true end
  return hasLookupIdentifier(adminIdentifierLookup, getIdentifiers(playerID, name))
end

local function isTrusted(playerID, name)
  if trustedNameLookup[lower(name or playerName(playerID))] then return true end
  return hasLookupIdentifier(trustedIdentifierLookup, getIdentifiers(playerID, name))
end

local function shouldBypass(playerID, name)
  if cfg.bypassAdmins == true and isAdmin(playerID, name) then return true end
  if cfg.bypassTrusted == true and isTrusted(playerID, name) then return true end
  return false
end

function stateFor(playerID)
  local key = tostring(playerID)
  local state = playerState[key]
  if not state then
    state = {
      buckets = {},
      duplicateMessages = {},
      violations = {},
      mutedUntil = 0,
      spawnLockedUntil = 0,
      score = 0,
      lastScoreAt = now(),
      lastNotice = {},
      lastAdminAlertAt = 0,
      lastDiscordAlertAt = 0,
      joinedAt = now(),
      lastOffendingChatMessage = nil,
      lastOffendingChatAt = 0,
      warned = false,
    }
    playerState[key] = state
  end
  return state
end

local function decayScore(state)
  local t = now()
  local elapsed = math.max(0, t - tonumber(state.lastScoreAt or t))
  local decay = (tonumber(cfg.abuseScore.decayPerMinute or 0) / 60) * elapsed
  state.score = math.max(0, tonumber(state.score or 0) - decay)
  state.lastScoreAt = t
end

local function prune(list, cutoff)
  local write = 1
  for read = 1, #list do
    if list[read] >= cutoff then
      list[write] = list[read]
      write = write + 1
    end
  end
  for i = #list, write, -1 do list[i] = nil end
end

local function recordWindow(playerID, bucketName, windowSeconds)
  local state = stateFor(playerID)
  local bucket = state.buckets[bucketName]
  if not bucket then
    bucket = {}
    state.buckets[bucketName] = bucket
  end

  local t = now()
  prune(bucket, t - windowSeconds)
  bucket[#bucket + 1] = t
  return #bucket
end

local function notifyLimited(playerID, kind, message, cooldownSeconds)
  local state = stateFor(playerID)
  local t = now()
  local last = tonumber(state.lastNotice[kind] or 0)
  if (t - last) >= cooldownSeconds then
    state.lastNotice[kind] = t
    if cfg.notifyPlayer then send(playerID, message) end
  end
end

local function banIdentifier(playerID, reason, source, rule, options)
  options = options or {}
  local identifiers = getIdentifiers(playerID, playerName(playerID))
  local keys = identifierKeys(identifiers)
  if #keys == 0 then return false end
  for _, key in ipairs(keys) do
    bans[key] = { reason = reason or cfg.abuseScore.banReason, at = os.date("!%Y-%m-%dT%H:%M:%SZ") }
  end
  saveJsonTable(BANS_PATH, bans)
  recordHistory(playerID, "ban", reason, source or "automatic")
  audit("ban", {
    playerID = playerID,
    playerName = playerName(playerID),
    reason = reason or cfg.abuseScore.banReason,
    rule = rule or "persistent_ban",
    action = "ban",
    actionSource = source or "automatic",
    score = stateFor(playerID).score,
    historyCount = historyCount(playerID),
    forceDiscord = true,
    suppressDiscord = options.suppressDiscord == true,
  })
  return true
end

local function isBannedIdentifiers(identifiers)
  for _, key in ipairs(identifierKeys(identifiers)) do
    if bans[key] then return true, bans[key].reason or "Banned" end
  end
  return false, nil
end

local function historyKeysFor(playerID)
  local keys = identifierKeys(getIdentifiers(playerID, playerName(playerID)))
  if #keys == 0 then keys[#keys + 1] = "name:" .. lower(playerName(playerID)) end
  return keys
end

local function punishmentKeysFor(playerID)
  return historyKeysFor(playerID)
end

local function saveActivePunishments()
  saveJsonTable(PUNISHMENTS_PATH, activePunishments)
end

local function setPersistentPunishment(playerID, kind, untilEpoch, reason)
  for _, key in ipairs(punishmentKeysFor(playerID)) do
    if type(activePunishments[key]) ~= "table" then activePunishments[key] = {} end
    activePunishments[key][kind] = {
      untilEpoch = untilEpoch,
      reason = reason or "",
      server = serverIdentity,
      playerName = playerName(playerID),
      at = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }
  end
  saveActivePunishments()
end

local function clearPersistentPunishment(playerID, kind)
  for _, key in ipairs(punishmentKeysFor(playerID)) do
    if type(activePunishments[key]) == "table" then
      activePunishments[key][kind] = nil
    end
  end
  saveActivePunishments()
end

local function applyPersistentPunishments(playerID)
  local state = stateFor(playerID)
  local t = now()
  for _, key in ipairs(punishmentKeysFor(playerID)) do
    local record = activePunishments[key]
    if type(record) == "table" then
      local muteRecord = record.mute
      if type(muteRecord) == "table" and tonumber(muteRecord.untilEpoch or 0) > t then
        state.mutedUntil = math.max(tonumber(state.mutedUntil or 0), tonumber(muteRecord.untilEpoch))
      end
      local lockRecord = record.spawnLock
      if type(lockRecord) == "table" and tonumber(lockRecord.untilEpoch or 0) > t then
        state.spawnLockedUntil = math.max(tonumber(state.spawnLockedUntil or 0), tonumber(lockRecord.untilEpoch))
      end
    end
  end
end

local function pruneHistory()
  local cutoff = now() - tonumber(cfg.progressiveHistory.windowSeconds or 0)
  for key, list in pairs(history) do
    if type(list) == "table" then
      local write = 1
      for read = 1, #list do
        if tonumber(list[read].atEpoch or 0) >= cutoff then
          list[write] = list[read]
          write = write + 1
        end
      end
      for i = #list, write, -1 do list[i] = nil end
    else
      history[key] = nil
    end
  end
end

function historyCount(playerID)
  if not (cfg.progressiveHistory and cfg.progressiveHistory.enabled) then return 0 end
  pruneHistory()
  local count = 0
  for _, key in ipairs(historyKeysFor(playerID)) do
    count = math.max(count, #(history[key] or {}))
  end
  return count
end

function recordHistory(playerID, action, reason, source)
  if not (cfg.progressiveHistory and cfg.progressiveHistory.enabled) then return end
  pruneHistory()
  local entry = {
    at = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    atEpoch = now(),
    server = serverIdentity,
    action = action,
    reason = reason,
    source = source or "automatic",
    playerName = playerName(playerID),
  }
  for _, key in ipairs(historyKeysFor(playerID)) do
    if type(history[key]) ~= "table" then history[key] = {} end
    history[key][#history[key] + 1] = entry
  end
  saveJsonTable(HISTORY_PATH, history)
end

local function triggerCompanion(playerID, resetLockedUntil, reason)
  if not (cfg.clientCompanion and cfg.clientCompanion.enabled and MP and MP.TriggerClientEvent) then return end
  local payload = jsonEncode({
    resetLockedUntil = resetLockedUntil or 0,
    reason = reason or "",
  })
  MP.TriggerClientEvent(playerID, "moderator_setState", payload)
end

local function rememberOffendingChat(playerID, message)
  if type(message) ~= "string" or message == "" then return end
  local state = stateFor(playerID)
  state.lastOffendingChatMessage = message
  state.lastOffendingChatAt = now()
end

local function recentOffendingChat(playerID)
  local state = stateFor(playerID)
  if type(state.lastOffendingChatMessage) ~= "string" then return nil end
  if (now() - tonumber(state.lastOffendingChatAt or 0)) > 120 then return nil end
  return state.lastOffendingChatMessage
end

local function playerVehicleIds(playerID)
  local out = {}
  if not (MP and MP.GetPlayerVehicles) then return out end
  local ok, vehicles = pcall(MP.GetPlayerVehicles, playerID)
  if not ok or type(vehicles) ~= "table" then return out end

  for key, value in pairs(vehicles) do
    if type(key) == "number" then
      out[#out + 1] = key
    elseif type(value) == "number" then
      out[#out + 1] = value
    elseif type(value) == "string" then
      local pid, vid = value:match("^(%d+)%-(%d+)$")
      if tonumber(pid) == tonumber(playerID) and tonumber(vid) ~= nil then out[#out + 1] = tonumber(vid) end
    elseif type(key) == "string" then
      local pid, vid = key:match("^(%d+)%-(%d+)$")
      if tonumber(pid) == tonumber(playerID) and tonumber(vid) ~= nil then out[#out + 1] = tonumber(vid) end
    end
  end

  return out
end

local function removePlayerVehicle(playerID, vehicleID)
  if MP and type(MP.RemoveVehicle) == "function" then
    local ok = pcall(MP.RemoveVehicle, playerID, vehicleID)
    if ok then return true, "MP.RemoveVehicle(pid,vid)" end
    ok = pcall(MP.RemoveVehicle, tostring(playerID) .. "-" .. tostring(vehicleID))
    if ok then return true, "MP.RemoveVehicle(serverVeh)" end
  end

  if MP and type(MP.DeleteVehicle) == "function" then
    local ok = pcall(MP.DeleteVehicle, playerID, vehicleID)
    if ok then return true, "MP.DeleteVehicle(pid,vid)" end
    ok = pcall(MP.DeleteVehicle, tostring(playerID) .. "-" .. tostring(vehicleID))
    if ok then return true, "MP.DeleteVehicle(serverVeh)" end
  end

  return false, "no_vehicle_delete_api"
end

local function removePlayerVehiclesOnLock(playerID, reason, source)
  local policy = cfg.vehicleSpawn and cfg.vehicleSpawn.deleteVehiclesOnLock
  if policy == nil or policy == false then return 0 end
  local removed = 0
  local failures = {}
  local vehicles = playerVehicleIds(playerID)
  if policy == true then policy = "all" end
  if policy == "latest" and #vehicles > 1 then
    table.sort(vehicles)
    vehicles = { vehicles[#vehicles] }
  elseif policy ~= "all" then
    return 0
  end
  for _, vehicleID in ipairs(vehicles) do
    local ok, how = removePlayerVehicle(playerID, vehicleID)
    if ok then
      removed = removed + 1
    else
      failures[#failures + 1] = tostring(vehicleID) .. ":" .. tostring(how)
    end
  end

  if removed > 0 or #failures > 0 then
    audit("vehicle_cleanup", {
      playerID = playerID,
      playerName = playerName(playerID),
      reason = reason,
      rule = "vehicleSpawn.deleteVehiclesOnLock",
      action = "vehicle_cleanup",
      actionSource = source or "automatic",
      removed = removed,
      failures = failures,
      score = stateFor(playerID).score,
    })
  end

  if removed > 0 then
    send(playerID, "Removed " .. tostring(removed) .. " existing vehicle(s) due to spawn lock.")
  end
  return removed
end

local function mute(playerID, seconds, reason, source, rule, options)
  options = options or {}
  local duration = tonumber(seconds) or cfg.chat.muteSeconds
  local untilEpoch = now() + duration
  stateFor(playerID).mutedUntil = untilEpoch
  setPersistentPunishment(playerID, "mute", untilEpoch, reason)
  if cfg.clientCompanion.resetLockOnMute then triggerCompanion(playerID, untilEpoch, reason) end
  send(playerID, "Chat muted for " .. tostring(duration) .. "s: " .. tostring(reason or "rate limit"))
  recordHistory(playerID, "mute", reason, source)
  audit("mute", {
    playerID = playerID,
    playerName = playerName(playerID),
    reason = reason,
    rule = rule or "mute",
    action = "mute",
    actionSource = source or "automatic",
    seconds = duration,
    score = stateFor(playerID).score,
    historyCount = historyCount(playerID),
    chatMessage = options.chatMessage or ((rule == "chat" or source == "automatic") and recentOffendingChat(playerID) or nil),
    forceDiscord = true,
    suppressDiscord = options.suppressDiscord == true,
  })
end

local function lockSpawn(playerID, seconds, reason, source, rule, options)
  options = options or {}
  local duration = tonumber(seconds) or cfg.vehicleSpawn.lockSeconds
  local untilEpoch = now() + duration
  stateFor(playerID).spawnLockedUntil = untilEpoch
  setPersistentPunishment(playerID, "spawnLock", untilEpoch, reason)
  if cfg.clientCompanion.resetLockOnSpawnLock then triggerCompanion(playerID, untilEpoch, reason) end
  send(playerID, "Vehicle spawning locked for " .. tostring(duration) .. "s: " .. tostring(reason or "rate limit"))
  removePlayerVehiclesOnLock(playerID, reason, source)
  recordHistory(playerID, "spawn_lock", reason, source)
  audit("spawn_lock", {
    playerID = playerID,
    playerName = playerName(playerID),
    reason = reason,
    rule = rule or "spawn_lock",
    action = "spawn_lock",
    actionSource = source or "automatic",
    seconds = duration,
    score = stateFor(playerID).score,
    historyCount = historyCount(playerID),
    chatMessage = options.chatMessage or ((rule == "chat" or source == "automatic") and recentOffendingChat(playerID) or nil),
    suppressDiscord = options.suppressDiscord == true,
  })
end

local function dropPlayer(playerID, reason, source, rule, options)
  options = options or {}
  recordHistory(playerID, "kick", reason, source)
  audit("kick", {
    playerID = playerID,
    playerName = playerName(playerID),
    reason = reason,
    rule = rule or "kick",
    action = "kick",
    actionSource = source or "automatic",
    score = stateFor(playerID).score,
    historyCount = historyCount(playerID),
    chatMessage = options.chatMessage or ((rule == "chat" or source == "automatic") and recentOffendingChat(playerID) or nil),
    forceDiscord = true,
    suppressDiscord = options.suppressDiscord == true,
  })
  if MP and MP.DropPlayer then
    MP.DropPlayer(playerID, reason or "Moderator protection")
    return
  end
  if MP and MP.GetPlayer then
    local ok, player = pcall(MP.GetPlayer, playerID)
    if ok and player and player.kick then player:kick(reason or "Moderator protection") end
  end
end

local function thresholdFor(kind, thresholdName)
  local rule = cfg.abuseScore and cfg.abuseScore.rules and cfg.abuseScore.rules[kind]
  local value = type(rule) == "table" and tonumber(rule[thresholdName]) or nil
  if value ~= nil then return value end
  return tonumber(cfg.abuseScore[thresholdName] or 0) or 0
end

local function inGraceWindow(playerID, score)
  local grace = tonumber(cfg.graceSecondsAfterJoin or 0) or 0
  if grace <= 0 then return false end
  local state = stateFor(playerID)
  local joinedAt = tonumber(state.joinedAt or now())
  if (now() - joinedAt) > grace then return false end
  return score < thresholdFor("default", "kickAt")
end

local function addViolation(playerID, kind, reason, context)
  context = context or {}
  local state = stateFor(playerID)
  if kind == "chat" and context.chatMessage then rememberOffendingChat(playerID, context.chatMessage) end
  decayScore(state)
  state.violations[kind] = tonumber(state.violations[kind] or 0) + 1

  if cfg.abuseScore.enabled then
    local points = tonumber((cfg.abuseScore.points or {})[kind] or 0) or 0
    local repeats = historyCount(playerID)
    if repeats > 0 then
      points = points + (repeats * tonumber(cfg.progressiveHistory.repeatedOffenceBonus or 0))
    end
    state.score = tonumber(state.score or 0) + points
  end

  local score = tonumber(state.score or 0)
  local name = playerName(playerID)
  local coalesce = cfg.discord and cfg.discord.coalesceEscalations == true
  local chain = {}
  local finalAction = "none"
  local graceActive = inGraceWindow(playerID, score)
  local warnAt = thresholdFor(kind, "warnAt")
  local alertAt = thresholdFor(kind, "alertAt")
  local muteAt = thresholdFor(kind, "muteAt")
  local spawnLockAt = thresholdFor(kind, "spawnLockAt")
  local kickAt = thresholdFor(kind, "kickAt")
  local banAt = thresholdFor(kind, "banAt")

  audit("violation", {
    playerID = playerID,
    playerName = name,
    kind = kind,
    rule = kind,
    reason = reason,
    action = "none",
    actionSource = "automatic",
    score = score,
    violations = state.violations[kind],
    historyCount = historyCount(playerID),
    chatMessage = context.chatMessage,
    graceActive = graceActive,
    suppressDiscord = coalesce,
  })

  if cfg.escalation.warnings and score >= warnAt and not state.warned then
    state.warned = true
    send(playerID, "Warning: abuse protection score is high. Slow down.")
    chain[#chain + 1] = "warn"
    finalAction = "warn"
  end

  if cfg.moderatorAlerts.enabled and score >= alertAt then
    local t = now()
    if (t - tonumber(state.lastAdminAlertAt or 0)) >= cfg.moderatorAlerts.minSecondsBetweenAlertsPerPlayer then
      state.lastAdminAlertAt = t
      sendAdmins(name .. " triggered " .. tostring(kind) .. " protection. score=" .. tostring(math.floor(score)))
    end
  end

  if graceActive then
    if #chain > 0 then chain[#chain + 1] = "grace: escalation delayed" end
  elseif cfg.escalation.temporaryMute and score >= muteAt then
    if tonumber(state.mutedUntil or 0) <= now() then
      mute(playerID, cfg.abuseScore.muteSeconds, "abuse score", "automatic", kind, {
        suppressDiscord = coalesce,
        chatMessage = context.chatMessage,
      })
      chain[#chain + 1] = "mute " .. tostring(cfg.abuseScore.muteSeconds) .. "s"
      finalAction = "mute"
    end
  end

  if (not graceActive) and cfg.escalation.spawnLock and score >= spawnLockAt then
    if tonumber(state.spawnLockedUntil or 0) <= now() then
      lockSpawn(playerID, cfg.abuseScore.spawnLockSeconds, "abuse score", "automatic", kind, {
        suppressDiscord = coalesce,
        chatMessage = context.chatMessage,
      })
      chain[#chain + 1] = "spawn lock " .. tostring(cfg.abuseScore.spawnLockSeconds) .. "s"
      finalAction = "spawn_lock"
    end
  end

  if cfg.escalation.persistentBan and score >= banAt then
    banIdentifier(playerID, cfg.abuseScore.banReason, "automatic", "persistent_ban", { suppressDiscord = coalesce })
    chain[#chain + 1] = "ban"
    finalAction = "ban"
    dropPlayer(playerID, cfg.abuseScore.banReason, "automatic", "persistent_ban", {
      suppressDiscord = coalesce,
      chatMessage = context.chatMessage,
    })
  elseif cfg.escalation.kick and score >= kickAt then
    chain[#chain + 1] = "kick"
    finalAction = "kick"
    dropPlayer(playerID, "Kicked by abuse protection", "automatic", kind, {
      suppressDiscord = coalesce,
      chatMessage = context.chatMessage,
    })
  end

  if coalesce and #chain > 0 then
    audit("punishment_summary", {
      playerID = playerID,
      playerName = name,
      kind = kind,
      rule = kind,
      reason = reason,
      action = finalAction,
      actionSource = "automatic",
      score = score,
      violations = state.violations[kind],
      historyCount = historyCount(playerID),
      chain = chain,
      chatMessage = context.chatMessage,
      forceDiscord = true,
    })
  end

  return state.violations[kind], score
end

local function isMuted(playerID)
  local mutedUntil = tonumber(stateFor(playerID).mutedUntil or 0)
  if mutedUntil > 0 and mutedUntil <= now() then clearPersistentPunishment(playerID, "mute") end
  return mutedUntil > now(), mutedUntil
end

local function isSpawnLocked(playerID)
  local lockedUntil = tonumber(stateFor(playerID).spawnLockedUntil or 0)
  if lockedUntil > 0 and lockedUntil <= now() then clearPersistentPunishment(playerID, "spawnLock") end
  return lockedUntil > now(), lockedUntil
end

local function normalizeMessage(message)
  local text = lower(tostring(message or ""))
  text = text:gsub("%p+", "")
  text = text:gsub("%s+", " ")
  text = text:gsub("(.)%1%1+", "%1%1")
  text = text:gsub("^%s+", ""):gsub("%s+$", "")
  return text
end

local function isCapsSpam(message)
  local text = tostring(message or "")
  local letters = 0
  local caps = 0
  for c in text:gmatch("%a") do
    letters = letters + 1
    if c:upper() == c and c:lower() ~= c then caps = caps + 1 end
  end
  return letters >= 12 and (caps / letters) >= 0.8
end

local function isDuplicateSpam(playerID, message)
  local text = normalizeMessage(message)
  if text == "" then return false end
  local state = stateFor(playerID)
  local duplicate = state.duplicateMessages[text]
  if not duplicate then
    duplicate = {}
    state.duplicateMessages[text] = duplicate
  end
  local t = now()
  prune(duplicate, t - cfg.chat.duplicateWindowSeconds)
  duplicate[#duplicate + 1] = t
  return #duplicate > cfg.chat.maxDuplicates
end

local function isAsciiWordChar(value)
  return value ~= nil and value:match("[%w_]") ~= nil
end

local function profanityBoundaryOk(text, startIndex, endIndex)
  local before = startIndex > 1 and text:sub(startIndex - 1, startIndex - 1) or nil
  local after = endIndex < #text and text:sub(endIndex + 1, endIndex + 1) or nil
  return not isAsciiWordChar(before) and not isAsciiWordChar(after)
end

local function profanityPhrases()
  local phrases = {}
  for _, phrase in ipairs((cfg.profanityFilter and cfg.profanityFilter.phrases) or {}) do
    local value = tostring(phrase or "")
    value = value:gsub("^%s+", ""):gsub("%s+$", "")
    if value ~= "" then phrases[#phrases + 1] = value end
  end
  table.sort(phrases, function(a, b) return #a > #b end)
  return phrases
end

local function replacePhraseInsensitive(message, phrase, replacement, wholeWords)
  local text = tostring(message or "")
  local lowerText = lower(text)
  local lowerPhrase = lower(phrase)
  local out = {}
  local pos = 1
  local changed = false

  while pos <= #text do
    local startIndex, endIndex = lowerText:find(lowerPhrase, pos, true)
    if not startIndex then
      out[#out + 1] = text:sub(pos)
      break
    end

    if wholeWords ~= true or profanityBoundaryOk(text, startIndex, endIndex) then
      out[#out + 1] = text:sub(pos, startIndex - 1)
      out[#out + 1] = replacement
      pos = endIndex + 1
      changed = true
    else
      out[#out + 1] = text:sub(pos, startIndex)
      pos = startIndex + 1
    end
  end

  if not changed then return text, false end
  return table.concat(out), true
end

local function filterProfanity(message)
  if not (cfg.profanityFilter and cfg.profanityFilter.enabled) then return tostring(message or ""), false, {} end
  local filtered = tostring(message or "")
  local changed = false
  local matched = {}
  local replacement = tostring(cfg.profanityFilter.replacement or "****")
  for _, phrase in ipairs(profanityPhrases()) do
    local nextFiltered, didReplace = replacePhraseInsensitive(filtered, phrase, replacement, cfg.profanityFilter.wholeWords)
    filtered = nextFiltered
    if didReplace then
      changed = true
      matched[#matched + 1] = phrase
    end
  end
  return filtered, changed, matched
end

local function profanityBypassed(playerID, senderName)
  local filter = cfg.profanityFilter or {}
  if filter.bypassAdmins == true and isAdmin(playerID, senderName) then return true end
  if filter.bypassTrusted == true and isTrusted(playerID, senderName) then return true end
  return false
end

local function broadcastFilteredChat(playerID, senderName, filteredMessage)
  if not (cfg.profanityFilter and cfg.profanityFilter.broadcastFilteredMessage) then return end
  if not (MP and MP.SendChatMessage) then return end
  local format = tostring(cfg.profanityFilter.filteredMessageFormat or "<%name%> %message%")
  local name = tostring(senderName or playerName(playerID))
  local message = tostring(filteredMessage or "")
  local line = format:gsub("%%name%%", name):gsub("%%message%%", message)
  MP.SendChatMessage(-1, line)
end

local function auditProfanityFilter(playerID, senderName, originalMessage, filteredMessage, matchedPhrases)
  if not (cfg.profanityFilter and cfg.profanityFilter.audit) then return end
  local discordMessage = filteredMessage
  if cfg.profanityFilter.discordShowOriginal == true then discordMessage = originalMessage end
  audit("profanity_filter", {
    playerID = playerID,
    playerName = senderName or playerName(playerID),
    reason = "profanity filter",
    rule = "profanityFilter",
    action = "filtered",
    actionSource = "automatic",
    score = stateFor(playerID).score,
    chatMessage = discordMessage,
    filteredMessage = filteredMessage,
    matchedPhrases = matchedPhrases,
    forceDiscord = true,
    bypassDiscordCooldown = true,
  })
end

local function extractVehicleData(data)
  local raw = tostring(data or "")
  if #raw > tonumber(cfg.vehicleRestrictions.maxDataBytes or 0) then return nil, "vehicle data too large" end
  local start = raw:find("{", 1, true)
  if not start then return nil, nil end
  return jsonDecode(raw:sub(start)), nil
end

local function checkVehicleRestrictions(playerID, data)
  if not cfg.vehicleRestrictions.enabled then return false, nil end
  local parsed, err = extractVehicleData(data)
  if err then return true, err end
  if type(parsed) ~= "table" then return false, nil end

  local model = lower(parsed.jbm or (parsed.vcf and parsed.vcf.model) or "")
  for _, blocked in ipairs(cfg.vehicleRestrictions.blockedModels or {}) do
    if model == lower(blocked) then return true, "blocked vehicle model: " .. tostring(blocked) end
  end

  local partConfig = lower(parsed.vcf and parsed.vcf.partConfigFilename or "")
  for _, needle in ipairs(cfg.vehicleRestrictions.blockedPartConfigContains or {}) do
    if partConfig:find(lower(needle), 1, true) then
      return true, "blocked vehicle config: " .. tostring(needle)
    end
  end

  return false, nil
end

local function blockVehicleEvent(playerID, kind, rule, label, data)
  if shouldBypass(playerID, nil) then return 0 end
  if not rule.enabled then return 0 end

  if kind == "vehicleSpawn" then
    local locked, lockedUntil = isSpawnLocked(playerID)
    if locked then
      notifyLimited(playerID, kind .. "Locked", "Vehicle spawning locked for " .. tostring(math.max(1, lockedUntil - now())) .. "s.", 3)
      return 1
    end
  end

  local restricted, reason = checkVehicleRestrictions(playerID, data)
  if restricted then
    addViolation(playerID, "vehicleRestriction", reason)
    send(playerID, reason)
    return 1
  end

  local count = recordWindow(playerID, kind, rule.windowSeconds)
  if count <= rule.maxEvents then
    if cfg.logAllowedEvents then log(label .. " allowed for " .. playerName(playerID) .. " count=" .. tostring(count)) end
    return 0
  end

  local violations = addViolation(playerID, kind, label .. " rate limit")
  notifyLimited(playerID, kind, label .. " rate limit hit. Wait a moment before trying again.", rule.violationCooldownSeconds)
  if kind == "vehicleSpawn" and violations >= 2 then lockSpawn(playerID, rule.lockSeconds, "spawn spam") end
  return 1
end

local function warnOnlyEvent(playerID, kind, rule, label)
  if shouldBypass(playerID, nil) or not rule.enabled then return end
  local count = recordWindow(playerID, kind, rule.windowSeconds)
  if count <= rule.maxEvents then return end
  addViolation(playerID, kind, label .. " spam")
  notifyLimited(playerID, kind, label .. " spam detected. Slow down.", rule.warningCooldownSeconds)
end

local function splitWords(text)
  local words = {}
  for word in tostring(text or ""):gmatch("%S+") do words[#words + 1] = word end
  return words
end

local function findPlayerIdByName(partialName)
  local wanted = lower(partialName)
  if wanted == "" then return nil end
  if MP and MP.GetPlayers then
    local players = MP.GetPlayers() or {}
    for id, name in pairs(players) do if lower(name) == wanted then return tonumber(id) or id end end
    for id, name in pairs(players) do if lower(name):find(wanted, 1, true) then return tonumber(id) or id end end
  end
  return nil
end

local function statusLine()
  local tracked, muted, locked = 0, 0, 0
  for _, state in pairs(playerState) do
    tracked = tracked + 1
    if tonumber(state.mutedUntil or 0) > now() then muted = muted + 1 end
    if tonumber(state.spawnLockedUntil or 0) > now() then locked = locked + 1 end
  end
  return "tracked=" .. tracked .. " muted=" .. muted .. " spawnLocked=" .. locked
end

local function configGet(path)
  local node = cfg
  for part in tostring(path or ""):gmatch("[^%.]+") do
    if type(node) ~= "table" then return nil end
    node = node[part]
  end
  return node
end

local function parseConfigValue(raw)
  local text = tostring(raw or "")
  if text == "true" then return true end
  if text == "false" then return false end
  local n = tonumber(text)
  if n ~= nil then return n end
  return text
end

local function configSet(root, path, value)
  local node = root
  local parts = {}
  for part in tostring(path or ""):gmatch("[^%.]+") do parts[#parts + 1] = part end
  if #parts == 0 then return false end
  for i = 1, #parts - 1 do
    if type(node[parts[i]]) ~= "table" then node[parts[i]] = {} end
    node = node[parts[i]]
  end
  node[parts[#parts]] = value
  return true
end

local function clearHistoryForPlayer(playerID)
  for _, key in ipairs(historyKeysFor(playerID)) do history[key] = nil end
  saveJsonTable(HISTORY_PATH, history)
end

local function inspectPlayer(requesterID, target)
  local state = stateFor(target)
  decayScore(state)
  local mutedFor = math.max(0, tonumber(state.mutedUntil or 0) - now())
  local lockedFor = math.max(0, tonumber(state.spawnLockedUntil or 0) - now())
  local ids = identifierKeys(getIdentifiers(target, playerName(target)))
  send(requesterID, "Inspect " .. playerName(target) .. ": score=" .. tostring(math.floor(tonumber(state.score or 0))) .. " muted=" .. tostring(mutedFor) .. "s spawnLocked=" .. tostring(lockedFor) .. "s history=" .. tostring(historyCount(target)))
  send(requesterID, "Counts: " .. formatCounts(recentCountsFor(target)))
  send(requesterID, "Last chat: " .. truncateDiscord(state.lastOffendingChatMessage or "n/a", 180))
  send(requesterID, "IDs: " .. table.concat(maskedIdentifierList(ids), ", "))
end

local function showHelp(playerID)
  send(playerID, "/mod status | server | reload | sync | discordtest | limits | inspect <player> | forgive <player> | get <path> | set <path> <value> | reset <player> | mute <player> <seconds> | unmute <player> | lockspawn <player> <seconds> | ban <player> | unban <identifier>")
end

local function handleModeratorCommand(playerID, senderName, raw)
  if not isAdmin(playerID, senderName) then send(playerID, "You are not allowed to use moderator commands.") return 1 end

  local args = splitWords(raw)
  local action = lower(args[1] or "help")

  if action == "help" then showHelp(playerID) return 1 end
  if action == "status" then send(playerID, statusLine()) return 1 end
  if action == "server" then
    send(playerID, "server id=" .. tostring(serverIdentity.id) .. " name=" .. tostring(serverIdentity.name) .. " map=" .. tostring(serverIdentity.map) .. " config=" .. tostring(serverIdentity.configPath))
    return 1
  end
  if action == "reload" then
    loadConfig()
    bans = loadJsonTable(BANS_PATH)
    history = loadJsonTable(HISTORY_PATH)
    activePunishments = loadJsonTable(PUNISHMENTS_PATH)
    send(playerID, "Reloaded config, bans, and history. " .. statusLine())
    audit("reload", { playerID = playerID, playerName = senderName, action = "reload", actionSource = playerID == -2 and "console" or "manual" })
    return 1
  end
  if action == "sync" then
    local queueOk, sent, failed = flushCentralQueue()
    local configOk, info = syncCentralConfig()
    send(playerID, "sync queueOk=" .. tostring(queueOk) .. " sent=" .. tostring(sent) .. " failed=" .. tostring(failed) .. " configOk=" .. tostring(configOk) .. " info=" .. tostring(info))
    audit("sync", { playerID = playerID, playerName = senderName, action = "sync", actionSource = playerID == -2 and "console" or "manual", sent = sent, failed = failed, configOk = configOk, info = info })
    return 1
  end
  if action == "discordtest" then
    if not (cfg.discord and cfg.discord.enabled and cfg.discord.useCurl and cfg.discord.webhookUrl ~= "") then
      send(playerID, "Discord disabled. Check discord.enabled, discord.useCurl, and discord.webhookUrl.")
      return 1
    end
    audit("discord_test", {
      playerID = playerID,
      playerName = senderName,
      reason = "manual Discord webhook test",
      rule = "discord",
      action = "discord_test",
      actionSource = playerID == -2 and "console" or "manual",
      score = 0,
      forceDiscord = true,
    })
    send(playerID, "Discord test sent. Check Discord and logs/discord-failures.log if it does not appear.")
    return 1
  end
  if action == "limits" then
    send(playerID, "chat=" .. cfg.chat.maxMessages .. "/" .. cfg.chat.windowSeconds .. "s spawn=" .. cfg.vehicleSpawn.maxEvents .. "/" .. cfg.vehicleSpawn.windowSeconds .. "s edit=" .. cfg.vehicleEdit.maxEvents .. "/" .. cfg.vehicleEdit.windowSeconds .. "s")
    return 1
  end
  if action == "get" then
    local value = configGet(args[2])
    send(playerID, tostring(args[2]) .. "=" .. tostring(value))
    return 1
  end
  if action == "set" then
    if not args[2] or not args[3] then send(playerID, "Usage: /mod set <path> <value>") return 1 end
    local value = parseConfigValue(args[3])
    configSet(runtimeOverrides, args[2], value)
    mergeInto(cfg, runtimeOverrides)
    rebuildLookups()
    saveJsonTable(OVERRIDES_PATH, runtimeOverrides)
    send(playerID, "Set " .. args[2] .. "=" .. tostring(value))
    audit("config_set", { playerID = playerID, playerName = senderName, path = args[2], value = value })
    return 1
  end

  local target = findPlayerIdByName(args[2] or "")
  if action == "inspect" then
    if target == nil then send(playerID, "Player not found.") return 1 end
    inspectPlayer(playerID, target)
    return 1
  end
  if action == "forgive" then
    if target == nil then send(playerID, "Player not found.") return 1 end
    local state = stateFor(target)
    state.score = 0
    state.violations = {}
    state.warned = false
    state.lastDiscordAlertAt = 0
    clearHistoryForPlayer(target)
    send(playerID, "Forgave " .. playerName(target) .. ": score, violations, warning state, and history cleared.")
    audit("forgive", { playerID = playerID, playerName = senderName, targetPlayerID = target, targetPlayerName = playerName(target), action = "forgive", actionSource = playerID == -2 and "console" or "manual" })
    return 1
  end
  if action == "reset" then
    if target == nil then send(playerID, "Player not found.") return 1 end
    playerState[tostring(target)] = nil
    send(playerID, "Reset moderator state for " .. playerName(target) .. ".")
    return 1
  end
  if action == "mute" then
    local seconds = tonumber(args[3] or "")
    if target == nil or not seconds then send(playerID, "Usage: /mod mute <player> <seconds>") return 1 end
    mute(target, seconds, "manual moderator action", playerID == -2 and "console" or "manual", "manual_mute")
    send(playerID, "Muted " .. playerName(target) .. " for " .. tostring(seconds) .. "s.")
    return 1
  end
  if action == "unmute" then
    if target == nil then send(playerID, "Player not found.") return 1 end
    stateFor(target).mutedUntil = 0
    clearPersistentPunishment(target, "mute")
    send(playerID, "Unmuted " .. playerName(target) .. ".")
    return 1
  end
  if action == "lockspawn" then
    local seconds = tonumber(args[3] or "")
    if target == nil or not seconds then send(playerID, "Usage: /mod lockspawn <player> <seconds>") return 1 end
    lockSpawn(target, seconds, "manual moderator action", playerID == -2 and "console" or "manual", "manual_spawn_lock")
    send(playerID, "Spawn locked " .. playerName(target) .. " for " .. tostring(seconds) .. "s.")
    return 1
  end
  if action == "ban" then
    if target == nil then send(playerID, "Player not found.") return 1 end
    if banIdentifier(target, "Manual moderator ban", playerID == -2 and "console" or "manual", "manual_ban") then
      dropPlayer(target, "Banned", playerID == -2 and "console" or "manual", "manual_ban")
      send(playerID, "Banned " .. playerName(target) .. ".")
    else
      send(playerID, "No identifiers available for that player.")
    end
    return 1
  end
  if action == "unban" then
    local ident = tostring(args[2] or "")
    if ident == "" then send(playerID, "Usage: /mod unban <beammp:id|discord:id|ip:addr>") return 1 end
    bans[ident] = nil
    saveJsonTable(BANS_PATH, bans)
    send(playerID, "Removed ban " .. ident)
    return 1
  end

  showHelp(playerID)
  return 1
end

function moderator_onPlayerAuth(playerArg, role, isGuest, identifiers)
  local name = playerArg
  local playerID = nil
  local ids = identifiers

  if type(playerArg) == "table" then
    name = playerArg.name or playerArg.playerName or playerArg.nickname
    playerID = playerArg.playerID or playerArg.id
    ids = playerArg.identifiers
    if (type(ids) ~= "table") and playerID ~= nil then ids = getIdentifiers(playerID, name) end
  elseif type(identifiers) ~= "table" and MP and MP.GetPlayers then
    for id, playerNameValue in pairs(MP.GetPlayers() or {}) do
      if tostring(playerNameValue) == tostring(playerArg) then
        playerID = tonumber(id) or id
        ids = getIdentifiers(playerID, name)
        break
      end
    end
  end

  if type(ids) ~= "table" then ids = {} end
  if name then authByName[lower(name)] = ids end
  if playerID then identifiersByPlayer[tostring(playerID)] = ids end

  local banned, reason = isBannedIdentifiers(ids)
  if banned then return reason or "Banned" end
  return
end

function moderator_onChatMessage(playerID, senderName, message)
  local msg = tostring(message or "")
  local commandArgs = msg:match("^/moderator%s*(.*)$") or msg:match("^/mod%s*(.*)$")
  if commandArgs ~= nil then return handleModeratorCommand(playerID, senderName, commandArgs) end
  if not cfg.chat.enabled then return 0 end

  local muted, mutedUntil = isMuted(playerID)
  if muted then
    notifyLimited(playerID, "chatMuted", "Chat muted for " .. tostring(math.max(1, mutedUntil - now())) .. "s.", 3)
    return 1
  end
  if #msg > cfg.chat.maxLength then
    addViolation(playerID, "chat", "message too long", { chatMessage = msg })
    notifyLimited(playerID, "chatLength", "Message too long.", 3)
    return 1
  end

  local filteredMessage, profanityFiltered, matchedPhrases = filterProfanity(msg)
  local duplicateSpam = isDuplicateSpam(playerID, msg) or isCapsSpam(msg)
  local count = recordWindow(playerID, "chat", cfg.chat.windowSeconds)
  if profanityFiltered and not profanityBypassed(playerID, senderName) then
    if cfg.profanityFilter.addViolation == true then
      addViolation(playerID, "chatProfanity", "profanity filter", { chatMessage = filteredMessage })
    end
    broadcastFilteredChat(playerID, senderName, filteredMessage)
    auditProfanityFilter(playerID, senderName, msg, filteredMessage, matchedPhrases)
    return 1
  end

  if shouldBypass(playerID, senderName) then return 0 end
  if count <= cfg.chat.maxMessages and duplicateSpam ~= true then return 0 end

  local violations = addViolation(playerID, "chat", "chat rate limit", { chatMessage = msg })
  local alreadyMuted = isMuted(playerID)
  if violations >= cfg.chat.muteAfterViolations and not alreadyMuted then
    mute(playerID, cfg.chat.muteSeconds, "chat spam", "automatic", "chat", { chatMessage = msg })
  else
    notifyLimited(playerID, "chat", "Chat rate limit hit. Slow down.", 3)
  end
  return 1
end

function moderator_onVehicleSpawn(playerID, vehicleID, data)
  return blockVehicleEvent(playerID, "vehicleSpawn", cfg.vehicleSpawn, "Vehicle spawn", data)
end

function moderator_onVehicleEdited(playerID, vehicleID, data)
  return blockVehicleEvent(playerID, "vehicleEdit", cfg.vehicleEdit, "Vehicle edit", data)
end

function moderator_onVehicleReset(playerID, vehicleID, data)
  warnOnlyEvent(playerID, "vehicleReset", cfg.vehicleReset, "Vehicle reset")
end

function moderator_onVehicleDeleted(playerID, vehicleID)
  warnOnlyEvent(playerID, "vehicleDelete", cfg.vehicleDelete, "Vehicle delete")
end

function moderator_onPlayerJoin(playerID)
  local name = playerName(playerID)
  stateFor(playerID).joinedAt = now()
  identifiersByPlayer[tostring(playerID)] = getIdentifiers(playerID, name)
  applyPersistentPunishments(playerID)
  local banned, reason = isBannedIdentifiers(identifiersByPlayer[tostring(playerID)])
  if banned then dropPlayer(playerID, reason or "Banned") end
end

function moderator_onPlayerDisconnect(playerID)
  playerState[tostring(playerID)] = nil
  identifiersByPlayer[tostring(playerID)] = nil
end

function moderator_onConsoleInput(input)
  local args = tostring(input or ""):match("^mod%s+(.+)$") or tostring(input or ""):match("^moderator%s+(.+)$")
  if args then handleModeratorCommand(-2, "console", args) return "" end
end

function moderator_onInit()
  ensureDirectory(LOG_DIR)
  loadConfig()
  bans = loadJsonTable(BANS_PATH)
  history = loadJsonTable(HISTORY_PATH)
  activePunishments = loadJsonTable(PUNISHMENTS_PATH)
  log("loaded. " .. statusLine())
end

ensureDirectory(LOG_DIR)
loadConfig()
bans = loadJsonTable(BANS_PATH)
history = loadJsonTable(HISTORY_PATH)
activePunishments = loadJsonTable(PUNISHMENTS_PATH)

MP.RegisterEvent("onInit", "moderator_onInit")
MP.RegisterEvent("onPlayerAuth", "moderator_onPlayerAuth")
MP.RegisterEvent("onChatMessage", "moderator_onChatMessage")
MP.RegisterEvent("onVehicleSpawn", "moderator_onVehicleSpawn")
MP.RegisterEvent("onVehicleEdited", "moderator_onVehicleEdited")
MP.RegisterEvent("onVehicleReset", "moderator_onVehicleReset")
MP.RegisterEvent("onVehicleDeleted", "moderator_onVehicleDeleted")
MP.RegisterEvent("onPlayerJoin", "moderator_onPlayerJoin")
MP.RegisterEvent("onPlayerDisconnect", "moderator_onPlayerDisconnect")
MP.RegisterEvent("onConsoleInput", "moderator_onConsoleInput")

log("server resource loaded")
