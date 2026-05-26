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


## 贡献指南

提交规则时请注意：

- **保持文件名和格式不变**，使用精准编辑，避免重写整个文件
- **提交信息简洁明了**，例如：`Add domain xxx to Proxy.list`
- **批量添加时须说明来源或原因**

---

## 验证

使用以下命令快速检查规则文件的完整性：

```bash
# 检查文件是否存在且非空
[ -s Direct.list ] && [ -s Proxy.list ]

# 查看行数统计
wc -l Direct.list Proxy.list

# 预览文件内容
head -n 10 Direct.list
```