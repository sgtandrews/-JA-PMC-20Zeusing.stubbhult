//CREATING ACTIONS
/* ace_interact_menu_fnc_createAction
 * Argument:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon <STRING>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (Optional)
 * 6: Action parameters <ANY> (Optional)
 * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
 * 8: Distance <NUMBER> (Optional)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
 * 10: Modifier function <CODE> (Optional)
 */

/* ace_interact_menu_fnc_addActionToZeus
 * Argument:
 * 0: Parent path of the new action <ARRAY> (Example: `["ACE_ZeusActions"]`)
 * 1: Action <ARRAY>
 */

//Vulcan pinch example
/* _action = ["VulcanPinch","Vulcan Pinch","",{_target setDamage 1;},{true},{},[parameters], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[cursorTarget, 0, ["ACE_TapShoulderRight"], _action] call ace_interact_menu_fnc_addActionToObject; */

//Adding to zeus example
/* _statement = {
    playSound3D ["alarm.ogg", theBase]
};
_action2 = ["myMissionEvent1","Mission Event: Play Base Alarm","",_statement,{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _action2] call ace_interact_menu_fnc_addActionToZeus; */

/*
NOVA_FNC_thing = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_seek.sqf";
[] remoteExec ["NOVA_FNC_thing", 2];

TODO
*/


//Primary UFOs
NOVA_FNC_UFO_seek = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_seek.sqf";
NOVA_FNC_UFO_jump = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_jump.sqf";
NOVA_FNC_UFO_cross = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_cross.sqf";

NOVA_FNC_UFO_seek_B = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_seek_B.sqf";
NOVA_FNC_UFO_jump_B = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_jump_B.sqf";
NOVA_FNC_UFO_cross_B = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_cross_B.sqf";

//Crop Circle is always BatteryBased
NOVA_FNC_UFO_circle = compile preprocessFile "world\scripts\aliens\Nova_UFO\ufo_encounter_cropcircle.sqf";

//Other
NOVA_FNC_Sounds = compile preprocessFile "3dsounds.sqf";
NOVA_FNC_Sounds_B = compile preprocessFile "3dsounds_B.sqf";

//My action menu actions
NOVA_FNC_AddUFOActions = {
    _ufoActionsMenu = ["NOVA_Zeus_UFOS","UFO Effects","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
    [["ACE_ZeusActions"], _ufoActionsMenu] call ace_interact_menu_fnc_addActionToZeus;

    NOVA_FNC_AddNormal_Encounters = {
      _normalUfoActionsMenu = ["NOVA_ZEUS_UFOS_N","Player Seeking","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
      [["ACE_ZeusActions", "NOVA_Zeus_UFOS"], _normalUfoActionsMenu] call ace_interact_menu_fnc_addActionToZeus;

      _playSeekAction = ["NOVA_Zeus_playSeekUFO_N","Play Seeker","",{[] remoteExec ["NOVA_FNC_UFO_seek", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
      _playJumpAction = ["NOVA_Zeus_playJumpUFO_N","Play Jump","",{[] remoteExec ["NOVA_FNC_UFO_jump", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
      _playCrossAction = ["NOVA_Zeus_playCrossUFO_N","Play Cross","",{[] remoteExec ["NOVA_FNC_UFO_cross", 0, false];},{true}] call ace_interact_menu_fnc_createAction;

      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_N"], _playSeekAction] call ace_interact_menu_fnc_addActionToZeus;
      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_N"], _playJumpAction] call ace_interact_menu_fnc_addActionToZeus;
      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_N"], _playCrossAction] call ace_interact_menu_fnc_addActionToZeus;
    };
    call NOVA_FNC_AddNormal_Encounters;

    NOVA_FNC_AddBattery_Encounters = {
      _batteryUfoActionsMenu = ["NOVA_Zeus_UFOS_B","Battery Seeking","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
      [["ACE_ZeusActions", "NOVA_Zeus_UFOS"], _batteryUfoActionsMenu] call ace_interact_menu_fnc_addActionToZeus;

      _playSeekAction = ["NOVA_Zeus_playSeekUFO_B","Play Seeker","",{[] remoteExec ["NOVA_FNC_UFO_seek_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
      _playJumpAction = ["NOVA_Zeus_playJumpUFO_B","Play Jump","",{[] remoteExec ["NOVA_FNC_UFO_jump_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
      _playCrossAction = ["NOVA_Zeus_playCrossUFO_B","Play Cross","",{[] remoteExec ["NOVA_FNC_UFO_cross_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;

      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B"], _playSeekAction] call ace_interact_menu_fnc_addActionToZeus;
      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B"], _playJumpAction] call ace_interact_menu_fnc_addActionToZeus;
      [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B"], _playCrossAction] call ace_interact_menu_fnc_addActionToZeus;

      NOVA_FNC_AddCropCircles = {
          _playCropCircleMenu = ["NOVA_Zeus_playCropCircleUFO_B","Play a Crop Circle","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
          [["ACE_ZeusActions","NOVA_Zeus_UFOS", "NOVA_Zeus_UFOS_B"], _playCropCircleMenu] call ace_interact_menu_fnc_addActionToZeus;

          NOVA_FNC_AddSpiralCrops = {
              _playspiralCropCircleMenu = ["NOVA_Zeus_playSpiralCropCircle_B","Spiral Crop Circles","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS", "NOVA_Zeus_UFOS_B", "NOVA_Zeus_playCropCircleUFO_B"], _playspiralCropCircleMenu] call ace_interact_menu_fnc_addActionToZeus;

              _spiralCropCircle01 = ["NOVA_ZEUS_CC_SP_5_B","Play Spiral 5m","",{[zeus_crop,5,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //5
              _spiralCropCircle02 = ["NOVA_ZEUS_CC_SP_10_B","Play Spiral 10m","",{[zeus_crop,10,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //10
              _spiralCropCircle03 = ["NOVA_ZEUS_CC_SP_15_B","Play Spiral 15m","",{[zeus_crop,15,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //15
              _spiralCropCircle04 = ["NOVA_ZEUS_CC_SP_30_B","Play Spiral 30m","",{[zeus_crop,30,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //30
              _spiralCropCircle05 = ["NOVA_ZEUS_CC_SP_60_B","Play Spiral 60m","",{[zeus_crop,60,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //60
              _spiralCropCircle06 = ["NOVA_ZEUS_CC_SP_120_B","Play Spiral 120m","",{[zeus_crop,120,"spiral"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //120

              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle01] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle02] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle03] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle04] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle05] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playSpiralCropCircle_B"], _spiralCropCircle06] call ace_interact_menu_fnc_addActionToZeus;
          };
          call NOVA_FNC_AddSpiralCrops;

          NOVA_FNC_AddFlowerCrops = {
              _playflowerCropCircleMenu = ["NOVA_Zeus_playFlowerCropCircle_B","Flower Crop Circles","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
              [["ACE_ZeusActions", "NOVA_Zeus_UFOS", "NOVA_Zeus_UFOS_B", "NOVA_Zeus_playCropCircleUFO_B"], _playflowerCropCircleMenu] call ace_interact_menu_fnc_addActionToZeus;

              _flowerCropCircle01 = ["NOVA_ZEUS_CC_FL_5_B","Play Flower 5m","",{[zeus_crop,5,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //5
              _flowerCropCircle02 = ["NOVA_ZEUS_CC_FL_10_B","Play Flower 10m","",{[zeus_crop,10,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //10
              _flowerCropCircle03 = ["NOVA_ZEUS_CC_FL_15_B","Play Flower 15m","",{[zeus_crop,15,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //15
              _flowerCropCircle04 = ["NOVA_ZEUS_CC_FL_30_B","Play Flower 30m","",{[zeus_crop,30,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //30
              _flowerCropCircle05 = ["NOVA_ZEUS_CC_FL_60_B","Play Flower 60m","",{[zeus_crop,60,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //60
              _flowerCropCircle06 = ["NOVA_ZEUS_CC_FL_120_B","Play Flower 120m","",{[zeus_crop,120,"flower"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //120

              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle01] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle02] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle03] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle04] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle05] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playFlowerCropCircle_B"], _flowerCropCircle06] call ace_interact_menu_fnc_addActionToZeus;
          };
          call NOVA_FNC_AddFlowerCrops;

          NOVA_FNC_AddCircleCrops = {
              _playcircleCropCircleMenu = ["NOVA_Zeus_playCircleCropCircle","Circle Crop Circles","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
              [["ACE_ZeusActions", "NOVA_Zeus_UFOS", "NOVA_Zeus_UFOS_B", "NOVA_Zeus_playCropCircleUFO_B"], _playcircleCropCircleMenu] call ace_interact_menu_fnc_addActionToZeus;

              _circleCropCircle01 = ["NOVA_ZEUS_CC_CI_5_B","Play Circle 5m","",{[zeus_crop,5,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //5
              _circleCropCircle02 = ["NOVA_ZEUS_CC_CI_10_B","Play Circle 10m","",{[zeus_crop,10,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //10
              _circleCropCircle03 = ["NOVA_ZEUS_CC_CI_15_B","Play Circle 15m","",{[zeus_crop,15,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //15
              _circleCropCircle04 = ["NOVA_ZEUS_CC_CI_30_B","Play Circle 30m","",{[zeus_crop,30,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //30
              _circleCropCircle05 = ["NOVA_ZEUS_CC_CI_60_B","Play Circle 60m","",{[zeus_crop,60,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //60
              _circleCropCircle06 = ["NOVA_ZEUS_CC_CI_120_B","Play Circle 120m","",{[zeus_crop,120,"circle"] remoteExec ["NOVA_FNC_UFO_circle", 0, false];},{true}] call ace_interact_menu_fnc_createAction; //120

              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle01] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle02] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle03] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle04] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle05] call ace_interact_menu_fnc_addActionToZeus;
              [["ACE_ZeusActions","NOVA_Zeus_UFOS","NOVA_Zeus_UFOS_B","NOVA_Zeus_playCropCircleUFO_B","NOVA_Zeus_playCircleCropCircle_B"], _circleCropCircle06] call ace_interact_menu_fnc_addActionToZeus;
          };
          call NOVA_FNC_AddCircleCrops;
      };
      call NOVA_FNC_AddCropCircles
    };
    call NOVA_FNC_AddBattery_Encounters;
};
call NOVA_FNC_AddUFOActions;

NOVA_FNC_AddScenarioActions = {
    _scenarioFlowMenu = ["NOVA_ZEUS_Scenario","Scenario Events","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
    [["ACE_ZeusActions"], _scenarioFlowMenu] call ace_interact_menu_fnc_addActionToZeus;

    NOVA_FNC_AddSoundActions = {
        _playSoundsMenu = ["NOVA_ZEUS_Scenario_Sounds","Scenario Sounds","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
        [["ACE_ZeusActions","NOVA_ZEUS_Scenario"], _playSoundsMenu] call ace_interact_menu_fnc_addActionToZeus;

        NOVA_FNC_AddNormal_Sounds = {
          _normalSoundsMenu = ["NOVA_ZEUS_Scenario_Sounds_N", "Player Seeking","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
          [["ACE_ZeusActions","NOVA_ZEUS_Scenario","NOVA_ZEUS_Scenario_Sounds"], _normalSoundsMenu] call ace_interact_menu_fnc_addActionToZeus;

          _playOwlSound = ["NOVA_ZEUS_playOwlSound_N","Play Owl Sound","",{["owl", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playWolfSound = ["NOVA_ZEUS_playWolfSound_N","Play Wolf Sound","",{["wolf", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playWingsSound = ["NOVA_ZEUS_playWingsSound_N","Play Wings Sound","",{["wings", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playSpookyHum = ["NOVA_ZEUS_playSpookyHumSound_N","Play Spooky Hum","",{["hum", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playGhostHorror = ["NOVA_ZEUS_playGhostHorrorSound_N","Play Ghost Horror Noise","",{["ghorror", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playSpookyWhisper= ["NOVA_ZEUS_playSpookyWhisperSound_N","Play Spooky Whisper","",{["spookywhisper", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playGhostlyWhisper= ["NOVA_ZEUS_playGhostlyWhisperSound_N","Play Ghost Whisper","",{["ghostlywhisper", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds", 0, false];},{true}] call ace_interact_menu_fnc_createAction;

          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playOwlSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playWolfSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playWingsSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playSpookyHum] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playGhostHorror] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playSpookyWhisper] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_N"], _playGhostlyWhisper] call ace_interact_menu_fnc_addActionToZeus;
        };
        call NOVA_FNC_AddNormal_Sounds;

        NOVA_FNC_AddBattery_Sounds = {
          _batterySoundsMenu = ["NOVA_ZEUS_Scenario_Sounds_B", "Battery Seeking","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
          [["ACE_ZeusActions","NOVA_ZEUS_Scenario","NOVA_ZEUS_Scenario_Sounds"], _batterySoundsMenu] call ace_interact_menu_fnc_addActionToZeus;

          _playOwlSound = ["NOVA_ZEUS_playOwlSound_B","Play Owl Sound","",{["owl", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playWolfSound = ["NOVA_ZEUS_playWolfSound_B","Play Wolf Sound","",{["wolf", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playWingsSound = ["NOVA_ZEUS_playWingsSound_B","Play Wings Sound","",{["wings", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playSpookyHum = ["NOVA_ZEUS_playSpookyHumSound_B","Play Spooky Hum Sound","",{["hum", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playGhostHorror = ["NOVA_ZEUS_playGhostHorrorSound_B","Play Ghost Horror Noise","",{["ghorror", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playSpookyWhisper = ["NOVA_ZEUS_playSpookyWhisperSound_B","Play Spooky Whisper","",{["spookywhisper", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;
          _playGhostlyWhisper = ["NOVA_ZEUS_playGhostlyWhisperSound_B","Play Ghost Whisper","",{["ghostlywhisper", 500, 60, -1] remoteExec ["NOVA_FNC_Sounds_B", 0, false];},{true}] call ace_interact_menu_fnc_createAction;

          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playOwlSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playWolfSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playWingsSound] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playSpookyHum] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playGhostHorror] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playSpookyWhisper] call ace_interact_menu_fnc_addActionToZeus;
          [["ACE_ZeusActions", "NOVA_ZEUS_Scenario", "NOVA_ZEUS_Scenario_Sounds", "NOVA_ZEUS_Scenario_Sounds_B"], _playGhostlyWhisper] call ace_interact_menu_fnc_addActionToZeus;
          
        };
        call NOVA_FNC_AddBattery_Sounds;
    };
    call NOVA_FNC_AddSoundActions;

    NOVA_FNC_AddFriendlyActions = {
        _changeOpforAggressionMenu = ["NOVA_ZEUS_Scenario_eastAggression","Change Opfor Aggression","",{call {};},{true}] call ace_interact_menu_fnc_createAction;
        [["ACE_ZeusActions","NOVA_ZEUS_Scenario"], _changeOpforAggressionMenu] call ace_interact_menu_fnc_addActionToZeus;

        _opforAngryAction = ["NOVA_ZEUS_Scenario_eastAggressionAngry","Make Opfor Angry","",{[east,[west, 0]] remoteExec ["setFriend", 0, true];},{true}] call ace_interact_menu_fnc_createAction;
        _opforFriendlyAction = ["NOVA_ZEUS_Scenario_eastAggressionFriendly","Make Opfor Friendly","",{[east,[west, 1]] remoteExec ["setFriend", 0, true];},{true}] call ace_interact_menu_fnc_createAction;

        [["ACE_ZeusActions","NOVA_ZEUS_Scenario","NOVA_ZEUS_Scenario_eastAggression"], _opforAngryAction] call ace_interact_menu_fnc_addActionToZeus;
        [["ACE_ZeusActions","NOVA_ZEUS_Scenario","NOVA_ZEUS_Scenario_eastAggression"], _opforFriendlyAction] call ace_interact_menu_fnc_addActionToZeus;
    };
    call NOVA_FNC_AddFriendlyActions;
};
call NOVA_FNC_AddScenarioActions;
/*  */
