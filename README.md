# rules

> 基于域名的网络分流规则列表，适用于 Clash、Surge、Quantumult 等代理工具。

---

## 目录

- [文件说明](#文件说明)
- [使用方式](#使用方式)
- [规则格式](#规则格式)

---

## 文件说明

| 文件          | 用途         | 格式                   |
| ------------- | ------------ | ---------------------- |
| `Direct.list` | 直连域名列表 | `DOMAIN-SUFFIX,domain` |
| `Proxy.list`  | 代理域名列表 | `DOMAIN-SUFFIX,domain` |

---

## 使用方式

将规则文件配置到你的代理工具中。以下以 Clash 为例：

```yaml
rule-providers:
  direct:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/<your-repo>/main/Direct.list"
    path: ./ruleset/direct.yaml
    interval: 86400

  proxy:
    type: http
    behavior: domain
    url: "https://raw.githubusercontent.com/<your-repo>/main/Proxy.list"
    path: ./ruleset/proxy.yaml
    interval: 86400

rules:
  - RULE-SET,direct,DIRECT
  - RULE-SET,proxy,PROXY
```

---

## 规则格式

- **每行一条规则**，`#` 开头的行为注释
- **匹配方式**：使用 `DOMAIN-SUFFIX` 匹配子域名及主域名
- **文件编码**：UTF-8

---
