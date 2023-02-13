->garlics_interaction_2_start

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

=== garlics_interaction_2_start === 

- (garlics_interaction_2_loop) {"I thought we told you to get lost?"|The lead garlic flips you a rude hand gesture.|->garlics_interaction_2_end} #Garlic leader:

* "What will it take to get past?" #You: 
    "Ha! Begging now, is it? We we've got news for you, mush-for-brains. There's nothing you can do!" #Garlic leader: 
    ->garlics_interaction_2_loop
* "Look over there, it's a garlic farmer!" #You: 
    "WHAT? Where? Hold on, we know what you're trying to play. You stumpy little brat. Garlic farmers come Wednesdays." #Garlic leader:
    ->garlics_interaction_2_loop

= garlics_interaction_2_end
"We've had it with you! Go find a damp, dark place and stay there." #Garlic leader:
->END