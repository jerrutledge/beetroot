-> gene_interaction_1_start

//

//  System: characters/items can have various states
LIST ShroomieState = (dirty), clean

// System: inventory
LIST Inventory = (none)

=== function get(x)
    ~ Inventory += x

// System: task list 
LIST Tasks = bring_gene_compost_compote

// System: knowledge
LIST ShroomieKnows = gene_name

=== function learn(x)
    ~ ShroomieKnows += x

//

=== gene_interaction_1_start
-
* "Hello." 
* "'Sup?" 
* "OI!"
-(gene_interaction_1_loop_1) {"Argh! You scared the bleedin' seeds outta me. What's up, Shroomie?"|Gene eases back into the stream, letting the cool water bathe his body once more.|Gene eyes you warily.|Gene closes his eyes and enjoys the sensation of the current against his backside.|Gene scratches his belly.->gene_interaction_1_loop_1|->gene_interaction_1_middle}
* "Is Shroomie... my name?"#Shroomie
    "I dunno. Is it? I call all mushrooms I don't know Shroomie. Like 'Tatty' for 'taters." #Gene
    ->gene_interaction_1_loop_1
* (bad_memory) "I don't know what's up[."]... I don't know much of anything." 
    "Oh dear! Boozy night, was it? Don't worry, I'm sure it will all come flooding back to ya." #Gene
    ->gene_interaction_1_loop_1 
* "Sorry for startling you."
    "No bother. I was lost in my thoughts. I come here during the summer for my morning bathe, and usually there's not a soul to be found."#Gene
    ->gene_interaction_1_loop_1
* "Who are you?"
    "I'm Gene. My name means 'noble aristocrat', apparently. I'm taking the role very seriously, as you can see."
    ~ ShroomieKnows += gene_name
    ->gene_interaction_1_loop_1
* [Say nothing.]
    ->gene_interaction_1_middle
    
= gene_interaction_1_middle

"Say, you should join me. {bad_memory: It'll be good for that hangover of yours| You look like you need it. If you, uh, don't mind me saying}."  

* "I guess a little dip won't hurt."
    "That's the spirt! A nice shock to the system."
    ->shroomie_bathes_with_gene
* "No... I need to find Tree." 
    ->must_find_tree

=shroomie_bathes_with_gene
// Shroomie enters the stream and sits down. 
~ ShroomieState = clean
{"So, where you headed?"|Gene lazily bats away a floating twig.}   
* "I must find Tree."
->must_find_tree 
* "I was thinking brunch?"
    "You been to Casa Cassava? The compost compôte is to die for."
    * * "I'll go try it." 
    - - - (compote_task_request) {no_compote: Say, if you change your mind and end up going,|"Oh man my tongue is dripping just thinking about it. Say, if you go} could you bring me back some? I'm never really in the area." 
        * * * "Sure!" 
            ~ Tasks += bring_gene_compost_compote
            You make a mental note to bring Gene some compost compôte from Casa Cassava. 
            "Thanks a million. I'll be right here relax—uh... working. In my head. Head working."
            ->shroomie_bathes_with_gene 
        * * * "I'd rather not[."] make any commitments."
            "I can appreciate that. As a general rule I never make commitments. Apart from soaking my bulbous body in this delicious stream."
            ->shroomie_bathes_with_gene
    * * (no_compote) "No, not for me." 
        "No to compost compôte? You really did bash your cap hard, huh.->compote_task_request 

=must_find_tree  

"Tree, huh? There are thousands of trees around here. Any specifics?" 
* "Big tree?" 
* "Leafy tree?"
* "Rooty tree?" 
- "Wow, that really narrows it down. Listen, there's a tree back behind me, you can check that out. Maybe someone knows something."
* "Okay!"
* (maybe) "Maybe..." 
- {maybe: "Aw, come on. No need to be despondent. |"}You'll find your tree, I'm sure. And if you don't, well, come back for a dip. See ya!" 
* "Goodbye, {ShroomieKnows ? gene_name: Gene|eggplant}."

->END
// Shroomie can continue onwards to the tree.
