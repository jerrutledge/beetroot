->gene_interaction_1_start

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

=== gene_interaction_1_start === 
{"Argh! You scared the seeds outta me. What's up, Shroomie?"|Gene eases back into the stream, letting the cool water bathe his body once more.|Gene eyes you warily.|Gene closes his eyes and enjoys the sensation of the current against his backside.|Gene scratches his belly.|->gene_interaction_1_middle} #Gene: 
* "Is Shroomie... my name?" #You:
    "I dunno. Is it? I call all mushrooms I don't know Shroomie. Like 'Tatty' for potatoes." #Gene: 
    ->gene_interaction_1_start
* (bad_memory) "I don't know what's up[."]... I don't know much of anything." #You:
    "Oh dear! Boozy night, was it? Don't worry, I'm sure it will all come flooding back to ya." #Gene: 
    ->gene_interaction_1_start
* "Sorry for startling you." #You:
    "No bother. I was lost in my thoughts. I come here during the summer for my morning bathe, and usually there's not a soul to be found." #Gene: 
    ->gene_interaction_1_start
* "Who are you?" #You:
    "I'm Gene. My name means 'noble aristocrat', apparently. I'm taking the role very seriously, as you can see." #Gene: 
    ->gene_interaction_1_start
* [Say nothing.]
    ->gene_interaction_1_middle
    
= gene_interaction_1_middle

{"So, where you headed?"|Gene lazily bats away a floating twig.} #Gene:   
* "I must find Tree." #You:
->gene_interaction_1_end 
* "I was thinking brunch?" #You:
    "You been to Casa Cassava? The compost compôte is to die for." #Gene:
    * * "I'll go try it." #You:
    - - - (compote_task_request) {no_compote: Say, if you change your mind and end up going,|"Oh man my tongue is dripping just thinking about it. Say, if you go} could you bring me back some? I'm never really in the area." #Gene:
        * * * "Sure!" #You:
        ~ Tasks += bring_gene_compost_compote
            You make a mental note to bring Gene some compost compôte from Casa Cassava. 
            "Thanks a million. I'll be right here relax—uh... working. In my head. Head working." #Gene:
            ->gene_interaction_1_middle 
        * * * "I'd rather not[."] make any commitments." #You:
            "I can appreciate that. As a general rule I never make commitments. Apart from soaking my bulbous body in this delicious stream." #Gene:
            ->gene_interaction_1_middle
    * * (no_compote) "No, not for me." #You:
        "No to compost compôte? You really did bash your cap hard, huh. #Gene: 
        ->compote_task_request
        
=gene_interaction_1_end 
~ Progress += met_gene
"Tree, huh? There are thousands of trees around here. Any specifics?" #Gene:
* "Big tree?" #You:
* "Leafy tree?" #You:
* "Rooty tree?" #You:
- "Wow, that really narrows it down. Listen, there's a tree back behind me, you can check that out. Maybe someone knows something." #Gene:
* "Okay!" #You:
* (maybe) "Maybe..." #You:
- {maybe: "Aw, come on. No need to be despondent. |"}You'll find your tree, I'm sure. And if you don't, well, come back for a dip. See ya!" #Gene:

->END
