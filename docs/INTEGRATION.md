# Integration Guide

## Clash (Meta / Premium)

Use `rule-providers` to fetch rules remotely. Recommended for all Clash-based clients.

```yaml
rule-providers:
  direct:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/ifourx/rules/main/Direct.list"
    path: ./ruleset/direct.yaml
    interval: 86400

  proxy:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/ifourx/rules/main/Proxy.list"
    path: ./ruleset/proxy.yaml
    interval: 86400

rules:
  - RULE-SET,direct,DIRECT
  - RULE-SET,proxy,Proxy
  - MATCH,DIRECT        # fallback
```

- `behavior: domain` maps directly to `DOMAIN-SUFFIX` semantics
- `interval: 86400` refreshes once daily
- Place rule-sets **before** the `MATCH` catch-all

### Local File Fallback

If GitHub is unreachable, copy files locally and reference by path:

```yaml
rule-providers:
  direct:
    type: file
    behavior: domain
    path: ./ruleset/Direct.list
```

---

## Surge

Surge uses `RULE-SET` directives. Place files in the same directory as your main config.

```
[Rule]
RULE-SET,Direct.list,DIRECT
RULE-SET,Proxy.list,PROXY
FINAL,DIRECT
```

- Download `Direct.list` / `Proxy.list` to Surge's config directory
- Rule-set evaluation order matters — direct rules first, then proxy, then FINAL
- Refresh by tapping **Reload Profile** in Surge

---

## Quantumult X

Quantumult X uses `[filter_remote]` for remotely hosted rule sets.

```
[filter_remote]
https://raw.githubusercontent.com/ifourx/rules/main/Direct.list, tag=Direct, update-interval=86400, opt-parser=false, enabled=true
https://raw.githubusercontent.com/ifourx/rules/main/Proxy.list, tag=Proxy, update-interval=86400, opt-parser=false, enabled=true
```

Or with local files under `Quantumult X/Profiles/`:

```
[filter_local]
rule-set,Direct.list,DIRECT
rule-set,Proxy.list,PROXY
```

---

## Loon

```
[Remote Rule]
https://raw.githubusercontent.com/ifourx/rules/main/Direct.list, policy=DIRECT, update-interval=86400
https://raw.githubusercontent.com/ifourx/rules/main/Proxy.list, policy=PROXY, update-interval=86400
```

---

## Stash (iOS)

Stash shares Clash's configuration format. Follow the [Clash guide](#clash-meta--premium) above.

---

## Shadowrocket

```
[Rule]
RULE-SET,https://raw.githubusercontent.com/ifourx/rules/main/Direct.list,DIRECT
RULE-SET,https://raw.githubusercontent.com/ifourx/rules/main/Proxy.list,PROXY
```

---

## Notes

- All tools treat `DOMAIN-SUFFIX,example.com` as matching `example.com` **and** `sub.example.com`
- Rule order: **direct rules first, proxy rules second, catch-all last** — prevents accidental proxy routing of direct domains
- Daily refresh (`86400` seconds) balances freshness and bandwidth — adjust if you need faster updates
