->gene_interaction_2_start

//

//  System: characters/items can have various states
LIST TreePassageDoorState = (closed), open
LIST ShroomieState = (normal), waterlogged

// System: inventory
LIST Inventory = key_tree_passage, leaf_glider

=== function get(x)
    ~ Inventory += x

// System: task list 
LIST Tasks = bring_gene_compost_compote, bring_belle_water

// System: progress
LIST Progress = met_gene, met_belle, met_garlics, belle_not_watered, belle_watered

//

=== gene_interaction_2_start === 

{"Back so soon?"|Gene lowers his eyelids.|Gene submerges his face in the water, then emerges with a flick of his 'hair'.|Gene hums an unfamiliar tune|Gene yawns.|->END} #Gene: 
* {Progress ? met_garlics} "I got threatened by garlic." #You:
"Yeah those guys have some big-clove energy. They're all talk and no fork." #Gene:   
->gene_interaction_2_start
* (i_got_key) {Inventory ? key_tree_passage} "I got a key to a secret tunnel!" #You: 
    "Good going, Shroomie! I always thought that tunnel was just a rumour." #Gene:
    ->gene_interaction_2_start
* {Tasks ? bring_belle_water && ShroomieState == normal} "Do you have a container I could borrow?["] It's for carrying water." #You: 
    "'Fraid not, my fungal friend. Say, YOU might be a good water container. What with that spongy noggin of yours." #Gene:
    ->gene_interaction_2_start
* {ShroomieState == waterlogged} "I'm full of water!" #You:  
    "I can't say I'm not jealous. You get to take the stream with you wherever you go!" #Gene:
    ->gene_interaction_2_start
* "I like your vibe." #You:
    "Can't get enough of the Gene, huh? It figures." #Gene:
    ->gene_interaction_2_start
* [Leave Gene to it.]
->END
