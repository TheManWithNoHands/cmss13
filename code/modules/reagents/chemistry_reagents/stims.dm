
/datum/reagent/stimulant
	reagent_state = LIQUID
	custom_metabolism = AMOUNT_PER_TIME(1, 1 MINUTES) // Consumes 1 unit per minute.
	overdose = LOWH_REAGENTS_OVERDOSE
	overdose_critical = LOWH_REAGENTS_OVERDOSE_CRITICAL
	chemclass = CHEM_CLASS_NONE
	flags = REAGENT_SCANNABLE | REAGENT_TYPE_STIMULANT
	var/jitter_speed = 0.3 SECONDS
	var/jitter_per_amount = 2
	var/jitter = 2

/datum/reagent/stimulant/on_mob_life(mob/living/M, alien, delta_time)
	. = ..()
	// Stimulants drain faster for each stimulant in the drug.
	// Having 2 stimulants means the duration will be 2x shorter, having 3 will be 3x shorter, etc
	if(holder)
		for(var/datum/reagent/R in holder.reagent_list)
			if(R == src)
				continue

			if(R.flags & REAGENT_TYPE_STIMULANT)
				holder.remove_reagent(R, custom_metabolism)

	// We multiply delta_time by 1.5 so that it looks like it is consistent.
	var/time_per_animate = (jitter_speed/(jitter_per_amount + 2))

	animate(M, pixel_x = rand(-jitter, jitter), pixel_y = rand(-jitter, jitter), time = time_per_animate, flags=ANIMATION_END_NOW)
	for(var/i in 1 to jitter_per_amount)
		animate(pixel_x = rand(-jitter, jitter), pixel_y = rand(-jitter, jitter), time = time_per_animate)
	animate(pixel_x = 0, pixel_y = 0, time = time_per_animate)

/datum/reagent/stimulant/speed_stimulant
	name = "Speed Stimulant"
	id = "speed_stimulant"
	description = "A highly experimental performance enhancement stimulant. It is not addictive."
	color = "#ffff00"
	properties = list(
		PROPERTY_MUSCLESTIMULATING = 40,
		PROPERTY_PAINKILLING = 3,
	)

/datum/reagent/stimulant/brain_stimulant
	name = "Brain Stimulant"
	id = "brain_stimulant"
	description = "A highly experimental CNS stimulant."
	color = "#a800ff"
	properties = list(
		PROPERTY_NERVESTIMULATING = 30,
		PROPERTY_PAINKILLING = 6,
		PROPERTY_NEUROSHIELDING = 13,
	)

/datum/reagent/stimulant/redemption_stimulant
	name = "Redemption Stimulant"
	id = "redemption_stimulant"
	overdose = LOW_REAGENTS_OVERDOSE
	overdose_critical = LOW_REAGENTS_OVERDOSE_CRITICAL
	description = {"\
		A highly experimental bone, organ and muscle stimulant.\
		Increases the durability of skin and bones as well as nullifying any pain.\
		Pain is impossible to feel whilst this drug is in your system.\
		During the metabolism of this drug, dysfunctional organs will work normally."}
	color = "#00ffa8"
	properties = list(
		PROPERTY_NERVESTIMULATING = 2,
		PROPERTY_MUSCLESTIMULATING = 2,
		PROPERTY_PAINKILLING = 100,
		PROPERTY_BONEMENDING = 100,
		PROPERTY_ORGAN_HEALING = 100,
		PROPERTY_HYPERDENSIFICATING = 1,
		PROPERTY_ORGANSTABILIZE = 1,
	)

/datum/reagent/stimulant/greater_resin
	name = "Fruit Resin Compound"
	id = "compound_resin"
	description = "A compound created from fruit resin, a product of X-121 hives. "
	color = "#"
	chemclass = CHEM_CLASS_SPECIAL
	overdose = LOWM_REAGENTS_OVERDOSE_CRITICAL
	overdose_critical = LOWM_REAGENTS_OVERDOSE_CRITICAL
	jitter = FALSE
	flags = REAGENT_TYPE_STIMULANT
	properties = list(
		PROPERTY_NEOGENETIC = 5,
		PROPERTY_ANTICORROSIVE = 5,
		PROPERTY_NUTRITIOUS = 3,
		PROPERTY_HEMOGENIC = 2,
	)

/datum/reagent/stimulant/unstable_resin
	name = "Concentrated Fruit Resin"
	id = "concentrated_resin"
	description = ""
	color = "#11916b"
	chemclass = CHEM_CLASS_SPECIAL
	overdose = LOWM_REAGENTS_OVERDOSE_CRITICAL
	overdose_critical = LOWM_REAGENTS_OVERDOSE_CRITICAL
	jitter = FALSE
	flags = REAGENT_TYPE_STIMULANT
	properties = list(
		PROPERTY_HYPERDENSIFICATING = 1

	)

/datum/reagent/stimulant/spore_resin
	name = "Concentrated Fruit Resin"
	id = "spore_resin_drug"
	description = ""
	color = "#914011"
	chemclass = CHEM_CLASS_SPECIAL
	overdose = LOWM_REAGENTS_OVERDOSE_CRITICAL
	overdose_critical = LOWM_REAGENTS_OVERDOSE_CRITICAL
	jitter = FALSE
	properties = list(
		PROPERTY_ORGANSTABILIZE = 6

	)

/datum/reagent/stimulant/speed_resin
	name = "X-C10H15N-A2 (Blood Shot)"
	id = "xeno_meth"
	description = "An experimental cocktail of drugs. Regular use may lead to cardiac arrest due to extreme cardiac muscel strain from the massivly increased heart beat rate. Advised to be taken along lots of water."
	color = "#990000"
	chemclass = CHEM_CLASS_SPECIAL
	overdose = LOWH_REAGENTS_OVERDOSE
	overdose_critical = MED_REAGENTS_OVERDOSE
	jitter = 3
	flags = REAGENT_TYPE_STIMULANT
	properties = list(
		PROPERTY_EUPHORIC = 10,
		PROPERTY_MUSCLESTIMULATING = 10,
		PROPERTY_NERVESTIMULATING = 2,
		PROPERTY_CORROSIVE = 3,
		PROPERTY_CARDIOTOXIC = 0.5,
		PROPERTY_HEMOLYTIC = 1.5 //Blood is fuel!
	)

/datum/reagent/stimulant/plasma_resin
	name = "Concentrated Fruit Resin"
	id = "plasma_resin_drug"
	description = ""
	color = "#"
	chemclass = CHEM_CLASS_SPECIAL
	overdose = LOWM_REAGENTS_OVERDOSE_CRITICAL
	overdose_critical = LOWM_REAGENTS_OVERDOSE_CRITICAL
	jitter = FALSE
	properties = list(

	)
