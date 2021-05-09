INCLUDE variables
INCLUDE functions
INCLUDE map n sleep
INCLUDE journal




# title: Vigile
# author: Seeing Stone Games

VAR DEBUG = true

{DEBUG:
	IN DEBUG MODE!
	+	[Opening]	
	    -> Opening
	+   [Skip opening for map check]
	    ~playerlocation = "MD"
	    {advancetime(0,2,0,0)}
	    ->MAP
	+   [Boabaird 2]
	    ~playerlocation = "MD"
	    {alter(hassupplies, -2)}
	    {advancetime(0,0,0,2)}
	    ->Mai_Dunn.Boabaird_2
	    
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

Your <strong>journal</strong> is where you keep information relating to the cases you've solved and are investigating, as well as the clues you've discovered.

You were tasked with the return of governor Sallustius Lucullus' nephew. In finding him, you uncovered the abduction was much larger than expected. People have been going missing from surrounding villages.

Your only lead to continue this case is the description of a suspicious individual: a man, tattooed, in the old Celtic style for war.

+[Continue]

    You travel to Mai Dunn, a large hillfort that commands over the surrounding countryside. It is ruled by Chief Boabaird, a Roman sympathiser and someone you have helped in the past.
 
You enter the hillfort and approach the seat of power. Chief Boabaird stands and approaches, greeting you graciously.

"What can I do for you?" he asks.
    -> Mai_Dunn.Boabaird_Opening



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
->DONE

===Fishbourne_Palace===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "villa"
->DONE

===Mai_Dunn===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "MD"
You return to Mai Dunn.
+{not Boabaird_Opening}[Approach Boabaird]
    ->Boabaird_Opening
+{Boabaird_Opening} [Approach Boabaird]
    ->Boabaird_2
+[Open map]
    ->MAP
->DONE
=Boabaird_Opening
*(Boabaird_Ask_Tattooed)[Ask about the tattooed man] You ask about the tattooed man.
    The chieftan takes a moment to consider your description. You see him deliberating something, an internal conflict of some kind you think. Finally he seems to decide,
    "From the description you give me, I would say they are most likely from the tribes north of Hadrian's wall. Most likely linked with Pictish or Caledonean relations."
    -> Boabaird_Opening

* {Boabaird_Ask_Tattooed} [Ask if he knows of, or has heard of the location of this individual] {30secs()}You inquire further.
        Chief Boabaird shakes his head.
    "Unfortunately I have not heard of such an individual. However," he quickly adds as he sees your look of resignation, "Someone such as this will stand out. I will have my people keep a lookout for him."
     -> Boabaird_Opening
* {Boabaird_Ask_Tattooed} [Ask why he seemed to hesitate] {30secs()} You ask why he seemed to hesitate.
    You think you see the chieftan flush with shame, or possibly anger, the redness of his skin almost hidden by his vast tangle of hair.
    "If I am honest with you, Vigile. I wasn't sure I could trust you. But you have proven that you can do good for my people."
    -> Boabaird_Opening
*(Boabaird_Ask_Job)[Ask if he has any more jobs for you] You ask if he has more jobs for you. {30secs()} 
    "A nearby village of mine, about half a day from here, has come to me with a problem," he says gravely.
    "There have been a spring of robberies throughout the village. Tensions are high as neighbour blames neighbour and I believe it is only a matter of time before someone is attacked, or killed, even. I believe the situation could do with some outside investigation. You hold no bias and will look at the facts objectively."
    -> Boabaird_Opening
+{Boabaird_Ask_Tattooed || Boabaird_Ask_Job} [Thank Boabaird and be on your way] {30secs()} You thank the chief, leaving the hillfort behind you, and continue on the road. 
        ~ playerlocation = "MD"
/// debugging tools
    // {travel_time("NR")}{TRAVELTIME}
    // {advancetime(0,0,0,0)} {whattimeDEBUG()}
    ** [Open map] # CLEAR
        -> MAP
=Boabaird_2
The Chief awaits your return, greeting you graciously when you enter.

"Vigile. What is it you need from me today?"
*[Ask if he has news about the man with tattoos]
    "Do you have news on the tattooed man?" you ask.
    "As a matter of fact I do," the chief says warily. "Some of my people have reported seeing an individual matching your descriptions around Bath. They are not sure how long they will linger there, but the tattooed man is there now."
    **[Thank Boabaird and be on your way.]
        You exit the hill fort again, wondering how long it will be before you are brought back once again by your investigations.
    ->MAP




===MD_Forest===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "forest"
->DONE

===Bath===
{justbeenhospital == false && playerlocation != "Bath":
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "Bath"
{not Bath.Bath_Opening: ->Bath_Opening->}

*{HOUR <= 14}[Explore the city (8 hours)]
    {advancetime(0,0,8,0)}
    {whattimeDEBUG()}
    You explore the city, taking in the surroundings. Although the city is Roman in design, the closer you look the more you can see influences of Britannia, small establishments built around the Roman structures. More obvious, though, is the people. Many are Celts and people of Brittania - it is obvious in the way they dress and act and how they congregate. After some time exploring, you spot something: a tavern, clearly Celtic-run, and you see a few men with tattoos duck inside.
    Your eyes immediately follow on the man with tattoos. It's him. You're sure of it.
    It appears as though there are a number of brutish-looking individuals stood guard at the door, however, seemingly his underlings.
    It is now a matter of how to handle this situation.

        ~knowstavern = true
        ->BathTavern.GuardsSitch
*(find_shop_Bath)[Find a shop (30 minutes)]
    {advancetime(0,30,0,0)}
    You manage to find a local store which has a variety of items for purchase. The owner is Roman.
    ->Bath_Store
+{find_shop_Bath}[Go to the store]

    ->Bath_Store
=Bath_Store
{Bath_Store >=2: You return to the store.}
{LEGIONOP == LEGIONOP.positive || LEGIONOP == LEGIONOP.great: Your {LEGIONOP} relationship with the legion has encouraged the shopkeeper to discount your prices{LEGIONOP == LEGIONOP.positive: slightly}, in honour of your service.}
{LEGIONOP == LEGIONOP.negative || LEGIONOP == LEGIONOP.poor: Your {LEGIONOP} relationship with the legion has caused the shopkeeper to dislike you, increasing your prices{LEGIONOP == LEGIONOP.negative: slightly}.}
{opinoncheck("legion")}
//{pricemod}
Supplies{Bath_Store <=1: (a day's rations)}: {INT(SUPPLIESPRICE*pricemod)} {pricemod >=1: denarii} {pricemod <1: denarius} each

Sleeping herbs{Bath_Store <=1: (enhances quality of sleep requiring less time resting)}: {INT(HERBSPRICE*pricemod)} denarii each

Cakes{Bath_Store <=1: (can temporarily improve a person's opinion of you)}: {INT(CAKEPRICE*pricemod)} denarii each

{horserent == false:Rent a horse{Bath_Store <=1: (only lasts for your next journey)}: {INT(HORSERENTPRICE*pricemod)} denarii}
{horserent == true: You have already rented a horse for your next journey.}

You have {hasmoney == 0: no money}{hasmoney == 1: 1 denarius}{hasmoney >= 2: {hasmoney} denarii}.

+(make_purchase_bath){hasmoney >= 1}[Make a purchase]
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
            {alter(hasmoney,itemcost*10)}
            {alter(hascake,10)}
            You buy 10 cakes. You have {hasmoney == 0:no denarii}{hasmoney == 1:1 denarius} {hasmoney >= 2: {hasmoney} denarii} left.
            ->Bath_Store_CHOICE
        +++[Return]
            ->make_purchase_bath
    ++{hasmoney >= INT(HORSERENTPRICE*pricemod) && horserent == false}[Horse rental ({INT(HORSERENTPRICE*pricemod)} denarii)]
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
    
->DONE

=GuardsSitch

*[Talk to his soldiers and get them to leave you some time alone with their boss]{30secs()}
    You approach the soldiers outside the inn, the tattooed man somewhere inside. They watch you as you approach, hands fingering various Celtic weapons, eyes full of menace.

    "What do you want?" one of them asks. Another says something in an unfamiliar tongue and the rest laugh.
        **[Threaten them]{30secs()}
            "The legion knows of your crimes. I now know your faces. Let me through or you will be hunted down and crucified for your crimes."

            Some of the brutes look alarmed by this but the one clearly in charge of the bunch laughs bitterly.

            "The legion won't touch Bath. They don't want to piss off any of its little citizens. On top of that, by the time they track us down, we'll be beyonD the reach of the legion. You didn't build a wall for no reason. Now get out of here before we kill you."
            
            You leave the group of thugs behind and decide to wait for another oportunity to make a move on the individual.
                ->Fail_day1
        **[Persuade them] {30secs()}
            "I know of your crimes. I'm sure you all know the punishment for non-citizens when they commit a crime against Rome. I am, however, willing to overlook this, as your leader is the one person I need. Leave now and your crimes will be forgiven."

            The thugs look at one another for a few moments. A few short sentences pass in their strange tongue. Then, without another word, they walk away from the door.

            You enter the tavern and ask the innkeeper what room the tattooed man is staying in, your authority overriding any loyalty they might have. When you enter, the man is in the midst of looking over a map of the area. There are markings on particular places on the map. He turns, shocked to see you.

            "How did you get in here?" he asks.

            "That's not important. I am a vigile, your thugs have left you and right now you have two options. Talk to me here and now. Or talk to the legion on the rack."

            He takes a moment to consider before responding, "Ask what you will," his voice beaten.
                ->Macdudd_Invite

*[Wait to talk to the man when he is away from the thugs (6 Hours)]
    {advancetime(0,0,6,0)}
    You wait for your moment. When you see him exit the tavern, alone, you follow and approach the tattoed man while he is away from his thugs.

    "What do you want?" he asks suspiciously.
    **[Threaten him into giving you information] {30secs()}
        "I am a vigile of the Roman Legion. I know of your crimes and we know your face. We will not stop hunting you until you are found and crucified for your crimes. You will tell me what you know and maybe you'll have a chance at the arena instead."

        The man looks at you for a short time. Then he laughs. 

        "The Roman Legion will never come to Bath. It doesn't want to upset the citizens. Now piss off and leave me alone before I cut your throat."
        
        He looks like he means it. You leave the man, hoping there may be some other way to get your information.
        ->Fail_day1

    **[Offer him a deal to convince him to give you information] {30secs()}
        "I am a vigile of the Roman Legion," you say. "I know of your crimes and I'm sure you know the punishments. I am willing to forgoe punishment in exchange for aid. Tell me what you know and you are free to leave Bath, and head back beyond Hadrian's wall."

        The man watches your face for any sign of deception or trickery.

        "Follow me," he says.
            ***[Follow him] {30secs()}
            The man leads you back to the tavern and waves away his thugs as you enter behind him. He takes you upstairs to his room.

            "Ask away," he says.
                ->Macdudd_Invite
            ***[Don't follow him; find another way to get the information]
            You don't think you can trust this man, whoever he is. You decide to get your information from somewhere else. It's not worth the risk.
            ->Fail_day1
=Macdudd_Invite
*"Who are you?" {30secs()}
    "My name is Macdudd. I am from Pictland and I was hired to abduct people" He says. 

    You watch him for any sign of dishonesty but he seems to have given up any semblance of resistance.
    ->Macdudd_Invite
    
*(macduddboss)"Who do you work for?" {30secs()}
    "I have been hired by druids." He pauses to gage your response. You are shocked by this information and try not to show it. There should be no druids within the borders of Rome.

    "One in particular has been working with me to aid me with the abductions."
        **"Druids?" {30secs()}
            "I don't know too many of them. But I work for Chossach. They are recruiting more druids for the ritual."
            ->Macdudd_Invite

*"Why are you abducting people?" {30secs()}
    "The druids need them for their ritual. I believe they are planning to sacrifice them." 

    This is shocking news. Not only are people being sacrificed it appears to be for some druid ritual. The consequences of which are difficult to understand or comprehend.
    ->Macdudd_Invite

*"Why are there plants at every abduction site?" {30secs()}
    "They are a side effect of the druids and their magic. It has some link to the ritual being planned." He says this calmly and without blinking an eye, even while talking of druids and magic and other absurd things. You still believe he is telling the truth, however.
    ->Macdudd_Invite
    
*  -> Macdudd_Ritual
        
=Macdudd_Ritual
    "Tell me about the ritual." {30secs()}
        "A ritual of rebirth for the spring festival, Imbolc. I do not know what the ritual will accomplish. That's all I know."

    Imbolc is soon. The evening of the first day of Februarius. That doesn't give long to discover what the ritual is for and where it taking place.
    
    This lead has proved to be very useful. You have a deadline to meet before the ritual and have discovered a much wider plot than you first realised. The next place to look should probably be after the druids. Perhaps looking into the Vervain plants more will lead you in the right direction.

    
->DONE

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
    *[Ask the innkeeper where they are] {30secs()}
        "Is the tattooed man still here?" you ask the innkeeper.

        "Him and his men left in the night," he responds.
        **[Ask the innkeeper questions about the man] {30secs()}
            "I'm a vigile of the Roman legion," you tell the man. "Mind if I ask a few questions about the tattooed man?"

            "Of course I'll tell you everything I can."
            ->inkeep_macdudd_qs
        **[Ask if you can investigate his room]You ask to investigate his room.
            ->investigate_macdudd_room
=inkeep_macdudd_qs
    *(askmacduddname)"Do you know who he was, his name, his job - anything?" {30secs()}
        "His name was Macdudd. I'm not too sure where he was from but he seemed to be from north of the wall. I might say Pictish?" He stops to think for a moment.

        "As for his job, I couldn't say, but if his thugs gave any clue, I would say he's in a violent one."
        ->inkeep_macdudd_qs
    *(invmacduddmeetings)"Did he ever meet with anyone?"
        "Aside from his goons I'm not sure. He did often leave the establishment alone and come back an hour or so later. Could be he was meeting with someone then, but never here."
        ->inkeep_macdudd_qs
    *{not investigate_macdudd_room && askmacduddname && invmacduddmeetings} You ask the innkeeper if you can investigate Macdudd's room.  ->investigate_macdudd_room
    * -> 
        You thank the inkeeper for their time and continue on your way. ->Bath
=investigate_macdudd_room
{!"Of course." The man says. He leads you up to the room and lets you in.<p></p>You stand in the room and take in your surroundings. There is an uncomfortable looking straw bed at one end of the room. A wardrobe in another corner. Next to the wardrobe is a table, a fallen chair under it. At the foot of the bed is a chest. The room looks as though it was left in a hurry.|}
    *(invmacduddbed)[Investigate the bed]
        You look in and around the bed. While it is a mess there appears to be no trace left behind of {askmacduddname: Macdudd|the man}.
        ->investigate_macdudd_room

    *(invmacduddwardrobe)[Search the wardrobe]
        You open the wardrobe. It is empty. Nothing has been left behind. You check for a false panel, a loose bit of wood and find nothing. That is until you are about to close the door. on the edge of the door is inscribed a tiny rune denoting the month of Februarius.
        ->investigate_macdudd_room
    *(invmacduddtable)[Investigate the table]
        Looking around the table you find very little. You are about to give up looking when you see a small plant sprouting from behind the table. Vervain.
        ->investigate_macdudd_room
    *(invmacduddchest)[Open the chest]
        You open the chest. Inside is a scrap of parchment, overlooked in the clearing. It is a portion of map that shows highlighted areas. They link to ones you already know people to have been abducted.
        ->investigate_macdudd_room
    *{not inkeep_macdudd_qs && invmacduddbed && invmacduddwardrobe && invmacduddtable && invmacduddchest} You ask the innkeeper some questions about the man.  ->inkeep_macdudd_qs
    * -> 
        You thank the inkeeper for their time and continue on your way. ->Bath

->DONE

===SulisTemple===
{justbeenhospital == false:
    {arrivaltime(playerdestination)}
    -else:
        ~ justbeenhospital = false
}
{horserent == true:
    ~ horserent = false
}
    ~ playerlocation = "temple"
->DONE

