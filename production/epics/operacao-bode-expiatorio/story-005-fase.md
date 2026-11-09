# Story 005: Fase curta e linear até a base

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Feature
> **Type**: Integration
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 5

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 5 ("Uma fase curta e linear terminando na base") and Core loop ("Chegar ao próximo trecho, mais difícil, até a jaula do bode"):*

- [ ] Uma fase com rolagem lateral, da esquerda para a direita, com plataformas
- [ ] A câmera acompanha os dois jogadores e não deixa nenhum sair da tela
- [ ] Inimigos aparecem em ondas ao longo da fase, cada trecho mais difícil que o anterior
- [ ] O fim da fase leva à área do chefe, na base inimiga
- [ ] Uma partida completa dura por volta de 15 minutos ou menos (brief: "sessão de 15 minutos")
- [ ] Jogada online do começo ao fim por 2 jogadores; resultado registrado como playtest

---

## Implementation Notes

- Posições e composição das ondas em arquivo de dados, não fixas no código

---

## Out of Scope

- Mais de uma fase (fora do escopo do brief)
- Story 006: o chefe

---

## Files

- `src/levels/level_01.tscn`
- `src/gameplay/spawning/wave_spawner.gd`
- `src/gameplay/camera/coop_camera.gd`
- `assets/data/level_01_waves.json`
- `production/qa/playtest-fase-01.md`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Integration
**Required evidence**: `tests/integration/level/fase_test.gd` OR playtest doc (tests advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-003-inimigos.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-006-chefe.md`
