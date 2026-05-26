# rules

[![AI Ready](https://img.shields.io/badge/AI--Ready-yes-brightgreen?style=flat)](https://github.com/johnpapa/ai-ready)

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

## 贡献指南

欢迎贡献新的域名规则！请遵循以下步骤：

1. **Fork** 本仓库
2. **创建分支**：`git checkout -b feat/add-domains`
3. **编辑规则文件**：
   - 直连域名添加到 `Direct.list`
   - 代理域名添加到 `Proxy.list`
4. **确保格式正确**：每行一条 `DOMAIN-SUFFIX,domain` 规则，按字母顺序排列
5. **检查重复**：确保同一域名不会同时出现在两个文件中
6. **提交并推送**：`git commit -m "feat: add some domains"` && `git push origin feat/add-domains`
7. **创建 Pull Request**

### Pull Request 要求

- 域名按字母顺序排列
- 无重复条目
- 格式为 `DOMAIN-SUFFIX,domain`（每行一条）
- 如有必要，更新 `CHANGELOG.md`

---
