INCLUDE variables
INCLUDE functions
INCLUDE map n sleep
INCLUDE journal


// hi <3

# title: Vigile
# author: Seeing Stone Games

VAR DEBUG = false

{DEBUG:
	IN DEBUG MODE!
	+	[Opening]
	    -> Opening
	+   [Skip opening for map check]
	    ~playerlocation = "MD"
	    {advancetime(0,2,0,0)}
	    ->MAP
//	+   [Boabaird 2]
//	    ~playerlocation = "MD"
//	    {alter(hassupplies, -2)}
//	    {advancetime(0,0,0,2)}
//	    ->Mai_Dunn.Boabaird_2
	+   [crann forest]
	    ->CrannForest
	+   [Journal]
	        ~ playerlocation = "MD"
	    ->Journal
	    
- else:
	// First diversion: where do we begin?
 ->init
}

===init===
+ [PLAY GAME]
    ->Pronouns
    
    
===Pronouns===
Please choose your character's pronouns. 
+ [They/Them/Theirs] # CLEAR
    ~ PRONOUN1 = "they"
    ~ PRONOUN2 = "them"
    ~ PRONOUN3 = "their"
    ~ PRONOUN4 = "theirs"
    ~ PRONOUN5 = "themself"
    ->Opening
+ [She/Her/Hers] # CLEAR
    ~ PRONOUN1 = "she"
    ~ PRONOUN2 = "her"
    ~ PRONOUN3 = "her"
    ~ PRONOUN4 = "hers"
    ~ PRONOUN5 = "herself"
    ->Opening
+ [He/Him/His] # CLEAR
    ~ PRONOUN1 = "he"
    ~ PRONOUN2 = "him"
    ~ PRONOUN3 = "his"
    ~ PRONOUN4 = "his"
    ~ PRONOUN5 = "himself"
    ->Opening
    
    

===Opening===
It is the year 84 C.E.

You are a <strong>vigile</strong>: an investigator hired by the Roman Legion and the elite to discover, solve and deal with mysterious happenings throughout the empire.

//Your <strong>journal</strong> is where you keep information relating to the cases you've solved and are investigating, as well as the clues you've discovered; your <strong>map</strong> is where you can choose which direction you follow the threads of the case towards.

You were tasked with the return of governor Sallustius Lucullus' nephew. In finding him, you uncovered the abduction was much larger than expected. People have been going missing from surrounding villages.

Your only lead to continue this case is the description of a suspicious individual: a man, tattooed, in the old Celtic style for war.

+[Continue]

    You travel to Mai Dunn, a large hillfort that commands over the surrounding countryside. It is ruled by Chief Boabaird, a Roman sympathiser and someone you have helped in the past.
 
    You enter the hillfort and approach the seat of power. Chief Boabaird stands and approaches, greeting you graciously.

    "What can I do for you?" he asks.
    -> Mai_Dunn.Boabaird_Opening



===Mai_Dunn===
{justbeenhospital == false && playerlocation !="MD":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "MD"
//{advancetime(0,0,0,10)}
//{whattimeDEBUG()}
->endoconvocheck->

+{not Boabaird_Opening && not Boabaird}[Approach Boabaird]
    ->Boabaird_Opening
//+{Boabaird_Opening && not Boabaird_2} [Approach Boabaird]
//    ->Boabaird_2
//+{Boabaird_2 && not Boabaird_3 && BathTavern.GuardsSitch} [Approach Boabaird]
//    ->Boabaird_3
//+{Boabaird_3 && not Boabaird_4 && DAY <= 25 && MONTH == 1} [Approach Boabaird]
 //   ->Boabaird_4
+{Boabaird_Opening} [Approach Boabaird]
    ->Boabaird
+{Boabaird.askplants}[Travel to Goededdwig forest]
        ~ playerlocation = "MD"
        ~ playerdestination = "forest"
    ->MAP_continue
+[Open map]
    ->MAP
->DONE
=Boabaird
{The Chief awaits your return, greeting you graciously when you enter.|When you enter Mai Dunn, the chief looks tired. He greets you courteously.} {DAY >= 24 && MONTH == 1 && not cranninfo: Boabaird looks as though he has been expecting you, and nods his head as you approach. <p></p>"Good, it’s you, Vigile. Just the person I need right now." ->cranninfo}
-(questions)
    *(askjob){not Boabaird_Ask_Job}[Ask if he has any more jobs for you] You ask if he has more jobs for you. 
    {advancetime(30,0,0,0)}
        ~ knowsvillage = true
        "A nearby village of mine, Cranborne, about half a day from here, has come to me with a problem," he says gravely.
        "There have been a spring of robberies throughout the village. Tensions are high as neighbour blames neighbour and I believe it is only a matter of time before someone is attacked, or killed, even. I believe the situation could do with some outside investigation. You hold no bias and will look at the facts objectively."
        ->questions
    *(askagaintattoos){daytalktoboabaird < DAY && not askagaintattoos}[Ask if he has news about the man with tattoos]"Do you have news on the tattooed man?" you ask.
    {advancetime(30,0,0,0)}
        "As a matter of fact I do," the chief says warily. "Some of my people have reported seeing an individual matching your descriptions around Bath. They are not sure how long they will linger there, but the tattooed man is there now."
        ->questions
    *(askplants)[“I need information on a plant."]  “I need information on a plant. It might be nothing, or it might be the key to all of this, I won’t know until I can talk to an expert.”
    {advancetime(30,0,0,0)}
        The Chief thinks for a moment before answering. “Heliwr can help with that, I’d think, or if he can’t he’d know who can. I know you've been before, but I can point out his house on your map again for you."
            ~knowsforest = true
            ->questions
    *(tellboabairdmacdudd){BathTavern.GuardsSitch}[Tell him what you learnt from {BathTavern.Macdudd_Invite:Macdudd|Macdudd's room}] You tell him what you've learnt so far.
    {advancetime(30,0,0,0)}
            His brow furrows at the mention of the abductions. “There are more reported missing every day. I hope you’re close to solving this.”
 //               **[Thank him and take your leave] As you take your leave, Boabaird stops you.  “Make sure you catch these buggers soon. They're a dangerous bunch so be careful.” {30secs()}
  //              ->Mai_Dunn
        ->questions
    *(askboabairdmacdudd){Bath.searchmacdudd && not BathTavern.GuardsSitch}[Tell him you lost the man] You tell him you looked for the tatooed man but could not find him.
    {advancetime(30,0,0,0)}
            His brow furrows. "This is unfortunate. I do not have more information on him, but I will let you know if I hear anything. I hope you have other leads to follow."
                ->questions
    *{SidequestVillage.arrest}[Tell him you dealt with the robberies] You tell him you found the criminal and let the town bring them to justice.
            {advancetime(30,0,0,0)}
            He nods. "Thank you, Vigile. It was troubling indeed. {SidequestVillage.intro.wait:I did hear that someone died, unfortunately, and the town have asked me to penalise you. I am sorry to, but must serve my people above all else." He gives you 3 denarii. {alter(hasmoney,3)}|I heard you dealt with the situation swiftly and will pay you in full for your service." He gives you 6 denarii.{alter(hasmoney,6)}}
                ->questions
    +[Return to Mai Dunn] {You thank the chief for his time and take your leave.|You give the chief a polite nod and leave him.|The chief gives you a nod as you leave.}
        ->Mai_Dunn
-(cranninfo)
    *"What's the issue?"
    {advancetime(30,0,0,0)}
        "Something’s happening in Crann Locháinín, a nearby forest. Every day I’ve got someone telling me they saw or heard something unnatural out that way. Go and take a look, would you? Put people at ease if it’s nothing, sort it out if it isn’t."
        ~knowscrann = true
        -(opts)
            **"Probably druids."
            {advancetime(30,0,0,0)}
                "Aye? More reason for you to go and do your job then."
                ->questions
            **"I'll take a look."
            {advancetime(30,0,0,0)}
                "I appreciate it, Vigile."
                ->questions
->DONE

=Boabaird_Opening
~ daytalktoboabaird = DAY
*(Boabaird_Ask_Tattooed)[Ask about the tattooed man] You ask about the tattooed man.
{advancetime(30,0,0,0)}
    The chieftan takes a moment to consider your description. You see him deliberating something, an internal conflict of some kind you think. Finally he seems to decide,
    "From the description you give me, I would say they are most likely from the tribes north of Hadrian's wall. Most likely linked with Pictish or Caledonean relations."
    -> Boabaird_Opening

* {Boabaird_Ask_Tattooed} [Ask if he knows of, or has heard of the location of this individual] You inquire further.
        {advancetime(30,0,0,0)}
        Chief Boabaird shakes his head.
    "Unfortunately I have not heard of such an individual. However," he quickly adds as he sees your look of resignation, "Someone such as this will stand out. I will have my people keep a lookout for him."
     -> Boabaird_Opening
* {Boabaird_Ask_Tattooed} [Ask why he seemed to hesitate] You ask why he seemed to hesitate.
    {advancetime(30,0,0,0)} 
    You think you see the chieftan flush with shame, or possibly anger, the redness of his skin almost hidden by his vast tangle of hair.
    "If I am honest with you, Vigile. I wasn't sure I could trust you. But you have proven that you can do good for my people."
    -> Boabaird_Opening
*(Boabaird_Ask_Job){Boabaird_Ask_Tattooed}[Ask if he has any more jobs for you] You ask if he has more jobs for you.
{advancetime(30,0,0,0)}
        ~ knowsvillage = true
    "A nearby village of mine, Cranborne, about half a day from here, has come to me with a problem," he says gravely.
    "There have been a spring of robberies throughout the village. Tensions are high as neighbour blames neighbour and I believe it is only a matter of time before someone is attacked, or killed, even. I believe the situation could do with some outside investigation. You hold no bias and will look at the facts objectively."
    -> Boabaird_Opening
+{Boabaird_Ask_Tattooed} [Thank Boabaird and be on your way] You thank the chief, leaving the hillfort behind you, and continue on the road. 
{advancetime(30,0,0,0)}
        ~ playerlocation = "MD"
/// debugging tools
    // {travel_time("NR")}{TRAVELTIME}
    // {advancetime(0,0,0,0)} {whattimeDEBUG()}
    ** [Open map] # CLEAR
        -> MAP
//=Boabaird_2
//The Chief awaits your return, greeting you graciously when you enter.

//"Vigile. What is it you need from me today?"
//*[Ask if he has news about the man with tattoos]{30secs()}
//    "Do you have news on the tattooed man?" you ask.
//    "As a matter of fact I do," the chief says warily. "Some of my people have reported seeing an individual matching your descriptions around Bath. They are not sure how long they will linger there, but the tattooed man is there now."
//    **[Thank Boabaird and be on your way.]{30secs()}
//        You exit the hill fort again, wondering how long it will be before you are brought back once again by your investigations.
//    ->MAP
//=Boabaird_3
//When you enter Mai Dunn, the chief looks tired. He greets you courteously.
//    *[Tell him what you learnt from {BathTavern.Macdudd_Invite:Macdudd|Macdudd's room}] You tell him what you've learnt so far.{30secs()}
//        His brow furrows at the mention of the abductions. “There are more reported missing every day. I hope you’re close to solving this.”
//        **[“I need information on a plant."]  “I need information on a plant. It might be nothing, or it might be the key to all of this, I won’t know until I can talk to an expert.” {30secs()}
//            The Chief thinks for a moment before answering. “Heliwr can help with that, I’d think, or if he can’t he’d know who can. I know you've been before, but I can point out his house on your map again for you."
//            ~knowsforest = true
//            ***[Thank him and take your leave] As you take your leave, Boabaird stops you.  “Make sure you catch these buggers soon. They're a dangerous bunch so be careful.” {30secs()}
//                ->Mai_Dunn
//    *[Return]
//        ->Mai_Dunn
//=Boabaird_4
//Boabaird looks as though he has been expecting you, and nods his head as you approach.
//"Good, it’s you, vigile. Just the person I need right now."
//    *"What's the issue?"
//        "Something’s happening in Crann Locháinín, a nearby forest. Every day I’ve got someone telling me they saw or heard something unnatural out that way. Go and take a look, would you? Put people at ease if it’s nothing, sort it out if it isn’t."
//        ~knowscrann = true
 //       -(opts)
//            **"Probably druids."
 //               "Aye? More reason for you to go and do your job then."
//                ->opts
 //           **"I'll take a look."
//                You nod to him and take your leave.
 //               ->Mai_Dunn

===MD_Forest===
{justbeenhospital == false && playerlocation !="forest":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "forest"
    ->endoconvocheck->
{!Making your way into the woods, the silence is heavy and foreboding. You’re sure that whatever the plants are linked with will be coming to a head soon and you hope that you are in time to prevent it. You finally come across Heliwr’s cabin. There is still some damage caused by the Legion from a previous case of yours. You hope that Heliwr will still be willing to help. ->Heliwr_Vervain|->Heliwr_Normal}
    
    
=Heliwr_Vervain
Heliwr greets you politely but not friendly. He is curt and prickly while talking to you. Though he still seems as though he wants to help with the disappearances. 
    *[Give plant sample] You hand him a clipping of the mysterious plants. “The Chief said you could tell me about this.”
    {advancetime(30,0,0,0)}
    The hunter examines the plant with interest, looking at the flowers, the stem and the leaves carefully. “Aye, that I can. It’s called vervain. Shouldn’t see it this early in the year, really. Sought after by medicine women and.. Druidic types. That what brought you here, then? Think it’s got something to do with the disappearances?”
        **[You say yes]“I think it’s no coincidence it keeps showing up wherever I look. And thank you for confirming it’s unseasonal: that rules out coincidence entirely, I’d say.”
        {advancetime(30,0,0,0)}
            ->Heliwr_Normal
        **[You say you're not sure]"I don't think I can be certain quite yet, but it's worth looking into."
        {advancetime(30,0,0,0)}
            ->Heliwr_Normal
=Heliwr_Normal
"Can I help you with anything{came_from(-> Heliwr_Vervain): else}, Vigile?"
-(opts)
    +[Purchase sleeping herbs]
    {advancetime(30,0,0,0)}
    {HELIWROP == HELIWROP.positive || HELIWROP == HELIWROP.great: Your {HELIWROP} relationship with Heliwr has encouraged him to discount your prices{HELIWROP == HELIWROP.positive: slightly}, in return for your help.}
    {HELIWROP == HELIWROP.negative || HELIWROP == HELIWROP.poor: Your {HELIWROP} relationship with Heliwr has caused him to dislike you, increasing your prices{HELIWROP == HELIWROP.negative: slightly}. He looks reluctant to be parting with the herbs at all.}
    {opinoncheck("Heliwr")}
    You have {hasmoney == 0: no money}{hasmoney == 1: 1 denarius}{hasmoney >= 2: {hasmoney} denarii}.
    //{pricemod}
    Sleeping herbs: {INT(HERBSPRICE*pricemod)} denarii each
    ~temp itemcost = INT(HERBSPRICE*pricemod)
        ++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hasherbs,1)}
            You buy 1 pack of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->opts
        ++{hasmoney >= itemcost*5}[5 ({itemcost*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hasherbs,5)}
            You buy 5 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->opts
        ++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hassupplies,10)}
            You buy 10 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->opts
    +[Return to Mai Dunn]
        ~ playerdestination = "MD"
        ->MAP_continue
    +[Return to map] 
        ->MAP
->DONE

===SidequestVillage===
{justbeenhospital == false && playerlocation !="village":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "village"
->endoconvocheck->
{SidequestVillage <=1: ->intro}
{arrestsuspect == "Marcia" || arrestsuspect == "Saoir" || arrestsuspect == "blacksmith": You have solved the string of robberies in town. There is nothing else for you to do here.}
//{advancetime(0,0,0,0)}
//{whattimeDEBUG()}

    +[Return to map] 
        ->MAP
=intro
You arrive on the outskirts of a small village, thatch rooved houses made of wattle and hide dot the surrounding area. The surrounding countryside is that of farmland, fields of wheat, pastures of cattle and beyond that the wild of the forests where you'll find wolves, bears and boar.

You come across a village in turmoil you see the populous in the streets arguing with one another.

"This is the last straw!"

"I say we search everyones houses."

"You really think they'll be hiding our stuff in plain sight? Fool."

*(clearthroat)[Clear your throat]
{advancetime(30,0,0,0)}You clear your throat and a member of the crowd notices you.

"Who are you then?" they ask aggressively.

*(introduce)[Intervene with an introduction]

*(wait)[Wait]
    {advancetime(30,0,0,0)}You stand back and wait to see what happens. Quickly the arguments are becoming more volitile. Accusations are thrown, angers rise and in a flash a knife is pulled. You're too slow to be able to stop the attacker as they sink blade into flesh. Before you have time to fully assess the situation you stand over a corpse, their life's blood leaking into the earth beneath them.

    The crowd is just as stunned and no one moves from their positions.
    **[Tell the crowd to back away]
        {advancetime(30,0,0,0)}You needn't have told them as the crowd scatters away from the attacker.
            ***[Arrest the attacker]
 //       (if they get this path, they gain half the gold reward and do not get an opinion increase from Local opinions when the quest is completed)
            {advancetime(30,0,0,0)}You manage to restrain the attacker. You tie them to a nearby tree as they rave about how the victim deserved it. You don't have time to take them back now. They will have to come with you when you've solved the case.
        
            You gather the populace in the village centre once the commotion has died down.
    **[Arrest the attacker]
 //       (if they get this path, they gain half the gold reward and do not get an opinion increase from Local opinions when the quest is completed)
        {advancetime(30,0,0,0)}You manage to restrain the attacker. You tie them to a nearby tree as they rave about how the victim deserved it. You don't have time to do anything else right now, and would rather not step on the toes of whoever decides punishment in this town, anyway. For now, at least, they've been subdued.
        
        You gather the populace in the village centre once the commotion has died down.

-(introduction)
{advancetime(30,0,0,0)} "I am a Vigile of the Roman Legion. I have been asked here by Chieften Boabaird to put an end to these robberies."

The crowd watches you with suspicion.
-(introqs)
*"How many people have been robbed?"
    {advancetime(30,0,0,0)}"Near the whole village!" a woman cries, "that's whys we think we're so close to finding the culprit." She eyes a number of individuals in the crowd who look sheepishly away.
    ->introqs
*(whenrob)"When was the last robbery?"
    {advancetime(30,0,0,0)}"Last night." the blacksmith says, muscular arms crossed against a big barrelled chest. "They took a number of my tools." His voice is calm, but you can see anger behind his eyes.
    ->introqs
*{whenrob}"Can I take a look at the smithy, see if I can spot anything?" 
    {advancetime(30,0,0,0)}"Of course." The blacksmith says, leading you to their shop.

    You enter and find the shop in a state of disrepair, tools are scattered  about the place, bronze and copper bars littered across the floor. The forge itself has been vandalised, leaving the blacksmith without a means to continue to work.
    ->smithy

=smithy
*"What was taken?"
    {advancetime(30,0,0,0)}The blacksmith sighs and looks around the shop.
    "From what I've discovered missing so far; a few tools, some ingots and a couple of knives and daggers. They also took my savings. I'd hidden a couple dozen denarii under the floor boards behind the counter. They managed to find that.

    **(shopstate)"Shop's quite a state. You didn't hear anything? Wake up?
        {advancetime(30,0,0,0)}"I'm a heavy sleeper." the blacksmith says annoyed at your accusitory tone. "Plus I take herbs... To help pass the nights."
        ->smithy

*[Investigate the shop]
{advancetime(30,0,0,0)}You look around. It's hard to say what may have been tampered with during the burgulary.
-(invsmithy)
    *(smithycounter)[Investigate behind the counter]
        Heading behind the counter you easiliy notice the floorboard that has been ripped up, the space beneath is empty. looking some more you see a ledger of items that have been bought and sold over the last couple of weeks. You see a large number of ingots was bought around a week ago.
    ->invsmithy
    
    *(smithyfloor)[Investigate the shop floor]
        Looking around you feel as though there's not much to gain from the mess, the chaos seems as though it was a part of the burgulary, the mess wasn't made in the search for items to steal but either out of malicious intent or for some other means.
    ->invsmithy
    
    *(smithyforge)[Inspect the forge]
        You take a closer look at the vandalised forge, bricks have been broken or removed from the structure, you note a small insignia on some of the exposed bricks.
    ->invsmithy
    
    *(smithybedroom)[Investigate the bedroom]
        You enter the bedroom; it is untidy, but clearly not ransacked as the rest of the shop as been. looking around the room briefly you see not much of import, aside from the bowl of sleeping herbs next to the bed.
    ->invsmithy
    +{(smithycounter || smithyfloor || smithyforge || smithybedroom) && (not asksmithycounter || not asksmithybedroom || not asksmithyforge|| not asksmithyfloor)}[Ask the blacksmith something]
        
        **(asksmithycounter){smithycounter} "I found a ledger detailing the purchase of a number of ingots."
            {advancetime(30,0,0,0)}"Yeah, what of it?" the blacksmith asks, arms crossed.

            "Did you buy them all from the same source?"

            "Yes, the village's general store. Marcia gets all manner of goods shipped to town. It's very handy.
        ->invsmithy

        **(asksmithybedroom){smithybedroom} "What are the sleeping herbs in the bedroom for?"
            {advancetime(30,0,0,0)}{shopstate:Annoyed at the question the blacksmith responds, "I've told you already, I struggle to sleep."|"I struggle to sleep at nights, I use sleeping herbs to help with that. they put me in a deep slumber."}
            ->invsmithy

        **(asksmithyforge){smithyforge} "Do you know what those insignia on the brick works of the forge are?"
            {advancetime(30,0,0,0)}"Those? They're artisan's symbols. Usually used to signify whose work it is. On the brick work it would be the mason that made the bricks."

                ***(knowssaoir)"Who's the mason?"
                    {advancetime(30,0,0,0)}"Saoir. I can take you to him if you want."
                
                    ****"Do you mark your work in such a way?"
                    {advancetime(30,0,0,0)}"Course I do." He picks up a tool from the ground. "This here's my mark. I put them on the base of the hande or top of the head, depends what kind of tool you're looking at." he says proudly. The symbol is that of a hammer striking an anvil, sparks flying in all directions.
                    ->invsmithy
                    
        **(asksmithyfloor){smithyfloor}"Has every theft been left with a mess like this?"
            {advancetime(30,0,0,0)}"As far as I'm aware yes. Every time someone is robbed the place has been turned over looking for things."
            ->invsmithy
        ++  ->
            You have nothing to ask, so you continue to look around. ->invsmithy
    +[Accuse the blacksmith of the thefts.]
        Are you sure?
        **[Yes]
            ~ arrestsuspect = "blacksmith"
            ->arrest
        ++[No]
            ->invsmithy
    +{knowssaoir}[Ask the blacksmith to take you to the mason] {advancetime(0,10,0,0)}
        {!The blacksmith takes you to Saoir. They are working in their shop when you enter. The heat of the kiln hits you, a stark contrast to the cold air outside.|}
        You greet Saoir.
            ->masonry
    +{asksmithycounter}[Ask the blacksmith to take you to the general store] {advancetime(0,10,0,0)}
            {generalstore:->generalstore.invstore|->generalstore}

=masonry
*"Have you been robbed?"
    {advancetime(30,0,0,0)}"I have. Would have been about a week ago. They took a number of my bricks, as well as my clay and coal for the kiln."
        **"Where do you buy your clay and coal?
            {advancetime(30,0,0,0)}"The general store of course. They sell all manner of raw materials, as well as food and supplies."
                ->masonry
*"Where were you last night?"
    {advancetime(30,0,0,0)}"Probably in my home asleep. I don't know what time the robbery took place."
        **"Is there anyone who can confirm this?"
            {advancetime(30,0,0,0)}"Unfortunately not, I live alone."
                ->masonry

*{lookmasonry && smithy.smithyforge}"Why do you have bricks marked with the same insignia as on the blacksmith's forge?"
    {advancetime(30,0,0,0)}"Because that's my artisan's mark. I made the bricks that are used in the blacksmith's forge and marked them to show I was their creator. These bricks are new and marked the same way."
        ->masonry

*(lookmasonry)[Ask to look around the shop.]
He agrees to let you look around. You find little of import to the case. There are bricks marked with the same ensignia as on the blacksmith's forge.
        ->masonry

+[Accuse Saoir of the thefts.]
    Are you sure?
        **[Yes]
            ~ arrestsuspect = "Saoir"
            ->arrest
        ++[No]
            ->masonry
+[Return to the smithy] {advancetime(0,10,0,0)}
    ->smithy.invsmithy
+[Go to the general store]
    {generalstore:->generalstore.invstore|->generalstore}


=generalstore
{!The blacksmith takes you to the general store. Marcia is working behind the counter when you enter. You greet her.|}

*"Mind if I have a look around the store?"
    {advancetime(30,0,0,0)}"Go ahead."
-(invstore)
    *(storestock)[Investigate the items in stock]
        You look around the shop, seeing a number of things on sale. Foodstuffs and  supplies as well as raw materials for crafting. You see bronze and copper ingots, clay, sand, and some wood and stone too. She is well stocked in everything.
    ->invstore
    
    *(storestoreroom)[Investigate the storeroom]
        You take a look in the store room, there is plenty stocked in here, you see most of what is in here is well stocked in the shop itself, though there are a few tools and other items in here.
            **(storetools)[Investigate the tools]
                You pick up a few of the tools and inspect them closely {smithy.asksmithyforge:, looking specifically for the blacksmith's mark. you find it on each of them}. There are around 10 tools, some are the same types of tools as others in the stockpile.
                ->invstore
    ->invstore

    +{storestock || storestoreroom}[Ask Marcia something]
        
        **"Has the store been robbed?"
            {advancetime(30,0,0,0)}"It has. It was three days ago in fact."
            ***{storestock}"You managed to restock quickly, then."
                {advancetime(30,0,0,0)}She looks at you, but doesn't respond.
                ->invstore
            *** ->invstore

        **"What were you doing last night?"
            {advancetime(30,0,0,0)}"I was at home. I'm sure anyone you ask in the village will have the same answer. I live alone so I don't have anyone who can confirm this for you however."
            ->invstore

        **{storetools}"I saw lots of tools in the stock room, but there's none out here, what are they for?"
            {advancetime(30,0,0,0)}"Personal use. If something breaks or I need to make something I'd rather do it myself than have to ask or pay someone to help me."
                ***[Press further] "And you need multiple of the same tool? They're all from the town blacksmith so I was just wondering why you have so many."
                    {advancetime(30,0,0,0)}She takes a second to respond. "I like to bulk buy. If one breaks in the middle of a job I don't want to have to go and buy a new one."
                        ->invstore
                ***[Leave it]
                    ->invstore
        ++  ->
            You have nothing to ask, so you continue to look around. ->invstore
+[Accuse Marcia of the thefts.]
    Are you sure?
        **[Yes]
            ~ arrestsuspect = "Marcia"
            ->arrest
        ++[No]
            ->generalstore.invstore
+[Return to the smithy] {advancetime(0,10,0,0)}
    ->smithy.invsmithy
+[Go to the mason's]
    ->masonry
->DONE

=arrest
{arrestsuspect == "Saoir": You know it was Saoir that did it. Your authority in this matter cannot be questioned. You arrest Saoir and announce to the town their troubles are over.}
{arrestsuspect == "blacksmith": You know it was the blacksmith that did it. Your authority in this matter cannot be questioned. You arrest them and announce to the town their troubles are over.}
{arrestsuspect == "Marcia": You know that Marcia commited the crimes. She knew who had bought raw materials from her. She was taking them back and reselling to those she had stolen from, making a mess of the crime scene  and stealing extra so it was unknown exactly what was taken.}
The town will deal with this criminal {intro.wait:and the attacker from earlier }as they see fit, by the laws of their people. You leave the settlement and get back on the road.
->MAP

===CrannForest===
{justbeenhospital == false && playerlocation !="Crann":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "Crann"
->endoconvocheck->
    
{!There are no well-trodden paths through Crann Locháinín. You make your way under ash and beech and yew and pine until the border of the forest is far behind you. The sun is {HOUR <= 8:rising}{HOUR > 8 && HOUR < 18:lingering}{HOUR >= 18: falling} above the canopy, casting light through the gaps between branch and leaf. ->search|}

=search
*(woods)[Search the woods.] 
{advancetime(0,0,1,0)}
    You spend a good deal of time passing through the glades, weaving as steady a path as you can manage between the trees.{DAY >= 25 && MONTH == 1: In a clearing you find signs of a camp, the firepit still ashen and dead branches broken from the trees for firewood, now no more than charcoal. Someone is out here beyond doubt.}{MONTH != 1: You see nothing to suggest anyone has passed through here recently, though - only week-old remnants of a campsite, the firepit long since burnt out, show anyone was here at all.}
    {HOUR <18:->search}
    {HOUR >=18:->conclude}
*(flowers)[Note the flowers.] 
{advancetime(0,0,1,0)}
    You notice Vervain, of course, and more besides. It’s fast approaching spring, but even so it’s odd how each footfall lands on a new flower, and how the flowers spring back as you continue, masking your steps. You won’t be able to track effectively in these conditions.
    {HOUR <18:->search}
    {HOUR >=18:->conclude}
*(trees)[Inspect the trees.] 
{advancetime(0,0,1,0)}
    Some of the trees bear symbols, carved into the bark. You recognise the triquetra, a three cornered knot. It likely bears some ritual significance beyond your knowledge, but it’s a sure sign you’re on the right trail.
    {HOUR <18:->search}
    {HOUR >=18:->conclude}
*{HOUR < 18 && woods && flowers && trees}[Continue searching.] 
    ~ HOUR = 18
    You continue to investigate woodlands of Crann Locháinín until the sun gets low in the sky, but find nothing more of note.
        ->conclude

=conclude
    It seems you have found all you will while the sun still sheds enough light to see, and that you can only report back to Chief Bobaird a confirmation of his subjects’ suspicion.
    *[Leave Crann Locháinín]
        The sun sets in the west, and the forest’s border is eastwards. It should be no hard task to walk with your lengthening shadow forwards until you reach more familiar environs. 
            **Stop.
                ***Did you hear that?
                    Branches breaking, footsteps that are not your own. All manner of beasts might haunt and hunt here, and none you wish to meet.
                    ****[Walk faster] You pick up your pace, struggling not to stumble over roots and weeds in the increasing dark. You cast your eyes behind you and see nothing: there is nothing ahead of you either, nor to the left, nor right.
                        *****[Faster still]Caution to the wind, you break into a jolting sprint, leaping through the undergrowth. You will not die here, you will not
                            ******<strong>THUD</strong>
                                You run straight into something. It’s not a tree because as you fall, so does it. You gasp and yell, and it releases a string of curses in Gaelic. 
                                    *******[...]# CLEAR
                                        ->senses
                                
=senses
*[Come to your senses]
    Three specks of piercing orange light coalesce into torches carried by hooded and robed figures. You can’t make out faces, except for one: the girl you ran into, who is picking herself up from the ground, and spins round towards you with fierce intent. Her accent is thick, but you can make out enough of it if you try.
    **[Look at her]
        She’s rather beautiful, you realise. Red hair and soft, fair skin. Sharp eyes. Light from the torches dances across her features. And she’s talking to you. By Hercules, she’s talking to you and you haven’t heard a word of it. You’re a fool and you’re probably about to die.
        
        You have just enough wits about you to know to splutter your reply in Gaelic, but from the looks of your hooded friends you might as well have spoken Greek. "{cap_pronoun(PRONOUN1)} must have hit {PRONOUN3} head," one figure declares. And, suddenly, you are being lifted to your feet.
            ->lookit
    **[Focus on the words]
        You are not fluent in Gaelic, but you know enough to get you through this, you’re sure. You let her berate you without interruption, then realise she’s asking you a question: Who are you? What are you doing out here?
            ->whatdoing
            
=lookit
*[Try to leave]
    You turn to go, but feel a hand quickly and firmly on your shoulder. "Wrong way, friend."
        ->lookit
*[Stay still]
~ knowcaitrionaname = true
"It’s okay, stranger," the woman says. "My name’s Caitriona. I’ll see ye right."
        ->cultistcamp

=whatdoing
*[Lie]
    It’s not too much of a stretch. You got lost in the woods, that part’s even true, whilst looking for... the camp, of course. These people must be going somewhere, so you pretend you’re going there too.
    They seem to believe you. Maybe. It’s hard to tell with the hoods. But they aren’t moving to hurt you. Yet, at least. 
    "Come with us," one of them says, and you realise you don’t really have a choice in the matter, so you follow them back deeper into Crann Locháinín.
        ->cultistcamp
*[Tell the truth]
    If you are to die, you are to die an honest man. A Vigile. A servant of Rome. They probably won’t take kindly to this. Are you sure?
        **Moriuntur Omnes. All men must die.
            ->SulisTemple.Sacrifice_Ending
        **Volo vivere! I want to live!
            ->whatdoing

*[Try to leave]
    This is bad, and not where you intended to be. You get up and turn to leave, but each way you turn the hooded figures hem you in. You can’t run, not unless they choose to let you go.
            ->whatdoing
            
=cultistcamp
{knowcaitrionaname == true:Caitriona|The woman} and her hooded friends lead you through the trees, lighting the way with torches until you reach a verdant glade where long tables have been set out. You hear it before you see it, the sounds of perhaps a dozen or so overlapping voices at the feast. Platters of meats and fruit and bread have been laid out, and those in attendance are happily eating their share. Caitriona leads you to a chair, sits, and reaches for an apple. There is a lull in urgent activity and your life doesn’t seem immediately at risk: perhaps now would be a good time to ask your new friend a few questions.
-(askquestions)
    *(where)"Where are you from?"
        "North," she says, as if that’s all the answer you could require. The mischief of her smile tells you she won’t say more.
            {(how && not who)||(who && not how):->2questions->}
            {who && how && where: ->chossachspeech}
            ->askquestions
    *(how)"How much longer do we have to wait?"
        "I’m not sure, but it can’t be too long. In fact, my money would be on us getting told tonight, so just hold on a wee bit longer and we’ll both have the answer."
            {(where && not who)||(who && not where):->2questions->}
            {who && how && where: ->chossachspeech}
            ->askquestions
    *(who)"Who’s that?"
        You gesture towards a table set apart from the others. "That," Caitriona replies, "Is the Chossach. She’s amazing: without her I don’t think much of this would be possible. She got us all together, got all of this food, kept us all safe, and, of course, she’s going to lead everything when the time comes."
            {(how && not where)||(where && not who):->2questions->}
            {who && how && where: ->chossachspeech}
            ->askquestions

=chossachspeech
The glade bursts into clamour, fists hammered against the wood tables and voices raised to cheer and shout. The Chossach has risen from their seat and looks likely to address the adoring crowd. She stretches out her arms, and the noise dies.
	"Welcome, friends, old and new, children of the Old Ways. Too long has the yoke of Roman rule hung from our necks. Too long have our people, our cultures been cast into the flame, and for what? Nothing!
	No longer: no longer. I know you’ve all been very patient, and I thank you all for that, each and every one of you. But now it is finally time. Imbolc dawns upon us, and with it a new hope for a new start, with no rule but our own.
	The invaders think they can steal our land and defile our gods with theirs. This is where we will strike them. Our goddess Sulis has been shackled to their weak goddess Minerva at the temple in Bath. With sacrifices of Roman scum and honoured faithful servants of the true gods, we will free her. And when we do, her vengeance will be fierce."
	
	<strong>END OF GAME</strong>
	->END
	
=2questions
"I think everybody’s here now, it shouldn’t be long until we get a speech," Caitriona says. You don’t have much more time to talk to her.
->->


===Bath===
{justbeenhospital == false && playerlocation != "Bath" && playerlocation != "tavern":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "Bath"
->endoconvocheck->
{not Bath.Bath_Opening: ->Bath_Opening->}

*(searchmacdudd){Mai_Dunn.Boabaird.askagaintattoos}[Search the city for the tattooed man (8 hours)]
    {advancetime(0,0,8,0)}
    ~ daytalktomacdudd = DAY
    You explore the city, taking in the surroundings. Although the city is Roman in design, the closer you look the more you can see influences of Britannia, small establishments built around the Roman structures. More obvious, though, is the people. Many are Celts and people of Brittania - it is obvious in the way they dress and act and how they congregate.
    {DAY <= 27 && MONTH == 1: 
    After some time exploring, you spot something: a tavern, clearly Celtic-run, and you see a few people duck inside. <p></p>Your eyes are immediately drawn to the man with tattoos. It's the man you're looking for. You're sure of it.<p></p>It appears as though there are a number of brutish-looking individuals stood guard at the door, however, seemingly his underlings.<p></p>It is now a matter of how to handle this situation. 
    ~ seesmacdudd = true
    ->BathTavern.GuardsSitch
    }
    {DAY >= 28 && MONTH == 1: 
        Despite your dedication to the search, you find nothing - no trace of the man anywhere. 
        ->Bath
        }
    {MONTH != 1: 
    Despite your dedication to the search, you find nothing - no trace of the man anywhere.
    ->Bath
    }
        
*(find_shop_Bath)[Find a shop (30 minutes)]
    {advancetime(0,30,0,0)}
    You manage to find a local store which has a variety of items for purchase. The owner is Roman.
    ->Bath_Store
+{find_shop_Bath}[Go to the store]
    ->Bath_Store
+[Open map]
    ->MAP
=Bath_Store
{Bath_Store >=2: You return to the store.}
{LEGIONOP == LEGIONOP.positive || LEGIONOP == LEGIONOP.great: Your {LEGIONOP} relationship with the legion has encouraged the shopkeeper to discount your prices{LEGIONOP == LEGIONOP.positive: slightly}, in honour of your service.}
{LEGIONOP == LEGIONOP.negative || LEGIONOP == LEGIONOP.poor: Your {LEGIONOP} relationship with the legion has caused the shopkeeper to dislike you, increasing your prices{LEGIONOP == LEGIONOP.negative: slightly}.}
{opinoncheck("legion")}
//{pricemod}
Supplies{Bath_Store <=1: (a day's rations)}: {INT(SUPPLIESPRICE*pricemod)} {pricemod >=1: denarii} {pricemod <1: denarius} each

Sleeping herbs{Bath_Store <=1: (enhances quality of sleep requiring less time resting)}: {INT(HERBSPRICE*pricemod)} denarii each

Cakes{Bath_Store <=1: (can temporarily improve a person's opinion of you)}: {INT(CAKEPRICE*pricemod)} denarii each

{horserent == false && hashorse == false:Rent a horse{Bath_Store <=1: (only lasts for your next journey)}: {INT(HORSERENTPRICE*pricemod)} denarii}
{horserent == true: You have already rented a horse for your next journey.}

You have {hasmoney == 0: no money}{hasmoney == 1: 1 denarius}{hasmoney >= 2: {hasmoney} denarii}.

+(make_purchase_bath){hasmoney >= 1}[Make a purchase]
{30secs()}
~temp itemcost = 0
    ++Supplies
    ~itemcost = INT(SUPPLIESPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hassupplies,1)}
            You buy 1 pack of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({INT(SUPPLIESPRICE*pricemod)*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hassupplies,5)}
            You buy 5 packs of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hassupplies,10)}
            You buy 10 packs of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++[Return]
            ->make_purchase_bath
    ++Herbs
    ~itemcost = INT(HERBSPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hasherbs,1)}
            You buy 1 pack of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({itemcost*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hasherbs,5)}
            You buy 5 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hassupplies,10)}
            You buy 10 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++[Return]
            ->make_purchase_bath
    ++Cakes
    ~itemcost = INT(CAKEPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hascake,1)}
            You buy 1 cake. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({itemcost*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hascake,5)}
            You buy 5 cakes. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hascake,10)}
            You buy 10 cakes. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++[Return]
            ->make_purchase_bath
    ++{hasmoney >= INT(HORSERENTPRICE*pricemod) && horserent == false && hashorse == false}[Horse rental ({INT(HORSERENTPRICE*pricemod)} denarii)]
        This will only be good for your next journey, no matter its distance. Continue?
        +++[Continue]
        ~itemcost = INT(HORSERENTPRICE*pricemod)
            {alter(hasmoney,-itemcost)}
            ~horserent = true
            You rent a horse for your next journey. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++[Return]
            ->make_purchase_bath
    ++[Exit the store]
        You thank the shopkeeper for their time and return to the town.
        ->Bath
+[Exit the store]
        You thank the shopkeeper for their time and return to the town.
        ->Bath
=Bath_Store_CHOICE
+[Make another purchase]
    ->Bath_Store
+[Exit the store]
    You thank the shopkeeper for their time and return to the town.
                    ->Bath

=Bath_Opening
You approach the Roman city of Bath, the grand structures are a welcome sign of civilisation in the colonies of Britannia. Strong foundations keep the city standing strong against all adversaries.
    ->->
->DONE

===BathTavern===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "tavern"

    
+[Open map]
    ->MAP

=GuardsSitch
 ~knowstavern = true
 ~ playerlocation = "tavern"
*(talkguards)[Talk to his soldiers and get them to leave you some time alone with their boss]
    {30secs()}
    You approach the soldiers outside the inn, the tattooed man somewhere inside. They watch you as you approach, hands fingering various Celtic weapons, eyes full of menace.

    "What do you want?" one of them asks. Another says something in an unfamiliar tongue and the rest laugh.
        **(threatenguards)[Threaten them]
            {30secs()}
            "The legion knows of your crimes. I now know your faces. Let me through or you will be hunted down and crucified for your crimes."

            Some of the brutes look alarmed by this but the one clearly in charge of the bunch laughs bitterly.

            "The legion won't touch Bath. They don't want to piss off any of its little citizens. On top of that, by the time they track us down, we'll be beyonD the reach of the legion. You didn't build a wall for no reason. Now get out of here before we kill you."
            
            You leave the group of thugs behind and decide to wait for another oportunity to make a move on the individual.
                ->Fail_day1
        **(persuadeguards)[Persuade them]
            {30secs()}
            "I know of your crimes. I'm sure you all know the punishment for non-citizens when they commit a crime against Rome. I am, however, willing to overlook this, as your leader is the one person I need. Leave now and your crimes will be forgiven."

            The thugs look at one another for a few moments. A few short sentences pass in their strange tongue. Then, without another word, they walk away from the door.

            You enter the tavern and ask the innkeeper what room the tattooed man is staying in, your authority overriding any loyalty they might have. When you enter, the man is in the midst of looking over a map of the area. There are markings on particular places on the map. He turns, shocked to see you.

            "How did you get in here?" he asks.

            "That's not important. I am a Vigile, your thugs have left you and right now you have two options. Talk to me here and now. Or talk to the legion on the rack."

            He takes a moment to consider before responding, "Ask what you will," his voice beaten.
                ->Macdudd_Invite

*(talkman)[Wait to talk to the man when he is away from the thugs (6 Hours)]
    {advancetime(0,0,6,0)}
    You wait for your moment. When you see him exit the tavern, alone, you follow and approach the tattoed man while he is away from his thugs.

    "What do you want?" he asks suspiciously.
    **(threatenman)[Threaten him into giving you information] 
        {30secs()}
        "I am a Vigile of the Roman Legion. I know of your crimes and we know your face. We will not stop hunting you until you are found and crucified for your crimes. You will tell me what you know and maybe you'll have a chance at the arena instead."

        The man looks at you for a short time. Then he laughs. 

        "The Roman Legion will never come to Bath. It doesn't want to upset the citizens. Now piss off and leave me alone before I cut your throat."
        
        He looks like he means it. You leave the man, hoping there may be some other way to get your information.
        ->Fail_day1

    **(persuademan)[Offer him a deal to convince him to give you information]
        {30secs()}
        "I am a Vigile of the Roman Legion," you say. "I know of your crimes and I'm sure you know the punishments. I am willing to forgoe punishment in exchange for aid. Tell me what you know and you are free to leave Bath, and head back beyond Hadrian's wall."

        The man watches your face for any sign of deception or trickery.

        "Follow me," he says.
            ***[Follow him]
                {30secs()}
            The man leads you back to the tavern and waves away his thugs as you enter behind him. He takes you upstairs to his room.

            "Ask away," he says.
                ->Macdudd_Invite
            ***[Don't follow him; find another way to get the information]
            You don't think you can trust this man, whoever he is. You decide to get your information from somewhere else. It's not worth the risk.
            ->Fail_day1
=Macdudd_Invite
*"Who are you?"
    {30secs()}
    "My name is Macdudd. I am from Pictland and I was hired to abduct people" He says. 

    You watch him for any sign of dishonesty but he seems to have given up any semblance of resistance.
    ->Macdudd_Invite
    
*(macduddboss)"Who do you work for?"
    {30secs()}
    "I have been hired by druids." He pauses to gage your response. You are shocked by this information and try not to show it. There should be no druids within the borders of Rome.

    "One in particular has been working with me to aid me with the abductions."
        **"Druids?"
            {30secs()}
            "I don't know too many of them. But I work for Chossach. They are recruiting more druids for the ritual."
            ->Macdudd_Invite

*"Why are you abducting people?"
    {30secs()}
    "The druids need them for their ritual. I believe they are planning to sacrifice them." 

    This is shocking news. Not only are people being sacrificed it appears to be for some druid ritual. The consequences of which are difficult to understand or comprehend.
    ->Macdudd_Invite

*"Why are there plants at every abduction site?"
    {30secs()}
    "The Vervain is a side effect of the druids and their magic. It has some link to the ritual being planned." He says this calmly and without blinking an eye, even while talking of druids and magic and other absurd things. You still believe he is telling the truth, however.
    ->Macdudd_Invite
    
*  -> Macdudd_Ritual
        
=Macdudd_Ritual
    "Tell me about the ritual."
        {30secs()}
        "A ritual of rebirth for the spring festival, Imbolc. I do not know what the ritual will accomplish. That's all I know."

    Imbolc is soon. The evening of the first day of Februarius. That doesn't give long to discover what the ritual is for and where it taking place.
    
    This lead has proved to be very useful. You have a deadline to meet before the ritual and have discovered a much wider plot than you first realised. The next place to look should probably be after the druids. Perhaps looking into the Vervain plants more will lead you in the right direction, but for now, you rest after a long day.
    ~ DAY = daytalktomacdudd + 1
    ~ HOUR = 6
    ~ MINUTE = 0
    ~ SECOND = 0
    ->Bath
    

=Fail_day1
You decide to wait a day, hoping for more luck, and spend your time before sleep wandering the streets.
{hassupplies >=1:
    You've gone through one pack of supplies today. {alter(hassupplies, -1)} You have {hassupplies} left.
                ~ starving = 0
    - else:
        {alter(starving, 1)} You go to sleep hungry and thirsty, though, as you have no supplies. It is your {print_day(starving)} day without food and drink.
}
    ->starvecheck2->
    
    When you return to the tavern, you find the men outisde missing, and enter freely.
    *[Ask the innkeeper where they are] 
        {30secs()}
        "Is the tattooed man still here?" you ask the innkeeper.

        "Him and his men left in the night," he responds.
        **[Ask the innkeeper questions about the man]
            {30secs()}
            "I'm a Vigile of the Roman legion," you tell the man. "Mind if I ask a few questions about the tattooed man?"

            "Of course I'll tell you everything I can."
            ->inkeep_macdudd_qs
        **[Ask if you can investigate his room]You ask to investigate his room.
            ->investigate_macdudd_room
=inkeep_macdudd_qs
    *(askmacduddname)"Do you know who he was, his name, his job - anything?" 
        {30secs()}
        "His name was Macdudd. I'm not too sure where he was from but he seemed to be from north of the wall. I might say Pictish?" He stops to think for a moment.

        "As for his job, I couldn't say, but if his thugs gave any clue, I would say he's in a violent one."
        ->inkeep_macdudd_qs
    *(invmacduddmeetings)"Did he ever meet with anyone?" 
        {30secs()}
        "Aside from his goons I'm not sure. He did often leave the establishment alone and come back an hour or so later. Could be he was meeting with someone then, but never here."
        ->inkeep_macdudd_qs
    *{not investigate_macdudd_room && askmacduddname && invmacduddmeetings} You ask the innkeeper if you can investigate Macdudd's room.  ->investigate_macdudd_room
    * -> 
        You thank the inkeeper for their time and continue on your way. ->Bath
=investigate_macdudd_room
"Of course." The man says. He leads you up to the room and lets you in.
You stand in the room and take in your surroundings. There is an uncomfortable looking straw bed at one end of the room. A wardrobe in another corner. Next to the wardrobe is a table, a fallen chair under it. At the foot of the bed is a chest. The room looks as though it was left in a hurry.
-(opts)
    *(invmacduddbed)[Investigate the bed] 
        {advancetime(0,3,0,0)}
        You look in and around the bed. While it is a mess there appears to be no trace left behind of {askmacduddname: Macdudd|the man}.
        ->opts
    *(invmacduddwardrobe)[Search the wardrobe] 
        {advancetime(0,3,0,0)}
        You open the wardrobe. It is empty. Nothing has been left behind. You check for a false panel, a loose bit of wood and find nothing. That is until you are about to close the door. on the edge of the door is inscribed a tiny rune denoting the month of Februarius.
        ->opts
    *(invmacduddtable)[Investigate the table] 
        {advancetime(0,3,0,0)}
        Looking around the table you find very little. You are about to give up looking when you see a small plant sprouting from behind the table. Vervain.
        ->opts
    *(invmacduddchest)[Open the chest] 
        {advancetime(0,3,0,0)}
        You open the chest. Inside is a scrap of parchment, overlooked in the clearing. It is a portion of map that shows highlighted areas. They link to ones you already know people to have been abducted.
        ->opts
    *{not inkeep_macdudd_qs && invmacduddbed && invmacduddwardrobe && invmacduddtable && invmacduddchest} [Ask the inkeeper questions about the man] You ask the innkeeper some questions about the man.  ->inkeep_macdudd_qs
    * -> 
        You thank the inkeeper for their time and continue on your way. ->Bath

->DONE

===SulisTemple===
//{justbeenhospital == false:
//    {arrivaltime(playerdestination)}
//    -else:
//        ~ justbeenhospital = false
//}
//{horserent == true:
//    ~ horserent = false
//}
//    ~ playerlocation = "temple"
    ->DONE
=Sacrifice_Ending
That... didn’t go well. It can’t have, otherwise you wouldn’t be in a cage right now. You don’t know how long it’s been. Days, perhaps? You’ve drifted in and out of consciousness, the light of day always too bright, the darkness too consuming. There is a constant pain in your skull, pounding. You vaguely remember being struck. More than once, you’d guess, on the road. But here you are.
-(whatshappening)
    *(a)[Where, exactly?]
        You scour your memories of the journey, and look around you for clues as to your location. All you achieve is a sudden ringing in your head and a wave of nauseating pain. You won’t find an answer in your current state.
            ->whatshappening
    *(b)[Who else is here?]
        You’re not alone, that’s certain. You can hear voices, accented voices of Picts or Caledonians, perhaps, speaking Gaelic, of course, too quickly for you to keep track of. No-one is coming to save you. 
            ->whatshappening
    *(c)[How can I escape?]
        Your hands are bound together with rope, as are your feet. Your vision is blurry. Moving too fast brings on nausea. You’re in no fit state to try to escape. Whatever fate is in store for you is one you’ll have to accept.
            ->whatshappening
    *{a && b && c}[Await the end.]
    It may have been minutes or hours, but they come for you. They take you from your cell and lift you to your feet. You are too weak from blood loss and hunger to try to resist, even when the acrid scent of fresh-spilt blood hits your nostrils. Even when you hear the spiralling song of the druids echoing about the desecrated temple you are led to. Even as you see the glint of the ritual dagger. Even as you feel it pierce your chest, you do not struggle. If you had hoped for a noble end, this is not it. You splutter and cough blood. The song rises around you, chanting now heard underneath and above it. You die in the same moment that reality is torn open. 
    At least your death was not insignificant...
    <strong>Your death has doomed us all.</strong>

<strong>END OF GAME</strong>

->END

===Noviomagus_Reginorum===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "NR"
->endoconvocheck->

+[Go to the store]
    ->NR_Store
+[Travel to the governor's villa]
        ~ playerdestination = "villa"
    ->MAP_continue
+[Open map]
    ->MAP
=NR_Store
You return to the store.
{LEGIONOP == LEGIONOP.positive || LEGIONOP == LEGIONOP.great: Your {LEGIONOP} relationship with the legion has encouraged the shopkeeper to discount your prices{LEGIONOP == LEGIONOP.positive: slightly}, in honour of your service.}
{LEGIONOP == LEGIONOP.negative || LEGIONOP == LEGIONOP.poor: Your {LEGIONOP} relationship with the legion has caused the shopkeeper to dislike you, increasing your prices{LEGIONOP == LEGIONOP.negative: slightly}.}
{opinoncheck("legion")}
//{pricemod}
Supplies{NR_Store <=1: (a day's rations)}: {INT(SUPPLIESPRICE*pricemod)} {pricemod >=1: denarii} {pricemod <1: denarius} each

Sleeping herbs{NR_Store <=1: (enhances quality of sleep requiring less time resting)}: {INT(HERBSPRICE*pricemod)} denarii each

Cakes{NR_Store <=1: (can temporarily improve a person's opinion of you)}: {INT(CAKEPRICE*pricemod)} denarii each

{horserent == false && hashorse == false:Rent a horse{NR_Store <=1: (only lasts for your next journey)}: {INT(HORSERENTPRICE*pricemod)} denarii}
{horserent == true: You have already rented a horse for your next journey.}

Buy your own horse: {INT(HORSEBUYPRICE*pricemod)} denarii

You have {hasmoney == 0: no money}{hasmoney == 1: 1 denarius}{hasmoney >= 2: {hasmoney} denarii}.

+(make_purchase_nr){hasmoney >= 1}[Make a purchase]
{30secs()}
~temp itemcost = 0
    ++Supplies
    ~itemcost = INT(SUPPLIESPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hassupplies,1)}
            You buy 1 pack of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({INT(SUPPLIESPRICE*pricemod)*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hassupplies,5)}
            You buy 5 packs of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hassupplies,10)}
            You buy 10 packs of supplies. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++[Return]
            ->make_purchase_nr
    ++Herbs
    ~itemcost = INT(HERBSPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hasherbs,1)}
            You buy 1 pack of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({itemcost*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hasherbs,5)}
            You buy 5 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hassupplies,10)}
            You buy 10 packs of herbs. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++[Return]
            ->make_purchase_nr
    ++Cakes
    ~itemcost = INT(CAKEPRICE*pricemod)
        +++{hasmoney >= itemcost} [1 ({itemcost} {itemcost >=1: denarii}{itemcost <1: denarius})]
            {alter(hasmoney,-itemcost)}
            {alter(hascake,1)}
            You buy 1 cake. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*5}[5 ({itemcost*5} denarii)]
            {alter(hasmoney,-itemcost*5)}
            {alter(hascake,5)}
            You buy 5 cakes. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++{hasmoney >= itemcost*10}[10 ({itemcost*10} denarii)]
            {alter(hasmoney,-itemcost*10)}
            {alter(hascake,10)}
            You buy 10 cakes. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++[Return]
            ->make_purchase_nr
    ++{hasmoney >= INT(HORSERENTPRICE*pricemod) && horserent == false  && hashorse == false}[Horse rental ({INT(HORSERENTPRICE*pricemod)} denarii)]
        This will only be good for your next journey, no matter its distance. Continue?
        +++[Continue]
        ~itemcost = INT(HORSERENTPRICE*pricemod)
            {alter(hasmoney,-itemcost)}
            ~horserent = true
            You rent a horse for your next journey. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
    ++{hasmoney >= INT(HORSEBUYPRICE*pricemod) && hashorse == false}[Buy your own horse ({INT(HORSEBUYPRICE*pricemod)} denarii)]

        +++[Continue]
        ~itemcost = INT(HORSERENTPRICE*pricemod)
            {alter(hasmoney,-itemcost)}
            ~horserent = true
            You rent a horse for your next journey. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->NR_Store_CHOICE
        +++[Return]
            ->make_purchase_nr
    ++[Exit the store]
        You thank the shopkeeper for their time and return to the town.
        ->Noviomagus_Reginorum
+[Exit the store]
        You thank the shopkeeper for their time and return to the town.
        ->Noviomagus_Reginorum
=NR_Store_CHOICE
+[Make another purchase]
    ->NR_Store
+[Exit the store]
        You thank the shopkeeper for their time and return to the town.
        ->Noviomagus_Reginorum


===Fishbourne_Palace===
{justbeenhospital == false && playerlocation != "villa":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "villa"
->endoconvocheck->
+[Speak to the governor]
    ->speakgovernor
+[Return to {NR}]
    ~ playerdestination = "NR"
    ->MAP_continue
+[Open map]
    ->MAP

=speakgovernor
The governor is in his study, awaiting your news.
-(updates)
*{Mai_Dunn.Boabaird_Opening && not Mai_Dunn.Boabaird.askagaintattoos}"I have spoken to Chief Boabaird, who will inform me if any of his people spot the man with tattoos from before."
        {30secs()}
        He graces you with a single, disdainful look, before turning his gaze back to his papyrus. "I don't need to be told you're waiting for something, Vigile. Come back after you get information."
        ->updates
        
*{Mai_Dunn.Boabaird.askagaintattoos && not Bath.searchmacdudd}"Chief Boabaird's people have found the tattooed man in Bath."
    {30secs()}
    He sighs. "Well, what are you waiting for? I'm not paying you to tell me things, I'm paying you to get things done."
            ->updates
            
*{Bath.searchmacdudd && not BathTavern.GuardsSitch}"I searched Bath but could not find the tattooed man anywhere."
    {30secs()}
    The governor closes his eyes and rubs his forehead. "What are you doing here, then? Find him!"
            ->updates
            
*{BathTavern.Fail_day1}"I found the tattooed man in Bath, but he escaped my grasp. The innkeeper from where he was staying was very helpful, though; the man's name is Macdudd, and in his room was {MD_Forest.Heliwr_Vervain: some vervain|the strange plant}, a rune for Februarius, and a map with abduction sites marked. They are definitely linked."
    {30secs()}
    He pauses his scribing, a rare act for him, and peers at you. "This is good, but not as much as I'd hoped. I'll pay you half of what I offered, and the rest if you actually find him at some point, preferably before whatever they have planned."
    He gives you 6 denarii and 3 more days' supplies. {alter(hasmoney,6)}{alter(hassupplies,3)}
        ->updates
        
*{BathTavern.Macdudd_Invite}"I found the tattooed man in Bath and convinced him to give me information. The man's name is Macdudd; he was hired by druids, one named Chossach in particular, for help with abducting people for a ritual sacrifice on Imbolc, the first of Februarius."
    {30secs()}
     He pauses his scribing, a rare act for him, and stares at you. "So my nephew, whom you so dutifully hunted down for me, could have been a sacrifice for some backwater Celts and their heretical holiday? Thank Iuno Sospina you found him and the others in time. This is certainly deserving of your salary."
        He waves at a clerk to get you your 12 denarii and 6 days' supplies. {alter(hasmoney,12)}{alter(hassupplies,6)}
        "Make sure you keep investigating, Vigile. A heretical organisation this widespread does not bode well for Roman rule here.
     ->updates
     
+[Excuse yourself from his presence]
    ->Fishbourne_Palace

->DONE


===failstate_toolate===
You are too late. A crash of thunder breaks across the skies, and an arcing beam of light, too bright to look at directly, descends upon Bath.
Buildings are left in ruin, their foundations torn from the earth. Blood runs in rivers down the city streets.
The screams are ceaseless, but they can scarcely be heard over the otherworldly laughter of the vengeful, awoken goddess.
Sulis has been reborn into this world, and you are among her enemies.
The only hope that remains is the hope for a quick death.

<strong>END OF GAME</strong>
->END
