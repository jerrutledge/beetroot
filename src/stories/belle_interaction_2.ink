->belle_interaction_2_start

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

=== belle_interaction_2_start ===
//Shroomie finds Belle at the top of the tree once more. 
"You've returned! Did you bring the water?" #Belle: 
{ShroomieState == waterlogged: ->belle_complete_water_task|->belle_fail_water_task} 

= belle_fail_water_task
You shrug. 
"Judging by that gesture—and the visible lack of water—you've failed. Go find some, post haste!" #Belle:
->END

= belle_complete_water_task
You jiggle your body and let the sloshing liquid do the talking. #You: 
"Wonderful! A little unconventional darling, but beggars can't be choosers. Now, take this." #Belle: 
* [Take leaf glider.]
~ Inventory += leaf_glider
~ Tasks -= bring_belle_water
- (belle_gives_leaf) {"Now, I'm going to hop on your back. Then we'll glide down past the garlics, and into the vegetable patch to sweet safety."|Belle looks at the leaf in anticipation.|->end_leaf_chat} #Belle:
    * * (good_idea) "Uhh... is this a good idea?" #You:
        "Darling, it's the ONLY idea. You want past those menaces, and I want to be buried in a hole and moistened. This is it, I'm afraid." #Belle:
        ->belle_gives_leaf
    * * {good_idea} "Won't the water weigh us down?" #You:
        "Best not to think about the physics of it, my dear. Just... think of it as a game. Yes, a game you'd play with your little mushroom acquaintances." #Belle:
        ->belle_gives_leaf
    * * (end_leaf_chat) "Alright then..." #You:
        "My dear, you fill me with confidence. Assume the position!" #Belle:
        ->END