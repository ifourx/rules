# Domain Categorization Methodology

## Principles

| Principle | Description |
|-----------|-------------|
| **Accessibility** | Domain is proxied only if it is inaccessible or degraded over a direct connection |
| **Performance** | Domains that perform better through the proxy are proxied; CDN-heavy domains stay direct |
| **Neutrality** | No political or censorship bias — categorization is based purely on reachability |

---

## Categorization Criteria

### → Proxy.list (Route through proxy)

Apply any of these checks. A domain qualifies if **one or more** conditions are met:

- **Geo-restricted** — service blocks access from certain regions (e.g., streaming, social media)
- **Throttled** — consistently slow or high-latency over direct connection
- **CDN routing** — the CDN edge selected by direct DNS resolution is suboptimal (confirmed via `curl -v` or `dig`)
- **Dependency** — domain hosts resources (APIs, assets) required by an already-proxied service

### → Direct.list (Bypass proxy)

A domain qualifies if **all** of the following are true:

- **Locally reachable** — HTTP 200 / TCP connect succeeds from the target region
- **Adequate performance** — latency and throughput meet baseline expectations
- **Not a proxy dependency** — the domain does not serve resources for a proxied service

---

## Research Process

When evaluating a new domain:

```
1. Resolve DNS
   └─ dig <domain> +short
      ├─ Local IP range?  →  Direct
      └─ Foreign IP?      →  Continue

2. Test connectivity
   └─ curl -o /dev/null -s -w "%{http_code} %{time_total}" <url>
      ├─ HTTP 2xx / 3xx, < 1 s  →  Candidate for Direct
      ├─ Timeout or > 3 s        →  Candidate for Proxy
      └─ Connection refused      →  Verify DNS / region

3. Verify with proxy on
   └─ curl --proxy <proxy> -o /dev/null -s -w "%{http_code} %{time_total}" <url>
      ├─ Faster than direct?     →  Proxy.list
      └─ Slower or same?        →  Direct.list

4. Cross-check dependencies
   └─ Check if domain hosts assets for a proxied service (e.g., CDN for a blocked site)
      ├─ Yes, and serves proxied content  →  Proxy.list
      └─ No  →  Decision from step 3 stands
```

### Tools

- `dig` / `nslookup` — DNS resolution & IP geolocation
- `curl` — HTTP latency and status code check
- `mtr` / `traceroute` — path inspection
- `whois` — registrar / hosting provider identification
- Browser DevTools (Network tab) — resource dependency mapping

---

## Edge Cases

| Scenario | Resolution |
|----------|------------|
| Domain serves mixed content (local + global) | Proxy unless the global content is negligible |
| API endpoint behind a CDN | Check CDN edge assignment; if poorly routed, proxy |
| Subdomain vs. root domain behave differently | Add individual subdomains; use `DOMAIN-SUFFIX` on the more specific name |
| Wildcard subdomains under a proxied root | Already covered by `DOMAIN-SUFFIX` on the root |
| Domain resolves to multiple IPs (geo-aware DNS) | Test from the primary target region; note the region in a comment |
