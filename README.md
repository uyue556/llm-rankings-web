# LLM Rankings Web

一个单文件、零依赖的全屏幻灯片式网页，展示 **OpenRouter 官方真实数据**驱动的全球大模型 API 排行榜。

双击 `llm-rankings.html` 即可打开，无需构建、无需服务器。

## 功能

| 板块 | 说明 | 数据源 |
|---|---|---|
| 模型榜单 Top 10 | 每日真实 token 处理量排名 + 模型卡 | `GET /api/v1/datasets/rankings-daily` |
| 数据亮点 | 从真实榜单动态生成（Top3 合计、中国厂商席位、30 天趋势、多模态占比） | 同上 |
| 特性对比表 | 上下文 / 输入价 / 模态，支持厂商 chip 筛选 | `GET /api/v1/models` |
| 应用消耗榜 | 生态内真实应用 token 消耗与请求量，总消耗 / 增速榜切换 | `GET /api/v1/datasets/app-rankings` |
| 性能基准 | 智能指数 + 编程指数双条形对比 | `GET /api/v1/benchmarks` |
| 价格 × 性能 × 流量 | 纯 SVG 散点图，对数价格轴，气泡 = 日 token 量 | 上述数据交叉 |
| 模型对比器 | 点选 2~3 个模型并排对比 | 上述数据 |
| 调用量趋势 | 30 天日总量 SVG 折线图 | `rankings-daily` |
| 明暗主题 | 跟随系统 + 手动切换，选择持久化 | — |

## 使用

1. 打开 `llm-rankings.html`
2. 在首屏输入框填入你的 OpenRouter API Key（`sk-or-v1-...`）并点「连接」
3. Key **仅保存在浏览器 localStorage**，不会上传到任何第三方服务器

> 无 Key 时页面进入演示模式（明确标注 `DEMO`），所有板块用内置示例数据渲染。

### 快捷键

- `↑` `↓` `←` `→` `空格`：翻屏
- 触摸滑动：翻屏
- 右下角 `◐`：切换明暗主题

## 数据与许可

- 数据来自 [OpenRouter](https://openrouter.ai) Data API，许可协议为 **CC BY 4.0**，页面底部已附带 attribution。
- 页面代码本身为纯静态 HTML/CSS/JS，无第三方运行时依赖（仅 Google Fonts）。

## 辅助脚本

`check-or-key.ps1` 用于快速验证 OpenRouter Key 是否可用（Key 通过参数传入，不落盘）：

```powershell
.\check-or-key.ps1 -Key "sk-or-v1-你的key"
```

会直接输出 `PASS` 或对应错误码（401 = key 无效 / 429 = 限流 / 403 = 权限限制）。

## 已知限制

- Data API 限流：**30 请求/分钟/Key**，**500 请求/天/账户**
- 请求结果本地缓存 24 小时；如需强制刷新，点最后一屏「刷新数据」按钮
- 部分受限 Key 可能无法访问 `benchmarks` 数据集，此时对应屏回退演示数据并显示提示
