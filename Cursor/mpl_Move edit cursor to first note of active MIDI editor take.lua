  --[[
     * ReaScript Name: Move edit cursor to first note of active MIDI editor take
     * Lua script for Cockos REAPER
     * Author: MPL
     * Author URI: http://forum.cockos.com/member.php?u=70694
     * Licence: GPL v3
     * Version: 1.0
    ]]
    
  --[[
    * Changelog: 
    * v1.0 (2016-08-06)
      + init release
  --]]
  
  function main()
    MIDIEditor = reaper.MIDIEditor_GetActive()
    if MIDIEditor == nil then return end
    take = reaper.MIDIEditor_GetTake(MIDIEditor)
    if take == nil then return end
    if reaper.TakeIsMIDI(take) == false then return end
    fngtake = reaper.FNG_AllocMidiTake(take)
    note = reaper.FNG_GetMidiNote(fngtake, 0)
    note_pos = reaper.FNG_GetMidiNoteIntProperty(note, 'POSITION')
    pos = reaper.MIDI_GetProjTimeFromPPQPos(take, note_pos)
    reaper.SetEditCurPos(pos, true, true)
  end
  
  main()
