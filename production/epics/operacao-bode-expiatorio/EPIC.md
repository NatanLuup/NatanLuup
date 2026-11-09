# Epic: Operação Bode Expiatório

> **Tier**: minimal — built from `design/game-brief.md` (no GDD, ADRs or control manifest)
> **Status**: Ready

## Goal

Você e seus amigos invadem uma base militar ridícula, online e atirando em tudo, para resgatar o bode mascote da equipe antes que os vilões o transformem em arma secreta.

## Scope (Brief MVP)

1. Personagem que corre, pula e atira, com controle gostoso
2. Co-op online para 2 jogadores (um hospeda e o outro entra com um código)
3. 2 tipos de inimigo com mortes exageradas
4. Reviver o amigo caído
5. Uma fase curta e linear terminando na base
6. Um chefe simples
7. Resgate do bode e telas de vitória e derrota

## Order

The brief's Build order: movement and shooting (local) → two players online → enemies → revive → level → boss and rescue. Online co-op comes second on purpose: it is the riskiest part.

## Stories

| # | Story | Type | Status | ADR |
|---|-------|------|--------|-----|
| 001 | [Correr, pular e atirar](story-001-correr-pular-atirar.md) | Visual/Feel | Ready | N/A (minimal) |
| 002 | [Co-op online para 2 jogadores](story-002-coop-online.md) | Integration | Ready | N/A (minimal) |
| 003 | [Dois tipos de inimigo](story-003-inimigos.md) | Logic | Ready | N/A (minimal) |
| 004 | [Cair e reviver o amigo](story-004-reviver.md) | Logic | Ready | N/A (minimal) |
| 005 | [Fase curta até a base](story-005-fase.md) | Integration | Ready | N/A (minimal) |
| 006 | [Chefe simples](story-006-chefe.md) | Logic | Ready | N/A (minimal) |
| 007 | [Resgate do bode e telas finais](story-007-resgate-telas.md) | UI | Ready | N/A (minimal) |
