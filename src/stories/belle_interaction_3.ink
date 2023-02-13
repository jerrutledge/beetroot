->belle_interaction_3_start

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

=== belle_interaction_3_start ===
//Using the leaf glider, with Belle on her back, Shroomie glides over the garlics and lands at the entrance to the vegetable patch. When they land, Belle jumps off Shroomie and begins the interaction.

"Top work, darling! Really, just spiffing stuff." #Belle: 
* "Woo!" #You: 
* "Huzzah!" #You:
* "WE CRUSHED IT!" #You:
- "Quite dear, quite. Now, I'm going to throw myself into this hole. I want you to cover me with dirt, and dump that water of yours all over me. Understand?" #Belle: 
* "Yes." #You:
    "Lovely. 
* "Must I?" #You:
    "You must, I'm afraid. It's my raison d'être. 
- <> It's been an honour to make your acquaintance, darling. Promise you'll come back and visit when I'm a dazzling oak tree. Farewell, little mushroom!" #Belle: 
//Belle jumps into the hole.
Belle looks up at you from the hole with hope etched onto her face. #Belle:
* [Squeeze water into the hole.] 
~ Progress += belle_watered
~ ShroomieState = normal
//This option should trigger animation of Shroomie covering Belle in dirt, and squeezing water out of herself onto the dirt patch.
->END
* [Walk away.] 
->dont_water_belle

= dont_water_belle
//This option means Shroomie leaves Belle in the hole, uncovered.
"Darling, where are you going? Little mushroom? GET BACK HERE THIS INSTANT AND MAKE ME WET, FOR SUN'S SAKE." #Belle: 
~ Progress += belle_not_watered
->END