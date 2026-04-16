# flutter-golden-cycle

> **将视觉输出作为测试契约一部分的 Flutter 开发循环。**
> Golden 测试 TDD · 每 worktree 确定性 Web 端口 · 组件复用纪律 · 基于 Figma 的视觉审查。

**语言:** [English](README.md) · [한국어](README.ko.md) · [Español](README.es.md) · **简体中文**

---

## 为什么

UI 质量门(goldens、视觉审查、设计系统复用)不是可选的抛光 — 它们是 RED/GREEN 的组成部分。大多数 Flutter 工作流因为工具摩擦而跳过这些步骤。本插件把它们变成**默认路径**。

## 提供什么

- **Golden 测试 TDD**  `/flutter-golden-cycle-baseline` 在 AI 和用户双重审批门之后才允许提交基线,避免盲跑 `flutter test --update-goldens`。
- **每 worktree 确定性端口**  相同 worktree 名总是映射到相同的 `--web-port`。并行分支不再在 8080 端口冲突。
- **复用优先**  工作流会先在设计系统包和 Material 3 基线中搜索,再允许手写 `Container + GestureDetector`。
- **Figma 视觉审查**  给出 Figma URL 后,插件会将设计(截图 + tokens + 上下文)冻结到 `.figma-refs/`,然后用并排 checklist 与渲染出的 goldens 比对。
- **自检**  `/flutter-golden-cycle-doctor` 在 1 秒内告诉你安装是否健康。

## 快速开始

```bash
/plugin marketplace add happinessee/flutter-golden-cycle
/plugin install flutter-golden-cycle
/flutter-golden-cycle-init
/flutter-golden-cycle-doctor
/flutter-golden-cycle
```

手动安装见 [`docs/INSTALL.md`](docs/INSTALL.md)。

## 要求

- Flutter SDK ≥ `3.16.0`
- Git ≥ `2.5`
- macOS / Linux / Windows (PowerShell 或 WSL)

**可选 peer 插件:**
- `figma`  启用 Figma 视觉审查阶段。未安装时该阶段会被跳过。
- `superpowers` bundle  本 skill 已内联所需模式(git worktree、TDD、验证、code review),所以 superpowers **不是必需的**。

## 状态

**v0.1 — MVP.** 仅支持手动 issue 输入 (Linear/GitHub 适配器将在 v0.2 中加入)。见 [`CHANGELOG.md`](CHANGELOG.md)。

详细文档请参考英文 [`README.md`](README.md) 与 [`docs/`](docs/)。

## 许可证

MIT — 见 [`LICENSE`](LICENSE)。
