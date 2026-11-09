# Story 002: Co-op online para 2 jogadores

> **Epic**: Operação Bode Expiatório
> **Status**: Ready
> **Layer**: Foundation
> **Type**: Integration
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

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

- **Decisão em aberto, tomar no início do `/dev-story`:** como os dois PCs se encontram pela internet. Opções: conexão direta por IP (simples; quem hospeda costuma precisar abrir uma porta no roteador) ou um serviço intermediário (relay) que permite entrar com um código curto. O brief diz "código"; confirmar com o usuário antes de implementar
- Usar a API de multiplayer de alto nível do Godot; checar `docs/engine-reference/godot/` antes de citar qualquer API

---

## Out of Scope

- Mais de 2 jogadores, matchmaking público, servidores dedicados (fora do escopo do brief)
- Story 004: reviver

---

## Files

- `src/networking/lobby.gd`, `src/networking/lobby.tscn`
- `src/networking/network_manager.gd`
- `src/gameplay/player/player.gd` (sincronização)
- `production/qa/playtest-coop-online.md`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

**Story Type**: Integration
**Required evidence**: `tests/integration/networking/coop_online_test.gd` OR playtest doc (tests advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/operacao-bode-expiatorio/story-001-correr-pular-atirar.md`
- Unlocks: `production/epics/operacao-bode-expiatorio/story-004-reviver.md`
