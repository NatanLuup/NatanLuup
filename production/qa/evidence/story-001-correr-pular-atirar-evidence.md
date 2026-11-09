# Test Evidence: Correr, pular e atirar

> **Story**: `production/epics/operacao-bode-expiatorio/story-001-correr-pular-atirar.md`
> **Story Type**: Visual/Feel
> **Date**: 2026-11-09
> **Tester**: NatanLuup
> **Build / Commit**: 0509720

---

## What Was Tested

The player character in the test arena: running, jumping on the ground, shooting sideways and upward, launched with F5 in Godot 4.7.2 on the developer's Windows machine.

**Acceptance criteria covered**: AC-1 to AC-7

---

## Acceptance Criteria Results

| # | Criterion (from story) | Result | Notes |
|---|----------------------|--------|-------|
| AC-1 | Corre para a esquerda e para a direita | PASS | Confirmed by the tester |
| AC-2 | Pula só quando está no chão | PASS | Confirmed by the tester ("está pulando certinho") |
| AC-3 | Atira para os lados e para cima; projéteis somem fora da tela | PASS (asserted) | Confirmed by the tester; no screenshot with bullets retained |
| AC-4 | Valores vêm de arquivo de dados | PASS | `assets/data/player_stats.tres` |
| AC-5 | Funciona no gamepad e no teclado | PASS (keyboard only) | Gamepad not tested |
| AC-6 | A cena de teste é a cena principal | PASS | F5 opened the arena — see screenshot 1 |
| AC-7 | Screenshot do personagem atirando salvo | PARTIAL | Retained screenshot shows the arena and player, not a shot in flight |

---

## Screenshots / Video

| # | Filename | What It Shows | Acceptance Criterion |
|---|----------|--------------|----------------------|
| 1 | `story-001-correr-pular-atirar/arena-parado.png` | Test arena running: sky, ground, platform, green player standing with gun facing right | AC-6, AC-7 (partial) |

---

## Test Conditions

- **Game state at start**: fresh launch of the test arena
- **Platform / hardware**: Windows, Godot 4.7.2
- **Framerate during test**: not measured
- **Any special setup required**: none

---

## Observations

- Feel approved by the tester ("Está bom").
- Closed by the developer's choice without a screenshot of bullets in flight and without a gamepad test; both remain open checks.

---

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Lead (art-director / designer) | NatanLuup | 2026-11-09 | [x] Approved |
