///Object doesn't use any of the light systems. Should be changed to add a light source to the object.
#define NO_LIGHT_SUPPORT 0
///Light made with the lighting datums, applying a matrix.
#define STATIC_LIGHT 1
///Light made by masking the lighting darkness plane.
#define MOVABLE_LIGHT 2

///Is a movable light source attached to another movable (its loc), meaning that the lighting component should go one level deeper.
#define LIGHT_ATTACHED (1<<0)

///This light doesn't affect turf's lumcount calculations. Set to 1<<15 to ignore conflicts
#define LIGHT_NO_LUMCOUNT (1<<15)

#define MINIMUM_USEFUL_LIGHT_RANGE 1.4

#define LIGHTING_HEIGHT         1 //! height off the ground of light sources on the pseudo-z-axis, you should probably leave this alone
#define LIGHTING_ROUND_VALUE    (1 / 64) //! Value used to round lumcounts, values smaller than 1/129 don't matter (if they do, thanks sinking points), greater values will make lighting less precise, but in turn increase performance, VERY SLIGHTLY.

#define LIGHTING_ICON 'icons/effects/lighting_object.dmi' //! icon used for lighting shading effects

/// If the max of the lighting lumcounts of each spectrum drops below this, disable luminosity on the lighting objects. Set to zero to disable soft lighting. Luminosity changes then work if it's lit at all.
#define LIGHTING_SOFT_THRESHOLD 0

/// If I were you I'd leave this alone.
#define LIGHTING_BASE_MATRIX \
	list                     \
	(                        \
		1, 1, 1, 0, \
		1, 1, 1, 0, \
		1, 1, 1, 0, \
		1, 1, 1, 0, \
		0, 0, 0, 1           \
	)                        \


//Some defines to generalise colours used in lighting.
//Important note on colors. Colors can end up significantly different from the basic html picture, especially when saturated
#define LIGHT_COLOR_WHITE		"#FFFFFF" //! Full white. rgb(255, 255, 255)
#define LIGHT_COLOR_RED        "#FA8282" //! Warm but extremely diluted red. rgb(250, 130, 130)
#define LIGHT_COLOR_GREEN      "#64C864" //! Bright but quickly dissipating neon green. rgb(100, 200, 100)
#define LIGHT_COLOR_BLUE       "#6496FA" //! Cold, diluted blue. rgb(100, 150, 250)

#define LIGHT_COLOR_BLUEGREEN  "#7DE1AF" //! Light blueish green. rgb(125, 225, 175)
#define LIGHT_COLOR_PALEBLUE   "#7DAFE1" //! A pale blue-ish color. rgb(125, 175, 225)
#define LIGHT_COLOR_CYAN       "#7DE1E1" //! Diluted cyan. rgb(125, 225, 225)
#define LIGHT_COLOR_LIGHT_CYAN "#40CEFF" //! More-saturated cyan. rgb(64, 206, 255)
#define LIGHT_COLOR_DARK_BLUE  "#6496FA" //! Saturated blue. rgb(51, 117, 248)
#define LIGHT_COLOR_PINK       "#E17DE1" //! Diluted, mid-warmth pink. rgb(225, 125, 225)
#define LIGHT_COLOR_YELLOW     "#E1E17D" //! Dimmed yellow, leaning kaki. rgb(225, 225, 125)
#define LIGHT_COLOR_BROWN      "#966432" //! Clear brown, mostly dim. rgb(150, 100, 50)
#define LIGHT_COLOR_ORANGE     "#FA9632" //! Mostly pure orange. rgb(250, 150, 50)
#define LIGHT_COLOR_PURPLE     "#952CF4" //! Light Purple. rgb(149, 44, 244)
#define LIGHT_COLOR_LAVENDER   "#9B51FF" //! Less-saturated light purple. rgb(155, 81, 255)

#define LIGHT_COLOR_HOLY_MAGIC	"#FFF743" //! slightly desaturated bright yellow.
#define LIGHT_COLOR_BLOOD_MAGIC	"#D00000" //! deep crimson
#define LIGHT_COLOR_CLOCKWORK 	"#BE8700"

//These ones aren't a direct colour like the ones above, because nothing would fit
#define LIGHT_COLOR_FIRE       "#FAA019" //! Warm orange color, leaning strongly towards yellow. rgb(250, 160, 25)
#define LIGHT_COLOR_LAVA       "#C48A18" //! Very warm yellow, leaning slightly towards orange. rgb(196, 138, 24)
#define LIGHT_COLOR_FLARE      "#FA644B" //! Bright, non-saturated red. Leaning slightly towards pink for visibility. rgb(250, 100, 75)
#define LIGHT_COLOR_SLIME_LAMP "#AFC84B" //! Weird color, between yellow and green, very slimy. rgb(175, 200, 75)
#define LIGHT_COLOR_TUNGSTEN   "#FAE1AF" //! Extremely diluted yellow, close to skin color (for some reason). rgb(250, 225, 175)
#define LIGHT_COLOR_HALOGEN    "#F0FAFA" //! Barely visible cyan-ish hue, as the doctor prescribed. rgb(240, 250, 250)

#define LIGHT_RANGE_FIRE		3 //! How many tiles standard fires glow.

#define ADDITIVE_LIGHTING_PLANE_ALPHA_MAX 255
#define ADDITIVE_LIGHTING_PLANE_ALPHA_NORMAL 128
#define ADDITIVE_LIGHTING_PLANE_ALPHA_INVISIBLE 0

#define LIGHTING_PLANE_ALPHA_VISIBLE 255
#define LIGHTING_PLANE_ALPHA_NV_TRAIT 250
#define LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE 192
#define LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE 128 //! For lighting alpha, small amounts lead to big changes. even at 128 its hard to figure out what is dark and what is light, at 64 you almost can't even tell.
#define LIGHTING_PLANE_ALPHA_INVISIBLE 0

//lighting area defines
#define DYNAMIC_LIGHTING_DISABLED 0 //! dynamic lighting disabled (area stays at full brightness)
#define DYNAMIC_LIGHTING_ENABLED 1 //! dynamic lighting enabled
#define DYNAMIC_LIGHTING_FORCED 2 //! dynamic lighting enabled even if the area doesn't require power
#define DYNAMIC_LIGHTING_IFSTARLIGHT 3 //! dynamic lighting enabled only if starlight is.
#define IS_DYNAMIC_LIGHTING(A) A.dynamic_lighting

// Fullbright lighting defines
#define FULLBRIGHT_NONE 0		//! Do not use fullbright (Only applies to turfs)
#define FULLBRIGHT_DEFAULT 1	//! Use the default fullbright overlay of just 100% lighting
#define FULLBRIGHT_STARLIGHT 2	//! Use the starlight brightness overlay

//code assumes higher numbers override lower numbers.
#define LIGHTING_NO_UPDATE 0
#define LIGHTING_VIS_UPDATE 1
#define LIGHTING_CHECK_UPDATE 2
#define LIGHTING_FORCE_UPDATE 3

#define FLASH_LIGHT_DURATION 2
#define FLASH_LIGHT_POWER 3
#define FLASH_LIGHT_RANGE 3.8

/// Uses vis_overlays to leverage caching so that very few new items need to be made for the overlay. For anything that doesn't change outline or opaque area much or at all.
#define EMISSIVE_BLOCK_GENERIC 1
/// Uses a dedicated render_target object to copy the entire appearance in real time to the blocking layer. For things that can change in appearance a lot from the base state, like humans.
#define EMISSIVE_BLOCK_UNIQUE 2

/// A globaly cached version of [EMISSIVE_COLOR] for quick access. Indexed by alpha value
GLOBAL_LIST_INIT(emissive_color, new(256))
/// A set of appearance flags applied to all emissive and emissive blocker overlays.
#define EMISSIVE_APPEARANCE_FLAGS (KEEP_APART|RESET_COLOR|NO_CLIENT_COLOR|PIXEL_SCALE)

/// Colour matrix used to convert items into blockers. The only thing that should be taken into account is the alpha value, and
/// alpha of 1 should be fully black and an alpha of 0 should be black but transparent
/// The reason we aren't working with just white and black here is because white means that the item emits light, and we do not
/// want blockers to start emitting light just because they are transparent. We only want their blocking effect to be reduced.
/// Red = 0
/// Blue = 0
/// Green = 0
/// Alpha = alpha
#define EM_BLOCKER_MATRIX list(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
/// A globaly cached version of [EM_BLOCKER_MATRIX] for quick access.
GLOBAL_LIST_INIT(em_blocker_matrix, EM_BLOCKER_MATRIX)

/// Returns the red part of a #RRGGBB hex sequence as number
#define GETREDPART(hexa) hex2num(copytext(hexa, 2, 4))

/// Returns the green part of a #RRGGBB hex sequence as number
#define GETGREENPART(hexa) hex2num(copytext(hexa, 4, 6))

/// Returns the blue part of a #RRGGBB hex sequence as number
#define GETBLUEPART(hexa) hex2num(copytext(hexa, 6, 8))

/// Parse the hexadecimal color into lumcounts of each perspective.
#define PARSE_LIGHT_COLOR(source) \
do { \
	if (source.light_color) { \
		var/__light_color = source.light_color; \
		source.lum_r = GETREDPART(__light_color) / 255; \
		source.lum_g = GETGREENPART(__light_color) / 255; \
		source.lum_b = GETBLUEPART(__light_color) / 255; \
	} else { \
		source.lum_r = 1; \
		source.lum_g = 1; \
		source.lum_b = 1; \
	}; \
} while (FALSE)

GLOBAL_DATUM_INIT(fullbright_overlay, /image, create_fullbright_overlay())

/proc/create_fullbright_overlay()
	var/image/lighting_effect = new()
	lighting_effect.appearance = /obj/effect/fullbright
	return lighting_effect

GLOBAL_DATUM_INIT(starlight_overlay, /image, create_starlight_overlay())

/proc/create_starlight_overlay()
	var/image/lighting_effect = new()
	lighting_effect.appearance = /obj/effect/fullbright/starlight
	return lighting_effect

/// Innate lum source that cannot be removed
#define LUM_SOURCE_INNATE (1 << 4)
/// Luminosity source for glasses
#define LUM_SOURCE_GLASSES (1 << 3)
/// Lum source from mutant bodyparts
#define LUM_SOURCE_MUTANT_BODYPART (1 << 2)
/// Mutually exclusive holy statuses such as cult halos
#define LUM_SOURCE_HOLY (1 << 1)
/// Overlay based luminosity, cleared when overlays are cleared.
/// This is for managed overlays only. You should not be using this.
#define LUM_SOURCE_MANAGED_OVERLAY (1 << 0)

/// Add a luminosity source to a target
#define ADD_LUM_SOURCE(target, em_source) \
target._emissive_count |= em_source;\
if (target._emissive_count == em_source)\
{\
	target.update_luminosity();\
}

/// Remove a luminosity source to a target
#define REMOVE_LUM_SOURCE(target, em_source) \
target._emissive_count &= ~(em_source);\
if (target._emissive_count == 0)\
{\
	target.update_luminosity();\
}
