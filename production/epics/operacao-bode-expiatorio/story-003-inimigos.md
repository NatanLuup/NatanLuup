# Story 003: Dois tipos de inimigo com mortes exageradas

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Core
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 3

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 3 ("2 tipos de inimigo com mortes exageradas") and Core loop ("Derrubar ondas de inimigos"):*

- [ ] Inimigo tipo 1 (soldado a pé): anda até o jogador mais próximo e atira
- [ ] Inimigo tipo 2 (diferente no comportamento, ex.: atirador parado ou lançador de granada)
- [ ] Inimigos têm vida; tiros do jogador causam dano e zeram a vida
- [ ] Tiros inimigos causam dano no jogador
- [ ] Ao morrer, o inimigo tem uma morte exagerada (voa longe, explode, etc.)
- [ ] Vida, dano, velocidade e cadência de cada inimigo vêm de arquivo de dados
- [ ] Com dois jogadores online, inimigos e mortes aparecem iguais nas duas telas

---

## Implementation Notes

- A lógica de vida e dano deve ser testável sem a cena (injeção de dependência, sem singletons)

---

## Out of Scope

- Story 004: o que acontece quando a vida do jogador zera
- Story 006: o chefe

---

## Files

- `src/gameplay/enemies/enemy_base.gd`, `src/gameplay/enemies/soldier.tscn`, `src/gameplay/enemies/<tipo2>.tscn`
- `src/gameplay/combat/health.gd`
- `assets/data/enemies.json`
- `tests/unit/enemies/inimigos_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Logic
**Required evidence**: `tests/unit/enemies/inimigos_test.gd` (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-001-correr-pular-atirar.md`, `production/epics/operacao-bode-expiatorio/story-002-coop-online.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-004-reviver.md`, `production/epics/operacao-bode-expiatorio/story-005-fase.md`
