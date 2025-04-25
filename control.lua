local function on_built(event)
    local success,message = pcall(function ()
        local entity = event.created_entity or event.entity
        --local type = event.created_entity 
        --game.print("on_bulilt")
        if entity ~= nil and entity.name == "entity-ghost" or entity.name == "tile-ghost"  then
            if event.stack and event.stack.valid_for_read and event.stack.name == "teleport-destination-blueprint" then 
                -- script_raised_built event doesn't have stack.
                return 
            end
            --game.print("valid")
            local insert_plan
            if entity.name=="entity-ghost" and entity.insert_plan then
                --game.print("plan ")
                --game.print(helpers.table_to_json(entity.insert_plan))
                insert_plan = entity.insert_plan
            end
            --game.print("plan end")

            local _,revived,proxy = entity.revive({raise_revive=true})

            if revived and insert_plan then
                for _,plan in pairs(insert_plan) do
                    for _,item in pairs(plan.items.in_inventory) do
                        --game.print(helpers.table_to_json(item))
                        --game.print("inven:"..item.inventory.." stack:"..item.stack)
                        revived.get_inventory(item.inventory)[item.stack+1].set_stack(plan.id)
                    end
                end
            end

        end
    end)
    if not success then
        game.print("Instant BP error")
        game.print(message)
    end
end

local function on_marked_for_deconstruction(event)
    local success,message = pcall(function ()
        local entity=event.entity
        local surface=entity.surface
        if entity then
            if entity.name=="deconstructible-tile-proxy" then
                local tile=surface.get_tile(entity.position.x,entity.position.y)
                local tiles={{position=entity.position,name=tile.hidden_tile}}
                surface.set_tiles(tiles)
            else
                entity.destroy({raise_destroy=true})
                --entity.die()
            end
        end
    end)
    if not success then
        game.print("Instant BP error")
        game.print(message)
    end
end

local function on_marked_for_upgrade(event)
    local success,message = pcall(function ()
        if event.entity and event.entity.valid then
            local entity = event.entity
            local surface = entity.surface
            local entityInfo = {
                name = event.target.name ,
                position = entity.position,
                direction = entity.direction,
                force = entity.force,
                fast_replace = true,
                spill =  false,
                raise_built = true,
                quality = entity.quality
            }
            if entity.type=="underground-belt" then
                entityInfo.type=entity.belt_to_ground_type
            end
            --game.print("pos"..helpers.table_to_json(entity.position).."dir"..(entity.direction)..entity.type.)
            local newEntity = surface.create_entity(entityInfo)
            
        end
    end)
    if not success then
        game.print("Instant BP error")
        game.print(message)
    end
end

--local function on_tick(event)
    --game.print("on_tick : "..event.tick)
    --for _,entityInfo in pairs(delay_req_list) do
    --    game.print("req_list"..entityInfo.name)
    --    local newEntity = entityInfo.surface.create_entity(entityInfo)
    --end
--end

--local function on_built_entity(event)
--    on_built_or_mined(event)
--end

--local function on_robot_built_entity(event)
--    on_built_or_mined(event)
--end

--local function on_pre_player_mined_item(event)
--    on_built_or_mined(event)
--end

--local function on_robot_pre_mined(event)
--    on_built_or_mined(event)
--end

--local function script_raised_built(event)
--    on_built_or_mined(event)
--end

--local function script_raised_destroy(event)
--    on_built_or_mined(event)
--end

--script.on_event(defines.events.on_robot_built_entity   ,on_robot_built_entity   )
--script.on_event(defines.events.on_pre_player_mined_item,on_pre_player_mined_item)
--script.on_event(defines.events.on_robot_pre_mined      ,on_robot_pre_mined      )

--script.on_event(defines.events.script_raised_built     ,script_raised_built     )
--script.on_event(defines.events.script_raised_destroy   ,script_raised_destroy   )

--script.on_event(defines.events.on_built_entity         ,on_built_or_mined   )
--script.on_event(defines.events.on_robot_built_entity   ,on_built_or_mined   )
--script.on_event(defines.events.on_pre_player_mined_item,on_built_or_mined   )
--script.on_event(defines.events.on_robot_pre_mined      ,on_built_or_mined   )

script.on_event(defines.events.on_built_entity              , on_built                    ) -- {created_entity, player_index, stack, item tags, name, tick}
script.on_event(defines.events.script_raised_built          , on_built                    ) -- {entity, name, tick}
script.on_event(defines.events.on_marked_for_deconstruction , on_marked_for_deconstruction) -- {entity, player_index, name, tick}
script.on_event(defines.events.on_marked_for_upgrade        , on_marked_for_upgrade       ) -- {entity, target, player_index, direction, name, tick}

--script.on_event(defines.events.on_tick   ,on_tick   )
