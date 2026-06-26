# Central Moderation API Contract

The BeamMP plugin works without this service. When enabled, the service becomes the cross-server source of truth for events and remote config.

## Authentication

If `centralApi.apiKey` is set, the plugin sends:

```text
Authorization: Bearer <apiKey>
```

## POST /events

Receives every audit event.

Example payload:

```json
{
  "time": "2026-06-25T12:00:00Z",
  "event": "mute",
  "mod": "Moderator",
  "server": {
    "id": "west-coast-rp-1",
    "name": "West Coast RP #1",
    "map": "/levels/west_coast_usa/info.json"
  },
  "playerID": 2,
  "playerName": "PlayerX",
  "identifiers": {
    "keys": ["beammp:1234567", "ip:127.0.0.1"]
  },
  "rule": "chat",
  "action": "mute",
  "actionSource": "automatic",
  "reason": "abuse score",
  "recentCounts": {
    "chat": 7,
    "vehicleSpawn": 5
  },
  "score": 43,
  "historyCount": 2
}
```

Expected response:

```json
{ "ok": true }
```

## GET /config/:serverId

Returns config overrides for one server.

Example response:

```json
{
  "chat": {
    "maxMessages": 6
  },
  "abuseScore": {
    "kickAt": 80
  },
  "discord": {
    "minScoreToSend": 20
  }
}
```

The plugin merges this over local config, then reapplies local live overrides from `config_overrides.json`.

## Recommended Future Endpoints

```text
GET /players/:identifier/status
POST /actions/ban
POST /actions/mute
POST /actions/unban
POST /actions/unmute
GET /servers
GET /events?identifier=<id>
```

Those endpoints are not required by the current plugin, but they are the natural next step for a dashboard.

## Discord Bot Actions

Webhook messages cannot include working moderation buttons. A separate Discord bot can implement buttons by calling moderation API endpoints such as:

```text
POST /actions/unmute
POST /actions/ban
POST /actions/forgive
GET /players/:identifier/status
POST /trusted
```

The webhook embed already includes identifiers needed for those actions.
