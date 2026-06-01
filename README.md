# remotion-zh

[Remotion](https://www.remotion.dev/) 中文导航。把官方仓库的 22 个模板、resources.mdx 里 90 个第三方项目、以及 Showcase 上能追溯到源码的 33 个 Mux 案例汇到一张静态 HTML，按中文用途归档，可视化预览。

在线版：<https://aguaishuo.github.io/remotion-zh/>

[![预览](_screenshots/preview-hero.png)](https://aguaishuo.github.io/remotion-zh/)

## 为什么做这个

Remotion 自己的 [resources.mdx](https://github.com/remotion-dev/remotion/blob/main/packages/docs/docs/resources.mdx) 是一长串 Markdown 链接，要点开仓库才知道做什么。Showcase 页都是闭源商业案例，看了找不到对应源码。

这个仓库做了三件事：

- 给每个项目起一个中文用途名（"音频波形播客-audiogram"），从名字就能猜功能
- 把 Showcase 那 79 个案例里**真能拿到源码的 33 个**挑出来：12 个本地有源码、21 个有功能等价的开源平替；剩下 46 个商业闭源无平替的就不收了，留着也没用
- 用一张单页 HTML 把所有卡片排出来，离线打开预览首页.html 也能用

## 使用

直接浏览：<https://aguaishuo.github.io/remotion-zh/>

本地拿源码：

```bash
git clone https://github.com/aguaishuo/remotion-zh
cd remotion-zh

./scripts/fetch-all.sh         # 全量克隆 90+22，约 5-10 GB
./scripts/fetch-tier1.sh       # 只拿 Claude Code + 组件库 5 个
./scripts/fetch-tier2.sh       # 只拿 AI 短视频管线 5 个

open 预览首页.html
```

仓库本身 11 MB，把案例源码摘出来用 fetch 脚本运行时再 clone。

## 目录结构

```
remotion-zh/
├── 预览首页.html / index.html   单页预览（在线/本地双模式自动切换）
├── data/                         JSON 元数据
│   ├── 模板列表.json
│   ├── 案例列表.json             90 个第三方仓库 owner/repo/分类
│   ├── showcase数据源.json
│   ├── Mux匹配本地源码.json      12 个
│   ├── Mux开源平替.json          21 个
│   └── Remotion官方资源页_resources.mdx
├── _社交卡缓存/                  112 张 GitHub 仓库缩略图
└── scripts/                      fetch / refresh 脚本
```

## 案例分类

`data/案例列表.json` 里 90 个第三方仓库按用途分了 13 类：

| 类别 | 数量 |
|---|---|
| 转场/动效 | 17 |
| 数据可视化 | 9 |
| AI 短视频管线 | 8 |
| 音频/字幕 | 7 |
| GitHub 主题 | 7 |
| 3D/Three.js | 6 |
| 集成/部署 | 4 |
| Remotion 官方 | 4 |
| 视频编辑器 | 3 |
| 组件库 | 3 |
| 视频排版 | 2 |
| Claude/AI 工具 | 2 |
| 其他/工具 | 18 |

## 2026 年补充的 10 个高星仓库

`topic:remotion stars:>50 pushed:>2024-01-01` 抓的，分两批：

Claude Code + 组件库类：
- [claude-code-video-toolkit](https://github.com/digitalsamba/claude-code-video-toolkit) (1.3k)
- [remotion-bits](https://github.com/av/remotion-bits) (359)
- [remotion-animated](https://github.com/stefanwittwer/remotion-animated) (211)
- [claude-remotion-kickstart](https://github.com/jhartquist/claude-remotion-kickstart) (101)
- [clippkit](https://github.com/reactvideoeditor/clippkit) (62)

AI 短视频管线类：
- [short-video-maker](https://github.com/gyoridavid/short-video-maker) (1.2k)
- [brainrot.js](https://github.com/noahgsolomon/brainrot.js) (955)
- [jiang-clips](https://github.com/ayush-that/jiang-clips) (299)
- [OpenReels](https://github.com/tsensei/OpenReels) (104)
- [TikTok-Forge](https://github.com/ezedinff/TikTok-Forge) (78)

## License

仓库代码（预览页、JSON、中文翻译、fetch 脚本）MIT。

第三方仓库源码归各自原作者所有，fetch 脚本运行时才克隆下来，请遵守各仓库自身的 LICENSE。Mux 视频流远程引用自 remotion.dev/showcase，社交卡来自 GitHub opengraph 公开 API。

## 反馈

Issue 或 PR：<https://github.com/aguaishuo/remotion-zh/issues>
