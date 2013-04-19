# Games

[ianmcgregor.me/games](http://ianmcgregor.me/games)

## TODO

### Rogue
* Make undergrowth slower to cross like water
* Only dampen if actually pushed block
* Lava
* Different exits
* Sfx
* Spears coming out of walls
* Monster shooting not quite right!
* Study gauntlet levels
* Track kills?
* Boss battles?
* Make sure level not being totally recreated every time
* Potion to temporarily go through walls
* Enemy collision and fighting
* Change weapon
* Choose player - different sprites with different movement and weapon
* names: glove, ordeal

### Base code

* could maybe do with setter for state that has optional data and stores prevState
* fullscreen for web version (add to titles)
* preloader for web version (ref in ant build)
* Pooling Spatials (will need to reassign owner entity)
* Pooling Entities
* Fast Math (round, abs etc) -inline
* Move reusable components and systems to lib or template
	** Physics
	** Expiration
	** PlayerControl
* Test Artemis Bag performance using Linked List - will need some node object or baggable interface

### Nanotech Defenders

* diff harmonic sfx for each player
* thruster sfx
* hero damage sound
* maybe player shields/health regenerates over time
* explosions
* bonuses?
* levels? have to destroy certain number each level and gets harder and with diff sounds

### Ultra Racer

* Fix corner so it's sharp
* Should GameContainer have different layers like top, middle, bottom?
* Add an animated water hazard!
* CPU opponent to get progressively harder as player progresses
* High scores
* Acheivements for best lap etc
* Lap time / best lap
* Track time
* Scoreboard
* Pick up

## Research:

Shakespeare games

## Notes:

For Android need -compress=false compiler arg

For iOS may want app XML to have:

<key>UIApplicationExitsOnSuspend</key><true/>