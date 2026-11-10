# Evidência: Story 001, Correr, pular e atirar

**Story**: `production/epics/operacao-bode-expiatorio/story-001-correr-pular-atirar.md`
**Tipo**: Visual/Feel
**Data**: 2026-11-09
**Build**: Godot 4.7.2.stable.official.ed1daf0bf, janela 1280x720, Forward+

## Como foi verificado

A cena real (`src/levels/test_arena.tscn`) rodou em janela com um harness descartável, fora do
projeto, que injetou eventos de teclado e gamepad pelo `Input` e mediu o resultado. Foram 22
verificações, todas aprovadas. `commands.run` também abriu o jogo e saiu sem erro.

| Critério | Resultado medido |
|---|---|
| Corre para os dois lados | +110,0 px e -110,0 px em 30 frames (220 px/s) |
| Pula só no chão | Subiu 58,5 px; no ar, novo pulo não reiniciou a velocidade (-356,7 para -263,3) |
| Tiro em 3 direções e some fora da tela | Velocidades (900, 0), (-900, 0) e (0, -900); todos os projéteis foram removidos |
| Valores vêm de arquivo de dados | Dobrar `run_speed` no resource dobrou a distância (146,7 px em 20 frames); 6 tiros em 60 frames com `fire_interval` 0,15 |
| Teclado e gamepad | Analógico, D-pad, botão A, botão X e mira no analógico responderam |
| Cena principal abre com `run` | `run/main_scene` aponta para `test_arena.tscn` |

## Screenshots

- `story-001-correr-pular-atirar/01-personagem-atirando-direita.png`: personagem no chão, três projéteis para a direita
- `story-001-correr-pular-atirar/02-personagem-atirando-cima.png`: personagem no chão, três projéteis para cima

## Limites desta verificação

- **Gamepad físico não testado:** os eventos de gamepad foram simulados e passaram pelo Input Map real.
- **Sensação de controle não avaliada:** "controle gostoso" depende de alguém jogar. Um still e um script não medem isso.

## Observações

- A arma não aponta para cima ao mirar para cima (só o projétil muda). A arte atual é provisória.

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Lead (art-director / designer) | Dono do projeto | 2026-11-09 | [x] Approved |

Aprovação dada no chat ("pode fechar o Story 1"), antes de os screenshots serem mostrados.

---

*Template: `.claude/docs/templates/test-evidence.md`*
