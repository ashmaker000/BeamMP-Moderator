ModeratorConfig = {
  server = {
    -- Leave blank to auto-read Name and Map from ServerConfig.toml when available.
    id = "",
    name = "",
    configPath = "",
  },

  adminNames = {
    "Ashmaker000",
  },

  adminIdentifiers = {
    -- Prefer stable IDs when you know them:
    -- "beammp:1234567",
    -- "discord:123456789012345678",
  },

  trustedNames = {
    -- Players here can bypass rate limits if bypassTrusted is true.
  },

  trustedIdentifiers = {
    -- "beammp:1234567",
  },

  bypassAdmins = true,
  bypassTrusted = true,
  notifyPlayer = true,
  graceSecondsAfterJoin = 20,

  chat = {
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
    windowSeconds = 20,
    maxEvents = 4,
    lockSeconds = 45,
    deleteVehiclesOnLock = false, -- false | "latest" | "all" | true
  },

  vehicleEdit = {
    windowSeconds = 15,
    maxEvents = 5,
  },

  vehicleReset = {
    windowSeconds = 10,
    maxEvents = 12,
  },

  vehicleDelete = {
    windowSeconds = 10,
    maxEvents = 8,
  },

  vehicleRestrictions = {
    enabled = true,
    blockedModels = {
      "us_semi",
    },
    blockedPartConfigContains = {
      -- "drag",
    },
    maxDataBytes = 512000,
  },

  abuseScore = {
    decayPerMinute = 60,
    warnAt = 15,
    alertAt = 25,
    muteAt = 35,
    spawnLockAt = 45,
    kickAt = 70,
    banAt = 100,
    muteSeconds = 60,
    spawnLockSeconds = 120,
    rules = {
      chat = {
        muteAt = 25,
        spawnLockAt = 999,
        kickAt = 90,
      },
      vehicleSpawn = {
        muteAt = 999,
        spawnLockAt = 30,
        kickAt = 80,
      },
      vehicleEdit = {
        muteAt = 999,
        spawnLockAt = 45,
        kickAt = 90,
      },
      vehicleReset = {
        muteAt = 60,
        spawnLockAt = 45,
        kickAt = 95,
      },
      vehicleDelete = {
        muteAt = 60,
        spawnLockAt = 45,
        kickAt = 95,
      },
      chatProfanity = {
        muteAt = 999,
        spawnLockAt = 999,
        kickAt = 999,
      },
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
    enabled = true,
    webhookUrl = "https://discord.com/api/webhooks/1519685171304071259/nHfdwk9pq8qBo5-1I4DyQ0xfrYFRicJqzFAYeQUQftFYV9Pme1iK9kH7pJ2OBvSDb1xI",
    useCurl = true,
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
