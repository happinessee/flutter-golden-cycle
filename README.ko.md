# flutter-golden-cycle

> **시각 출력을 테스트 계약의 일부로 취급하는 Flutter 개발 사이클.**
> 골든 테스트 TDD · 워크트리별 결정론적 웹 포트 · 컴포넌트 재사용 규율 · Figma 기반 비주얼 리뷰.

**언어:** [English](README.md) · **한국어** · [Español](README.es.md) · [简体中文](README.zh.md)

---

## 왜 필요한가

UI 품질 게이트(골든, 시각 리뷰, 디자인 시스템 재사용)는 선택적 마감이 아니라 RED/GREEN의 일부입니다. 대부분의 Flutter 워크플로는 툴링 마찰 때문에 이 단계를 건너뜁니다. 이 플러그인은 그것을 **기본 경로**로 만듭니다.

## 제공하는 것

- **골든 테스트 TDD** — `/flutter-golden-cycle-baseline`이 `flutter test --update-goldens`를 감싸 AI + 사용자 이중 승인 게이트를 거친 뒤에만 베이스라인이 커밋됩니다.
- **워크트리당 결정론적 포트** — 같은 워크트리 이름은 항상 같은 `--web-port`로 매핑. 병렬 브랜치가 8080 포트를 두고 충돌하지 않습니다.
- **재사용 우선 설계** — 디자인 시스템 패키지와 Material 3 베이스라인을 먼저 탐색한 후에야 커스텀 위젯을 허용합니다.
- **Figma 비주얼 리뷰** — Figma URL을 주면 스크린샷·토큰·컨텍스트를 `.figma-refs/`에 박제하고, 렌더된 골든과 사이드-바이-사이드 체크리스트로 비교합니다.
- **self-check** — `/flutter-golden-cycle-doctor`가 설치 상태를 1초 안에 알려줍니다.

## 빠른 시작

```bash
/plugin marketplace add happinessee/flutter-golden-cycle
/plugin install flutter-golden-cycle
/flutter-golden-cycle-init
/flutter-golden-cycle-doctor
/flutter-golden-cycle
```

수동 설치는 [`docs/INSTALL.md`](docs/INSTALL.md) 참고.

## 요구 사항

- Flutter SDK ≥ `3.16.0`
- Git ≥ `2.5`
- macOS / Linux / Windows (PowerShell 또는 WSL)

**선택적 피어 플러그인:**
- `figma` — Figma 비주얼 리뷰 단계를 활성화. 없으면 해당 단계만 스킵됩니다.
- `superpowers` 번들 — 이 스킬은 필요한 패턴(git worktree, TDD, 검증, 코드 리뷰)을 내부에 인라인했으므로 superpowers는 **필수가 아닙니다**.

## 상태

**v0.1 — MVP.** 이슈 소스는 수동 입력만 지원 (Linear/GitHub 어댑터는 v0.2). [`CHANGELOG.md`](CHANGELOG.md) 참고.

상세 문서는 영문 [`README.md`](README.md) 및 [`docs/`](docs/)를 참고하세요.

## 라이선스

MIT — [`LICENSE`](LICENSE) 참고.
