INCLUDE variables
INCLUDE functions
INCLUDE map n journal



# title: Vigile
# author: Seeing Stone Games

VAR DEBUG = false

{DEBUG:
	IN DEBUG MODE!
	*	[Opening]	-> Opening
- else:
	// First diversion: where do we begin?
 ->init
}

===init===
* [PLAY GAME]
    ->Pronouns
    
    
===Pronouns===
Please choose your character's pronouns. 
* [They/Them/Theirs] # CLEAR
    ~ PRONOUN1 = "they"
    ~ PRONOUN2 = "them"
    ~ PRONOUN3 = "their"
    ~ PRONOUN4 = "theirs"
    ~ PRONOUN5 = "themself"
    ->Opening
* [She/Her/Hers] # CLEAR
    ~ PRONOUN1 = "she"
    ~ PRONOUN2 = "her"
    ~ PRONOUN3 = "her"
    ~ PRONOUN4 = "hers"
    ~ PRONOUN5 = "herself"
    ->Opening
* [He/Him/His] # CLEAR
    ~ PRONOUN1 = "he"
    ~ PRONOUN2 = "him"
    ~ PRONOUN3 = "his"
    ~ PRONOUN4 = "his"
    ~ PRONOUN5 = "himself"
    ->Opening
    
    

===Opening===
It is the year 84 C.E.

You are a <strong>vigile</strong>: an investigator hired by the Roman Legion and the elite to discover, solve and deal with mysterious happenings throughout the empire.

You were tasked with the return of governor Sallustius Lucullus' nephew. In finding him, you uncovered the abduction was much larger than expected. People have been going missing from surrounding villages.

Your only lead to continue this case is the description of a suspicious individual: a man, tattooed, in the old Celtic style for war.

*[Continue]
    You travel to Mai Dunn, a large hillfort that commands over the surrounding countryside. It is ruled by Chief Boabaird, a Roman sympathiser and someone you have helped in the past.
 
You enter the hillfort and approach the seat of power. Chief Boabaird stands and approaches, greeting you graciously.

"What can I do for you?" he asks.
    -> Mai_Dunn.Boabaird_Opening

===Noviomagus_Reginorum===
->DONE

===Fishbourne_Palace===
->DONE

===Mai_Dunn===

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
+{Boabaird_Ask_Tattooed || Boabaird_Ask_Job} [Thank Boabaird and be on your way] {30secs()} You thank the chief, leaving the hillfort behind you, and continue on the road. {currlocation("MD")} 
/// debugging tools
    // {travel_time("NR")}{TRAVELTIME}
    // {advancetime(0,0,0,0)} {whattimeDEBUG()}
    ** [Open map]
        -> MAP




===MD_Forest===
->DONE

===Bath===
{not Bath} You approach the Roman city of Bath, the grand structures are a welcome sign of civilisation in the colonies of Brittania. Strong foundations keep the city standing strong against all adversaries.
->DONE

===BathTavern===
->DONE

===SulisTemple===
->DONE

