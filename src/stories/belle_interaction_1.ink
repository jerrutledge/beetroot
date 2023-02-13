->belle_interaction_1_start

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

=== belle_interaction_1_start ===
//Shroomie finds Belle on the top branch of the tree. 

"Oh praise the Sun, someone finally came for poor old Belle! You absolutely must get me out of here darling, I'm in the most awful predicament." #Belle: 
* "Predica-what?" #You: 
    "Predicament my dear, google it.  
* "Oooh an acorn!" #You: 
    "More ache than corn currently, my dear. I'm all in a fluster!  
    
- <> There's no time for idle babble—that beast will be back any minute now." #Belle: 
* "Beast?" #You:   
    "Yes, do keep up.
* "But I like idle babble." #You: 
    "Idle babble is for idle minds. 

-(belle_has_dreams) {<> The squirrel. He stashed me here like a common pine nut, the devil. Now I'm destined to either rot or be gnawed to death come winter. I have dreams, you know."| Belle teeters back and forth on the branch anxiously.} #Belle:
* "What dreams?" #You:
->belle_interaction_1_middle
* "Maybe he just wants to be friends?" #You:
    "Friends? Ha! I saw the ravenous glint in his eye as he snatched me from the forest floor with his slimy mouth. Friends don't slobber over friends, my darling." #Belle:
    ->belle_has_dreams

= belle_interaction_1_middle
"To be planted! To sprout! To extend my elegant limbs and bask in the spotlight! I was born to be star darling, can't you see?" #Belle:
* "Yes!" #You:
* "Not really." #You:

- (bring_water) {"I've the perfect spot in mind. I just need water. If you bring me water, I'll get you past that ghastly gang of garlics down there."|Belle stares at you expectantly.|Belle bites her lip.|->belle_interaction_1_end} #Belle:
* "Where do I get water?" #You:
    "There's a source d'eau not far from here. Nothing less than pure mineral water will do, my lovely. I'm worth it!" #Belle:
    -> bring_water
* "How do I carry the water?" #You:
    "Why surely a bright little toadstool like you can figure it out? My very being depends on it!" #Belle:
    -> bring_water
* {Progress ? met_garlics} "Do they threaten to fork everyone?" #You:
    "Many have been forked, yes. Smelly little wretches. Some vegetables have no class." #Belle: 
    -> bring_water
* "Got it!" #You:
->belle_interaction_1_end
    
= belle_interaction_1_end
~ Progress += met_belle
"Take this key. It's a little rusted, but it should get you to water. Oh do hurry darling, hurry!" #Belle:
You make a mental note to find water and bring it back to Belle.   
~ Tasks += bring_belle_water
~ Inventory += key_tree_passage
->END

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
