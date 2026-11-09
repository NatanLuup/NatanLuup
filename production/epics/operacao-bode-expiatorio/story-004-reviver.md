# Story 004: Cair e reviver o amigo

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Core
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 4

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 4 ("Reviver o amigo caído") and Player goal & fail state ("Derrota: todos os jogadores caídos ao mesmo tempo, sem ninguém para reviver"):*

- [ ] Quando a vida do jogador zera, ele fica "caído" no chão em vez de sumir
- [ ] Caído, o jogador não anda nem atira
- [ ] O outro jogador revive o caído ficando perto dele por um tempo
- [ ] Revivido, o jogador volta com parte da vida
- [ ] Se os dois estão caídos ao mesmo tempo, a partida termina em derrota (sinal emitido para a story 007)
- [ ] Tempo para reviver, vida ao reviver e distância vêm de arquivo de dados
- [ ] O estado caído/revivido é o mesmo nas duas telas online

---

## Implementation Notes

- A máquina de estados (vivo → caído → vivo, e "todos caídos" → derrota) deve ser testável sem rede nem cena

---

## Out of Scope

- Story 007: a tela de derrota em si

---

## Files

- `src/gameplay/player/downed_state.gd`
- `src/gameplay/match/match_state.gd`
- `assets/data/revive.json`
- `tests/unit/revive/reviver_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Logic
**Required evidence**: `tests/unit/revive/reviver_test.gd` (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-002-coop-online.md`, `production/epics/operacao-bode-expiatorio/story-003-inimigos.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-007-resgate-telas.md`
