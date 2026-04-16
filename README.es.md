# flutter-golden-cycle

> **Ciclo de desarrollo Flutter que trata el resultado visual como parte del contrato de pruebas.**
> TDD con golden tests · puertos web deterministas por worktree · disciplina de reutilización de componentes · revisión visual basada en Figma.

**Idioma:** [English](README.md) · [한국어](README.ko.md) · **Español** · [简体中文](README.zh.md)

---

## Por qué

Las puertas de calidad de UI (goldens, revisión visual, reutilización del design system) no son un pulido opcional — son parte del RED/GREEN. La mayoría de los flujos Flutter las omiten por fricción de herramientas. Este plugin las convierte en el **camino por defecto**.

## Qué ofrece

- **TDD con goldens.** `/flutter-golden-cycle-baseline` envuelve `flutter test --update-goldens` en una puerta de doble aprobación (la IA lee el PNG, el usuario aprueba) antes de comitear las líneas base.
- **Puerto determinista por worktree.** El mismo nombre de worktree produce siempre el mismo `--web-port`. Las ramas paralelas dejan de colisionar en el puerto 8080.
- **Descubrimiento de reutilización primero.** El flujo busca en tu paquete de design system y en los widgets Material 3 **antes** de permitirte construir un `Container + GestureDetector` a mano.
- **Revisión visual con Figma.** Si das una URL de Figma, el plugin congela el diseño (captura + tokens + contexto) en `.figma-refs/` y ejecuta un checklist lado a lado contra tus goldens renderizados.
- **Auto-diagnóstico.** `/flutter-golden-cycle-doctor` te dice en un segundo si la instalación está sana.

## Inicio rápido

```bash
/plugin marketplace add happinessee/flutter-golden-cycle
/plugin install flutter-golden-cycle
/flutter-golden-cycle-init
/flutter-golden-cycle-doctor
/flutter-golden-cycle
```

Para instalación manual, ver [`docs/INSTALL.md`](docs/INSTALL.md).

## Requisitos

- Flutter SDK ≥ `3.16.0`
- Git ≥ `2.5`
- macOS, Linux o Windows (PowerShell o WSL)

**Plugins peer opcionales:**
- `figma` — habilita la fase de revisión visual. Sin él, esa fase se omite.
- Bundle `superpowers` — este skill integra los patrones que necesita (git worktree, TDD, verificación, code review), así que `superpowers` **no es obligatorio**.

## Estado

**v0.1 — MVP.** Solo fuente de issues manual (adaptadores de Linear/GitHub en v0.2). Ver [`CHANGELOG.md`](CHANGELOG.md).

Para documentación detallada, ver [`README.md`](README.md) en inglés y [`docs/`](docs/).

## Licencia

MIT — ver [`LICENSE`](LICENSE).
