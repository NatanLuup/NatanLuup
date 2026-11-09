# Story 001: Correr, pular e atirar

> **Epic**: Operação Bode Expiatório
> **Status**: In Progress
> **Layer**: Foundation
> **Type**: Visual/Feel
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-09

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 1

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 1 ("Personagem que corre, pula e atira, com controle gostoso"):*

- [ ] O personagem corre para a esquerda e para a direita numa cena de teste 2D com chão
- [ ] O personagem pula só quando está no chão
- [ ] O personagem atira; os projéteis saem na direção em que ele mira (pelo menos esquerda, direita e cima) e somem ao sair da tela
- [ ] Velocidade, força do pulo, gravidade, cadência e velocidade do tiro vêm de um arquivo de dados, não fixos no código
- [ ] Todas as ações funcionam no gamepad e no teclado (Input Map do Godot)
- [ ] A cena de teste é a cena principal do projeto e abre com o comando `run`
- [ ] O jogo rodou e um screenshot do personagem atirando está salvo em `production/qa/evidence/`

---

## Implementation Notes

- Movimento por `delta`; nenhuma referência a UI no código de gameplay
- Arte provisória (retângulos) é suficiente; a direção de arte do brief vem depois

---

## Out of Scope

- Story 002: qualquer coisa de rede (aqui é só um jogador, local)
- Story 003: inimigos e dano

---

## Files

- `src/gameplay/player/player.gd`
- `src/gameplay/player/player.tscn`
- `src/gameplay/player/player_stats.gd`
- `assets/data/player_stats.tres`
- `src/gameplay/weapons/bullet.gd`
- `src/gameplay/weapons/bullet.tscn`
- `src/core/input_actions.gd`
- `src/levels/test_arena.tscn`
- `project.godot` (main scene, 1280x720 viewport)

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Visual/Feel
**Required evidence**: a retained screenshot in `production/qa/evidence/` + sign-off in `production/qa/evidence/correr-pular-atirar-evidence.md` (not waived at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: None
- Unlocks: `production/epics/operacao-bode-expiatorio/story-002-coop-online.md`, `production/epics/operacao-bode-expiatorio/story-003-inimigos.md`
