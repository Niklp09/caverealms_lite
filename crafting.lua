--reverse craft for glow mese
minetest.register_craft({
	output = "default:mese_crystal_fragment 8",
	recipe = {{"caverealms:glow_mese"}}
})

--[[thin ice to water
minetest.register_craft({
	output = "default:water_source",
	recipe = {{"caverealms:thin_ice"}}
})]]

--use for coal dust
minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"}
	}
})

-- DM statue
minetest.register_craft({
	output = "caverealms:dm_statue",
	recipe = {
		{"caverealms:glow_ore","caverealms:hot_cobble","caverealms:glow_ore"},
		{"caverealms:hot_cobble","caverealms:hot_cobble","caverealms:hot_cobble"},
		{"caverealms:hot_cobble","caverealms:hot_cobble","caverealms:hot_cobble"}
	}
})

-- Glow obsidian brick
minetest.register_craft({
	output = "caverealms:glow_obsidian_brick 4",
	recipe = {
		{"caverealms:glow_obsidian", "caverealms:glow_obsidian"},
		{"caverealms:glow_obsidian", "caverealms:glow_obsidian"}
	}
})

minetest.register_craft({
	output = "caverealms:glow_obsidian_brick_2 4",
	recipe = {
		{"caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2"},
		{"caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2"}
	}
})

-- Glow obsidian glass
minetest.register_craft({
	output = "caverealms:glow_obsidian_glass 5",
	recipe = {
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "caverealms:glow_obsidian"}
	}
})

minetest.register_craft({
	output = "caverealms:glow_obsidian_glass 5",
	recipe = {
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "caverealms:glow_obsidian_2"}
	}
})

-- Requires ethereal:fish_raw
if minetest.get_modpath("ethereal") then

	local ethereal_fish = {
		{"ethereal:fish_chichlid"},
		{"ethereal:fish_bluefin"},
		{"ethereal:fish_clownfish"}
	}

	-- Used when right-clicking with fishing rod to check for worm and bait rod
	local rod_use = function(itemstack, placer, pointed_thing)

		local inv = placer:get_inventory()

		if inv:contains_item("main", "caverealms:glow_bait") then

			inv:remove_item("main", "caverealms:glow_bait")

			return ItemStack("caverealms:angler_rod_baited")
		end
	end

	-- Professional Fishing Rod
	minetest.register_craftitem("caverealms:angler_rod", {
		description = "Pro Fishing Rod",
		inventory_image = "caverealms_angler_rod.png",
		wield_image = "caverealms_angler_rod.png",
		on_place = rod_use,
		on_secondary_use = rod_use
	})

	minetest.register_craft({
		output = "caverealms:angler_rod",
		recipe = {
			{"","","default:steel_ingot"},
			{"", "default:steel_ingot", "caverealms:mushroom_gills"},
			{"default:steel_ingot", "", "caverealms:mushroom_gills"},
		}
	})

	-- Glow Bait
	minetest.register_craftitem("caverealms:glow_bait", {
		description = "Glow Bait",
		inventory_image = "caverealms_glow_bait.png",
		wield_image = "caverealms_glow_bait.png"
	})

	minetest.register_craft({
		output = "caverealms:glow_bait 9",
		recipe = {{"caverealms:glow_worm_green"}}
	})

	-- Pro Fishing Rod (Baited)
	minetest.register_craftitem("caverealms:angler_rod_baited", {
		description = "Baited Pro Fishing Rod",
		inventory_image = "caverealms_angler_rod_baited.png",
		wield_image = "caverealms_angler_rod_weild.png",
		stack_max = 1,
		liquids_pointable = true,

		on_use = function (itemstack, user, pointed_thing)

			if pointed_thing.type ~= "node" then
				return
			end

			local node = minetest.get_node(pointed_thing.under).name

			if (node == "default:water_source"
			or node == "default:river_water_source")
			and math.random(100) < 35 then

				local type = ethereal_fish[math.random(#ethereal_fish)][1]
				local inv = user:get_inventory()

				if inv:room_for_item("main", {name = type}) then

					inv:add_item("main", {name = type})

					return ItemStack("caverealms:angler_rod")
				else
					minetest.chat_send_player(user:get_player_name(),
						"Inventory full, Fish Got Away!")
				end
			end
		end
	})

	minetest.register_craft({
		output = "caverealms:angler_rod_baited",
		recipe = {{"caverealms:angler_rod", "caverealms:glow_bait"}}
	})
end
