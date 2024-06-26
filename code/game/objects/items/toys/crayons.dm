/obj/item/toy/crayon/red
	icon_state = "crayonred"
	crayon_color = "#DA0000"
	shade_color = "#810C0C"
	colorName = "red"

/obj/item/toy/crayon/orange
	icon_state = "crayonorange"
	crayon_color = "#FF9300"
	shade_color = "#A55403"
	colorName = "orange"

/obj/item/toy/crayon/yellow
	icon_state = "crayonyellow"
	crayon_color = "#FFF200"
	shade_color = "#886422"
	colorName = "yellow"

/obj/item/toy/crayon/green
	icon_state = "crayongreen"
	crayon_color = "#A8E61D"
	shade_color = "#61840F"
	colorName = "green"

/obj/item/toy/crayon/blue
	icon_state = "crayonblue"
	crayon_color = "#00B7EF"
	shade_color = "#0082A8"
	colorName = "blue"

/obj/item/toy/crayon/purple
	icon_state = "crayonpurple"
	crayon_color = "#DA00FF"
	shade_color = "#810CFF"
	colorName = "purple"

/obj/item/toy/crayon/mime
	icon_state = "crayonmime"
	desc = "A very sad-looking crayon."
	crayon_color = COLOR_WHITE
	shade_color = COLOR_BLACK
	colorName = "mime"
	uses = 0

/obj/item/toy/crayon/mime/attack_self(mob/living/user) //inversion
	..()

	if(crayon_color != COLOR_WHITE && shade_color != COLOR_BLACK)
		crayon_color = COLOR_WHITE
		shade_color = COLOR_BLACK
		to_chat(user, "You will now draw in white and black with this crayon.")
	else
		crayon_color = COLOR_BLACK
		shade_color = COLOR_WHITE
		to_chat(user, "You will now draw in black and white with this crayon.")

/obj/item/toy/crayon/rainbow
	icon_state = "crayonrainbow"
	crayon_color = "#FFF000"
	shade_color = "#000FFF"
	colorName = "rainbow"
	uses = 0

/obj/item/toy/crayon/rainbow/attack_self(mob/living/user)
	..()
	crayon_color = input(user, "Please select the main color.", "Crayon color") as color
	shade_color = input(user, "Please select the shade color.", "Crayon color") as color

/obj/item/toy/crayon/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target,/turf/open/floor))
		var/drawtype = tgui_input_list(usr, "Choose what you'd like to draw.", "Crayon scribbles", list("graffiti","rune","letter"))
		switch(drawtype)
			if("letter")
				drawtype = tgui_input_list(usr, "Choose the letter.", "Crayon scribbles", GLOB.alphabet_lowercase)
				to_chat(user, "You start drawing a letter on the [target.name].")
			if("graffiti")
				to_chat(user, "You start drawing graffiti on the [target.name].")
			if("rune")
				to_chat(user, "You start drawing a rune on the [target.name].")
		if(instant || do_after(user, 50, INTERRUPT_ALL, BUSY_ICON_GENERIC))
			new /obj/effect/decal/cleanable/crayon(target,crayon_color,shade_color,drawtype)
			to_chat(user, "You finish drawing.")
			target.add_fingerprint(user) // Adds their fingerprints to the floor the crayon is drawn on.
			if(uses)
				uses--
				if(!uses)
					to_chat(user, SPAN_DANGER("You used up your crayon!"))
					qdel(src)
	return

/obj/item/toy/crayon/attack(mob/M as mob, mob/user as mob)
	if(M == user)
		to_chat(user, "You take a bite of the crayon and swallow it.")
// user.nutrition += 5
		if(uses)
			uses -= 5
			if(uses <= 0)
				to_chat(user, SPAN_DANGER("You ate your crayon!"))
				qdel(src)
	else
		..()
