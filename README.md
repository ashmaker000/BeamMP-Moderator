# BeamMP Moderator

Server-side BeamMP moderation plugin for abuse controls:

- chat spam prevention with duplicate-message detection and temporary mutes
- vehicle spawn/edit rate limiting, blocked with BeamMP cancellable event returns
- reset/delete spam tracking with escalation
- rolling abuse score with decay
- warnings, temporary mutes, temporary spawn locks, kicks, and optional persistent bans
- moderator alerts to online admins
- trusted/admin bypass lists by name or stable identifier
- basic vehicle model/config restrictions
- JSONL audit logging
- optional Discord webhook delivery through `curl`
- optional central moderation API with local queue fallback
- server identity auto-detected from `ServerConfig.toml`
- optional client companion reset lock
- configurable profanity/phrase filter for chat
- live `/mod get`, `/mod set`, `/mod limits`, `/mod reload`, `/mod sync`, `/mod discordtest`, and `/mod server` commands
<img width="418" height="89" alt="Screenshot 2026-06-26 083134" src="https://github.com/user-attachments/assets/51a98204-3f3b-42bf-a5ba-587a0fb788ab" />

<img width="337" height="82" alt="Screenshot 2026-06-26 091449" src="https://github.com/user-attachments/assets/1cd26c0b-3437-4123-8bfe-8cf3ecea4877" />

## Client Companion

The server plugin works without a client mod. The optional client companion can block reset/recover inputs during mutes and spawn locks.

The server sends `moderator_setState` events when a punishment should apply. Players need the client companion installed for input blocking to work; server-side chat/spawn/edit enforcement still works without it.

### Installation

1. **Download the release**

   * Go to the **Releases** page.
   * Download the latest `.zip` file.

2. **Extract the files**

   * Unzip the download.
   * You will get two folders:

     * `Client`
     * `Server`

3. **Install the client files**

   * Open the extracted **Client** folder.
   * Inside it is a `.zip` file.
   * Upload that `.zip` into your server’s **client mods folder**.

4. **Install the server files**

   * Open the extracted **Server** folder.
   * Inside is a folder for the game mode (e.g. `CarHunt`, `Tag`, `PropHunt` etc.).
   * On your server, open the main **server folder**.
   * Create a folder for that game mode (for example: `CarHunt`, `Tag`, `PropHunt`).
   * Copy **all files** from the extracted game mode folder into the matching folder you just created on the server.

5. **Restart the server**

   * Restart your BeamMP server.
   * The game mode should now be active.


## Configure

Edit:

```text
Resources/Server/Moderator/config.lua
```

Important fields:

```lua
server = {
  id = "",
  name = "",
  configPath = "",
}
adminNames = { "Ashmaker000" }
adminIdentifiers = { "beammp:1234567" }
trustedNames = {}
trustedIdentifiers = {}
discord = {
  enabled = true,
  webhookUrl = "",
  useCurl = true,
}
centralApi = {
  enabled = false,
  baseUrl = "",
  apiKey = "",
  useCurl = false,
}
```

When `server.id` and `server.name` are blank, the plugin tries to read common BeamMP `ServerConfig.toml` paths and uses the configured server name/map in logs and Discord alerts.

Prefer identifiers for long-term admin/trusted/banned users because player names can change. The plugin accepts keys such as:

```text
beammp:1234567
discord:123456789012345678
ip:127.0.0.1
```

## Commands

Admins can use:

```text
/mod status
/mod server
/mod reload
/mod sync
/mod discordtest
/mod limits
/mod inspect <player>
/mod forgive <player>
/mod get <path>
/mod set <path> <value>
/mod reset <player>
/mod mute <player> <seconds>
/mod unmute <player>
/mod lockspawn <player> <seconds>
/mod ban <player>
/mod unban <beammp:id|discord:id|ip:addr>
```

The server console can use the same commands without the slash:

```text
mod status
mod server
mod sync
mod discordtest
mod set chat.maxMessages 8
mod lockspawn SomePlayer 60
```

Live `/mod set` changes are written to:

```text
Resources/Server/Moderator/config_overrides.json
```

That file is loaded after `config.lua`, so live overrides survive restarts.

## Logging

Audit logs are appeal-safe JSON lines. Kick/ban/mute records include server ID, timestamp, player name, identifiers, exact rule/action/source, recent event counts, and abuse score:

```text
Resources/Server/Moderator/logs/moderator-YYYY-MM-DD.jsonl
```

Persistent bans are written to:

```text
Resources/Server/Moderator/bans.json
```

Progressive punishment history is written to:

```text
Resources/Server/Moderator/history.json
```

If central API delivery fails, events are queued locally:

```text
Resources/Server/Moderator/central_queue.jsonl
```

## Discord

BeamMP's documented server Lua API does not expose a native HTTP client. Discord delivery is therefore optional and uses the server's `curl` command when enabled:

```lua
discord = {
  enabled = true,
  webhookUrl = "https://discord.com/api/webhooks/...",
  useCurl = true,
  minScoreToSend = 25,
  sendEveryMute = true,
  sendEveryKickBan = true,
  sendViolationEvents = false,
  coalesceEscalations = true,
}
```

Every mute is sent when `sendEveryMute = true`, even if its abuse score is below `minScoreToSend`. Alerts are sent as Discord embeds with server, player, score, rule, source, identifiers, recent counts, and the in-game chat message for chat violations. Chat-triggered mutes, spawn locks, and kicks inherit the same message. BeamNG color codes such as `^l^d` are stripped before posting.

By default, `coalesceEscalations = true` sends one summary embed when a single offence causes multiple automatic actions, such as mute, spawn lock, and kick. Set `sendViolationEvents = true` only if you also want raw violation embeds. If `curl` is not available, JSONL logging still records the events.

Use this after adding a webhook:

```text
/mod discordtest
```

If the message does not appear, check `Resources/Server/Moderator/logs/discord-failures.log`.

## Spawn Locks

Spawn locks always block new vehicle spawns while active. You can also remove the player's existing vehicles when the lock is applied:

```lua
vehicleSpawn = {
  lockSeconds = 45,
  deleteVehiclesOnLock = "latest",
}
```

Use `false` to only block future spawns, `"latest"` to remove the newest vehicle, or `"all"` to remove every current vehicle. `true` is treated as `"all"` for older configs.

## Tuning

Useful moderation tuning options:

```lua
graceSecondsAfterJoin = 20

discord = {
  minSecondsBetweenPlayerAlerts = 60,
  maskIps = true,
}

abuseScore = {
  rules = {
    chat = { muteAt = 25, kickAt = 90 },
    vehicleSpawn = { spawnLockAt = 30, kickAt = 80 },
  }
}
```

## Profanity Filter

BeamMP chat events are cancellable, but the server API does not expose a documented way to return a modified message. This plugin filters chat by cancelling the original message and re-sending a sanitized server-side replacement.

```lua
profanityFilter = {
  enabled = true,
  replacement = "****",
  wholeWords = true,
  phrases = {
    "bad word",
    "blocked phrase",
  },
  filteredMessageFormat = "<%name%> %message%",
  audit = true,
  addViolation = false,
  discordShowOriginal = false,
}
```

Set `addViolation = true` if profanity should add abuse score and participate in escalation. By default, Discord receives the filtered message, not the original text. Profanity filter audits force a Discord alert and include the matched phrase.

Phrase entries must be quoted Lua strings. For example, use `"blocked phrase"`, not `blocked phrase`.

Active mutes and spawn locks persist by identifier in:

```text
Resources/Server/Moderator/punishments.json
```

Player-facing moderator messages use BeamNG color codes for a yellow `[Moderator]` prefix. Abuse scores are kept in logs and Discord alerts, not shown in-game.

## Central API

Optional cross-server sync is configured under `centralApi`. The plugin posts every audit event to:

```text
POST /events
```

`/mod sync` flushes queued events and pulls server config from:

```text
GET /config/:serverId
```

See [CENTRAL_API.md](CENTRAL_API.md) for the concrete API contract.

## Event Limits

BeamMP marks `onChatMessage`, `onVehicleSpawn`, and `onVehicleEdited` as cancellable, so this plugin blocks those by returning `1`. BeamMP marks `onVehicleReset` and `onVehicleDeleted` as non-cancellable, so this plugin cannot stop the event itself; it warns, logs, alerts moderators, and escalates with mute/spawn lock/kick/optional ban.
