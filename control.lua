local function on_built(event)
    local entity = event.created_entity or event.entity
    --local type = event.created_entity 
    if entity ~= nil and entity.name == "entity-ghost"  then
        entity.revive()
    end
end

local function on_marked_for_deconstruction(event)
    if(event.entity) then
        event.entity.destroy()
        --event.entity.die()
    end
end

local function on_marked_for_upgrade(event)
    if(event.entity) then
        local entity = event.entity
        local surface = entity.surface
        local entityInfo = {
            name = event.target.name ,
            position = entity.position,
            direction = entity.direction,
            force = entity.force,
            fast_replace = true,
            spill =  false,
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

script.on_event(defines.events.on_built_entity         ,on_built         )
script.on_event(defines.events.script_raised_built     ,on_built   )
script.on_event(defines.events.on_marked_for_deconstruction   ,on_marked_for_deconstruction   )
script.on_event(defines.events.on_marked_for_upgrade   ,on_marked_for_upgrade   )
script.on_event(defines.events.on_tick   ,on_tick   )
