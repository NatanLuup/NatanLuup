# Story 007: Resgate do bode e telas de vitória e derrota

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Presentation
> **Type**: UI
> **Estimate**: S
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 7

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 7 ("Resgate do bode e telas de vitória e derrota") and Player goal & fail state:*

- [ ] Com o chefe derrotado, um jogador chega na jaula e solta o bode
- [ ] Soltar o bode mostra a tela de vitória nas duas telas online
- [ ] Quando os dois jogadores estão caídos ao mesmo tempo (sinal da story 004), aparece a tela de derrota nas duas telas
- [ ] As duas telas oferecem "Jogar de novo" e "Sair", navegáveis pelo direcional do gamepad e pelo teclado
- [ ] Textos das telas prontos para tradução (sem texto fixo no código)
- [ ] Screenshot de cada tela (vitória e derrota) salvo em `production/qa/evidence/`

---

## Implementation Notes

- A interface não guarda estado do jogo; só reage aos sinais de vitória e derrota

---

## Out of Scope

- Ranking, save e progressão (fora do escopo do brief)

---

## Files

- `src/gameplay/rescue/goat_cage.gd`, `src/gameplay/rescue/goat_cage.tscn`
- `src/ui/victory_screen.tscn`, `src/ui/defeat_screen.tscn`, `src/ui/end_screen.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: UI
**Required evidence**: a retained screenshot of each screen touched (victory, defeat) in `production/qa/evidence/` (not waived at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-004-reviver.md`, `production/epics/operacao-bode-expiatorio/story-006-chefe.md`
- Unlocks: None
