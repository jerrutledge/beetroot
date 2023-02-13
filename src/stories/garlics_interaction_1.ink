->garlics_interaction_1_start

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

=== garlics_interaction_1_start === 

//Shroomie walks towards the vegetable patch. Just before she arrives, a gang of three garlics jump out from behind a bush holding pitchforks. 

"Halt! State your name!" #Garlic leader:   
* "Shroomie" #You: 
    "Shroomie? C'mon pal, weren't born yesterday." #Garlic leader:
    * * "It is actually Shroomie." #You:
        "Okay, Shroomie. Shroomie McMush Head. Mush for brains." #Garlic leader:
        ->garlics_interaction_1_middle
    * * "Why should I tell you anyway?" #You:
        "Because we don't like your face, mush-for-brains." #Garlic leader:
        ->garlics_interaction_1_middle
* "I'm taking suggestions." #You:
    "Oh yeah? How about trespasser? Mush-brained trespasser!" #Garlic leader:
        ->garlics_interaction_1_middle
* "You first!" #You:
    "Listen, mush-for-brains. All you need to know from us is that you're trespassing." #Garlic leader:
        ->garlics_interaction_1_middle
 
=garlics_interaction_1_middle

{"What business do you have in the vegetable patch?"| The garlics lunge forward meanacingly.|One of the garlics hocks up some phlegm and spits it at your feet.|The garlics laugh maniacally.|The garlics twirl their weapons, feeling their weight.|->garlics_interaction_1_end} #Garlic leader: 

* "I'm just trying to find Tree." #You:
    "A likely story. You're just looking for a good feed. You'll latch on to a juicy squash and make it go all rotten. Well forget about it!" #Garlic leader:
    ->garlics_interaction_1_middle
* (why_guarding) "Why are you guarding it?" #You:
    "Our employer wants us to guard it from all undesirables! E.g. stinky little fungi like you." #Garlic leader:
    ->garlics_interaction_1_middle
* {why_guarding} "Who's your employer?["] I'd like to make a complaint." #You:
    "None of your beeswax! Our employer wishes remain anonymous, comprendes?" #Garlic leader:
    ->garlics_interaction_1_middle
* {why_guarding} "Me stinky? Look who's talking..." #You:
    "That's a horrible sterotype! We have an AROMA, you little crap-kisser." #Garlic leader:
    ->garlics_interaction_1_middle
* "Who hurt you?" #You:
    "No one! We deal out the hurt around here, you poisonous slime-blossom." #Garlic leader:
    ->garlics_interaction_1_middle
    
= garlics_interaction_1_end
~ Progress += met_garlics
"Enough chatter! Get out of here and don't come back. We'll fork ya!" #Garlic leader:
->END
