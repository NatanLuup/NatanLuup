# Playtest: Co-op online para 2 jogadores (Story 002)

**Story**: `production/epics/operacao-bode-expiatorio/story-002-coop-online.md`
**Data**: 2026-11-09
**Build**: Godot 4.7.2.stable.official.ed1daf0bf, janela 1280x720, Forward+
**Rede**: duas instâncias na mesma máquina, ENet/UDP, host em `*:7777`, guest em `127.0.0.1`

## Como foi feito

Duas instâncias reais do jogo, sem pessoas: um harness descartável, fora do projeto, carregou a cena
principal, acionou os botões do lobby e injetou entrada de teclado em cada instância. Cada lado mediu
o que aparecia na própria cena. Nenhum `ERROR` ou `WARNING` nos logs dos cenários.

## Resultados

| Cenário | Resultado |
|---|---|
| Hospedar mostra o que o amigo precisa | "Passe para o amigo: 192.168.15.17 (porta UDP 7777)" |
| Entrar em `127.0.0.1` | Conectou; menu some; 2 personagens nas duas telas |
| Pontos de nascimento | Host em x=200 e guest em x=300, iguais nas duas telas |
| Cada um controla só o seu | Autoridade correta nos dois lados; entrada de um move 0 px o personagem do outro |
| Movimento aparece no outro | Host anda 110 px e o guest vê x=310 nas duas telas; guest vê x=410 nas duas telas |
| Pulo aparece no outro | 101 px de altura observados pelos dois lados |
| Tiro aparece no outro | Projéteis observados nas duas telas |
| Guest sai do jogo | Host removeu o personagem, mostrou o aviso e continuou jogando |
| Host sai do jogo | Guest voltou ao menu com "Quem hospedava saiu da partida." e personagens removidos |
| Guest morto à força (`taskkill`) | Host avisou em 6,3 s, sem travar |
| Botão Sair e entrar de novo | Guest voltou ao menu, reconectou; 2 personagens de novo; aviso do host limpo |
| Entrar sem ninguém hospedando | Erro no menu após 31,5 s; botões travados durante a tentativa |

## Screenshots (`production/qa/evidence/story-002-coop-online/`)

- `01-menu.png`, `02-hospedando.png`
- `03-host-ve-os-dois-atirando.png`, `04-guest-ve-os-dois-atirando.png`
- `05-host-aviso-amigo-saiu.png`, `06-guest-aviso-host-saiu.png`
- `07-host-aviso-apos-queda-forcada.png`, `08-guest-sem-host.png`

## Defeito encontrado e corrigido durante o teste

O guest nascia em (0,0), porque a posição inicial definida pelo host não é replicada para quem é dono
do próprio personagem. Corrigido enviando a posição nos dados do spawn (`MultiplayerSpawner.spawn_function`).

## O que este teste não cobre

- **Internet real:** só loopback. Dois PCs, roteador, porta aberta e latência não foram testados.
- **Sensação com latência:** o personagem remoto recebe posição sem interpolação.
- **Firewall:** o Windows pode pedir permissão na primeira vez que o jogo hospeda.
- **Pessoas jogando:** a entrada foi simulada.
