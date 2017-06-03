-- @version 1.1
-- @author MPL
-- @changelog
--   + fix 'limit output' check
-- @description Toggle 64x oversampling for all ReaComp instances
-- @website http://forum.cockos.com/member.php?u=70694


  function main(state) 
    aa = state*64
  
    for i = 1, reaper.CountTracks(0) do
      local tr = reaper.GetTrack(0,i-1)
      for k = 1,  reaper.TrackFX_GetCount( tr ) do
        local fx = reaper.TrackFX_GetByName( tr, 'reacomp', false )
        if fx >= 0 then    
          local stage = math.log(aa, 2)
          if stage < 0 then stage = 0 end
          cur_val = reaper.TrackFX_GetParamNormalized( tr, fx, 18)
          reaper.TrackFX_SetParamNormalized( tr, fx, 18, (stage*2 + ( cur_val* 13)%2)/13 )
        end
      end
    end
    
  end

  local _,_,sectionID,cmdID = reaper.get_action_context()
  local state = reaper.GetToggleCommandState( cmdID )
  if state == -1 then state = 1 end
  reaper.SetToggleCommandState( sectionID, cmdID, math.abs(1-state) )


  reaper.Undo_BeginBlock()
  main(state)
  reaper.Undo_EndBlock("Toggle 64x oversampling for all ReaComp instances", 0) 