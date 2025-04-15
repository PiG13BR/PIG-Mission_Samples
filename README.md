# OP_CORREDOR.Altis
### Description
- Spec Ops mission: In the eve of the Altis invasion by OTAN, the players are tasked to infiltrate enemy territory near Kavala, to destroy CSAT SAM system by cruise missiles from USS Liberty. The players starts in this ship (by spawning on it), where they have acess to the arsenal (this is the only time that they will have access to it) and two boats that can be deployed. The mission goes like this:
  - a. Reach the shore.
  - b. Evade enemy troops and get to the hill 108.
  - c. Lase and destroy enemy SAM targets using VLS from USS Liberty.
  - d. Exfiltrate.
- Coop Mission. Optimal for 4 players.
- [REQUIRED MODS](https://github.com/PiG13BR/PIG-Mission_Samples/blob/main/OP_CORREDOR.Altis/OP_CORREDOR.html)

### Features
- Custom Respawn Screen for players. The first spawn is on the USS Liberty. After reaching the first objective, the players in the AO become spawn points for dead players.
- Arsenal whitelist **BY ROLE**.
- In some events, AI uses [lambs_danger waypoints](https://github.com/nk3nny/LambsDanger/wiki/waypoints) to track/hunt down players.
- The enemies will react to shoots (EH FiredMan) if they're nearby, and they will get closer to the location to investigate.
- QRF:
  - There's a timer (default: 20 s) that runs when the player get spotted (by using group EH knowsAbout). The players have chance to stop this timer by killing all the enemies that have information, before that they can call reinforcements.
  - The enemy will react to dead bodies. [Based on this Feuerex's work](https://www.youtube.com/watch?v=t_IjrUiNjgo&pp=ygUUYXJtYSAzIGRldGVjdCBib2RpZXM%3D) The countdown timer to call reinforcements here is much lower.
