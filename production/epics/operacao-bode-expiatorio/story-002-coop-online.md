# Story 002: Co-op online para 2 jogadores

> **Epic**: Operação Bode Expiatório
> **Status**: Complete
> **Layer**: Foundation
> **Type**: Integration
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-09

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 2

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.2 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal)

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From `design/game-brief.md`, MVP feature 2 ("Co-op online para 2 jogadores — um hospeda e o outro entra com um código") and Build order step 2:*

- [ ] Um jogador escolhe "Hospedar" e o jogo mostra o que o amigo precisa para entrar
- [ ] O outro jogador escolhe "Entrar", informa isso e se conecta
- [ ] Os dois veem os dois personagens na mesma cena; cada um controla só o seu
- [ ] Movimento, pulo e tiro de cada jogador aparecem na tela do outro
- [ ] Se um dos dois desconecta, o outro vê um aviso em vez de travar
- [ ] Testado com duas instâncias do jogo conversando pela rede; resultado registrado como playtest

---

## Implementation Notes

- **Decisão (2026-11-09, usuário):** conexão por **IP direto** (ENet), sem servidor intermediário. Quem hospeda passa o IP; o amigo digita e entra. Se o roteador bloquear, os jogadores usam uma rede virtual (Radmin VPN, ZeroTier, Tailscale). Entrar por código curto fica para depois. Isso substitui o "entra com um código" do brief para o MVP
- Usar a API de multiplayer de alto nível do Godot; checar `docs/engine-reference/godot/` antes de citar qualquer API

---

## Out of Scope

- Mais de 2 jogadores, matchmaking público, servidores dedicados (fora do escopo do brief)
- Story 004: reviver

---

## Files

- `src/networking/lobby.gd`
- `src/networking/lobby.tscn`
- `src/networking/network_manager.gd`
- `src/networking/network_config.gd`
- `assets/data/network_config.tres`
- `src/gameplay/player/player.gd`
- `src/gameplay/player/player.tscn`
- `src/gameplay/player/player_stats.gd`
- `assets/data/player_stats.tres`
- `src/levels/test_arena.tscn`
- `production/qa/playtest-coop-online.md`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Integration
**Required evidence**: `tests/integration/networking/coop_online_test.gd` OR playtest doc (tests advisory at `qa.level: minimal`)

**Status**: [x] Created: `production/qa/playtest-coop-online.md`

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-001-correr-pular-atirar.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-004-reviver.md`

## Completion Notes
**Completed**: 2026-11-09
**Criteria**: 6/6 passing (two instances over 127.0.0.1; internet between two PCs not tested)
**Deviations**: ADVISORY: the brief's "código" is the host's IP for now, relay deferred. ADVISORY: `.claude/rules/network-code.md` not fully met: each player owns its position with no host validation, no message versioning and no interpolation; Story 003 damage must be decided by the host. ADVISORY: player-facing strings live in `src/networking/lobby.gd`, not in localization files. Scope not checked: this copy has no git repository
**Test Evidence**: `production/qa/playtest-coop-online.md` (automated test waived at qa.level minimal)
**Run result**: OBSERVED: both players, movement, jumps, shots and disconnect notices on both screens, `production/qa/evidence/story-002-coop-online/`
**Reviewed by**: self, no independent review (QL-TEST-COVERAGE and LP-CODE-REVIEW skipped, Solo mode)
