## Preface
For this tutorial, I implemented a character using the Soldier spritesheet and gave it basic platformer controls.

## Added mechanics:
### Double-Jump
The player is able to jump mid-air.

### Better-Jump
The player is able to adjust their jump-arc by how long the jump button is held down. This mechanic gives the player a finer locus of control and a more precise platforming experience. One classic example of this mechanic's implementation is the original NES Super Mario Bros.

### Slide
The player is able to perform a tactical slide which effectively functions as a dash mechanic.

### Crouch
This mechanic is purely aesthetic, allowing the player to alter the character's sprite to the crouching position if the "down" button is held.

### Acceleration & Deceleration
For a more refined movement system, I added subtle acceleration and deceleration to the player character's horizontal movement. I also decided to distinguish the acceleration experienced on-ground and mid-air, making the latter less easy to control as to add a trade-off to jumping and deepen the movement mechanics.

### State Machine Implementation
To keep my code tidy, I decided to implement the player's movement as separate states, with an enum denoting each one.
