local function on_built(event)
    local entity = event.created_entity or event.entity
    --local type = event.created_entity 
    if entity ~= nil and entity.name == "entity-ghost" or entity.name == "tile-ghost"  then
        if event.stack and event.stack.valid_for_read and event.stack.name == "teleport-destination-blueprint" then 
            -- script_raised_built event doesn't have stack.
            return 
        end
        entity.revive({raise_revive=true})
    end
end

local function on_marked_for_deconstruction(event)
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
end

local function on_marked_for_upgrade(event)
    if event.entity then
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
        }
        local newEntity = surface.create_entity(entityInfo)
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
