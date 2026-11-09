# Story 006: Chefe simples

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Feature
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 6

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 6 ("Um chefe simples") and Player goal ("vencer o chefe e soltar o bode"):*

- [ ] O chefe aparece na área final da base, guardando a jaula do bode
- [ ] Tem uma barra de vida visível e bem mais vida que os inimigos comuns
- [ ] Alterna entre pelo menos 2 ataques com padrão que dá para aprender
- [ ] Os jogadores podem cair e se reviver durante a luta (story 004)
- [ ] Ao zerar a vida, o chefe tem uma morte exagerada e libera o acesso à jaula
- [ ] Vida, dano e tempos dos ataques vêm de arquivo de dados
- [ ] A luta acontece igual nas duas telas online

---

## Implementation Notes

- A troca de ataques é uma máquina de estados testável sem cena

---

## Out of Scope

- Story 007: abrir a jaula e a tela de vitória

---

## Files

- `src/gameplay/enemies/boss.gd`, `src/gameplay/enemies/boss.tscn`
- `assets/data/boss.json`
- `tests/unit/boss/chefe_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Logic
**Required evidence**: `tests/unit/boss/chefe_test.gd` (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-005-fase.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-007-resgate-telas.md`
