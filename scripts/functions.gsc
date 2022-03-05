Godmode(player)
{
    player.godmode = isDefined(player.godmode) ? undefined : true;
    
    if(isDefined(player.godmode))
    {
        player endon("disconnect");
        self iPrintLnBold("Godmode ^2Enabled");
        while(isDefined(player.godmode)) //Black Ops Always Seems To Have An Issue With Invulnerability Turning Off Randomly. Looping it will fix that.
        {
            player EnableInvulnerability();
            wait 0.1;
        }
    }
    else
        player DisableInvulnerability();
        self iPrintLnBold("Godmode ^1Disabled");
}

Noclip1(player)
{
    player.Noclip = isDefined(player.Noclip) ? undefined : true;
    
    if(isDefined(player.Noclip))
    {
        player endon("disconnect");
        self iPrintLnBold("Noclip ^2Enabled");
        if(player hasMenu() && player isInMenu())
            player closeMenu1();
        player DisableWeapons();
        player DisableOffHandWeapons();
        player.nocliplinker = SpawnScriptModel(player.origin, "tag_origin");
        player PlayerLinkTo(player.nocliplinker, "tag_origin");
        
        while(isDefined(player.Noclip) && isAlive(player))
        {
            if(player AttackButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin + (AnglesToForward(player GetPlayerAngles()) * 60));
            else if(player AdsButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin - (AnglesToForward(player GetPlayerAngles()) * 60));
            if(player MeleeButtonPressed())
                break;
            
            wait 0.01;
        }

        if(isDefined(player.Noclip))
            player Noclip1(player);
    }
    else
    {
        player Unlink();
        player.nocliplinker delete();
        player EnableWeapons();
        player EnableOffHandWeapons();
        self iPrintLnBold("Noclip ^1Disabled");
    }
}

KickAllPlayers()
{
    foreach(player in level.players)
        if(!player IsHost())
            Kick(player GetEntityNumber());
}
GiveallPlayersaWeapon(weapon,player)
{
    players = GetPlayerArray();
    foreach(player in players)
    player GiveWeapon(GetWeapon(weapon));
    player SwitchToWeapon(GetWeapon(weapon));
    self iPrintLnBold("All Players Given " + weapon);
}
GivePlayerWeapon(weapon)
{
    self GiveWeapon(GetWeapon(weapon));
    self SwitchToWeapon(GetWeapon(weapon));
    self iPrintLnBold(weapon + " ^2Given");
}

PlasmaLoop(player)
{
    player.PlasmaLoop = isDefined(player.PlasmaLoop) ? undefined : true;

    if(isDefined(player.PlasmaLoop))
    {
        player endon("disconnect");

        while(isDefined(player.PlasmaLoop))
        {
            player function_e8f77739(#"zm_timeplayed", 1000000);
            wait 0.1;
        }
    }
}
SaveLocation(Val)
{
    if(Val == 0)
    {
        self.SaveLocation      = self.origin;
        self.SaveLocationAngle = self.angles;
        if(!IsDefined(self.SaveLocTog))
            self.SaveLocTog = true;
            
        self iPrintLnBold("Current Position: ^2Saved");
    }
    else if(Val == 1)
    {
        if(!IsDefined(self.SaveLocTog))
            return self iPrintLnBold("^1Error: ^7No Location Saved");
            
        self SetPlayerAngles(self.SaveLocationAngle);
        self SetOrigin(self.SaveLocation);
        self iPrintLnBold("Saved Position: ^2Loaded");
    }
    else
    {
        self.SaveLocTog        = undefined;
        self.SaveLocation      = undefined;
        self.SaveLocationAngle = undefined;
    }
}
TeleTSpace(player)
{
    x = randomIntRange(-75, 75);
    y = randomIntRange(-75, 75);
    z = 45;
    
    location = (0 + x, 0 + y, 500000 + z);
    player setOrigin(location);
    if(player != self)
        self IPrintLnBold(player.name + " Is Now In ^2Space");
    else
        player iPrintLnBold("You Are Now In ^2Space");
        
}

EndGame()
{
    KillServer();
}

SetRound(round)
{
    round -= 1;
    if(round >= 255)
        round = 254;
    if(round <= 0)
        round = 1;
    
    level.round_number = round;
    world.roundnumber  = round ^ 115;
    game.roundsplayed = round;
    SetRoundsPlayed(round + 1);
    
    level.zombie_total = 0;
    for(a=0;a<3;a++) //Triple check to make sure it kills them all
    {
        zombies = GetAISpeciesArray(level.zombie_team, "all");
        for(b=0;b<zombies.size;b++)
        {
            if(isDefined(zombies[b]) && IsAlive(zombies[b]))
                zombies[b] DoDamage(zombies[b].health + 99, zombies[b].origin);
        }
        wait .13;
    }
}
ZombieCount()
{
    Zombies=getAIArray("axis");
    self iPrintLnBold("Zombies ^1Remaining ^7: ^2"+Zombies.size);
}
thirdperson(player)
{
    player.thirdperson = isDefined(player.thirdperson) ? undefined : true;
    if (isDefined(player.thirdperson))
        self setclientthirdperson(1);
    else
        self setclientthirdperson(0);
}

Clone()
{
    self util::spawn_player_clone(self);
    self iPrintLnBold("^2Cloned!");
}
AddBotsToGame(player) 
{
    self iPrintLnBold("Bot ^2Added");
    AddTestClient();
}

Multijump(currentNum = 0)
{
    self endon("disconnect");
    self notify("SMulti");
    self.Multijump = isDefined(self.Multijump) ? undefined : true;
    self endon("SMulti");
    
    if(isDefined(self.Multijump))
        self setPerk("specialty_fallheight");
    else
        self unSetPerk("specialty_fallheight");
        
    while(IsDefined(self.Multijump))
    {
        if(self JumpButtonPressed() && currentNum < 15)
        {
            self setVelocity(self getVelocity() + (0, 0, 250));
            currentNum++;
        }
        if(currentNum == 15 && self isOnGround())
            currentNum = 0;

        wait .1;
    }
}

SuperJump()
{
    self iPrintLnBold("Super Jump ^1Disabled");
    level.SuperJump = isDefined(level.SuperJump) ? undefined : true;
    if(isDefined(level.SuperJump))
    {
        foreach(player in level.players)
            player thread AllSuperJump();
    }
}

AllSuperJump()
{
    self iPrintLnBold("Super Jump ^2Enabled");
    self endon("disconnect");
    while(isDefined(level.SuperJump))
    {
        if(self JumpButtonPressed())
        {
            for(i=0;i<5;i++)
                self SetVelocity(self GetVelocity() + (0, 0, 140));

            while(!self IsOnGround())
                wait .05;
        }
        wait .05; 
    }
}

SuperSpeed()
{
    level.SuperSpeed = isDefined(level.SuperSpeed) ? undefined : true;
    if(isDefined(level.SuperSpeed))
        setDvar("g_speed", 500);
    else
        setDvar("g_speed", 200);
}


nofalldamage()
{
    level.nofalldamage = isDefined(level.nofalldamage) ? undefined : true;
    if(isDefined(self.nofalldamage))
    {
        SetDvar("bg_fallDamageMinHeight", 9999);
        SetDvar("bg_fallDamageMaxHeight", 9999);
        self setPerk("specialty_fallheight");
    }
    else
    {        
        self unSetPerk("specialty_fallheight");
        setdvar("bg_falldamageminheight", 256);
		setdvar("bg_falldamagemaxheight", 512);
    }
}
//melee()
//{
 //   level.melee = isDefined(level.melee) ? undefined : true;
//    if(isDefined(self.melee))
//    {
//        SetDvar("player_meleerange", 999);
//        SetDvar("player_meleeheight", 999);
//        SetDvar("player_meleewidth", 999);
//    }
//    else
//    {
//        SetDvar("player_meleerange", 64);
//        SetDvar("player_meleeheight", 64);
//        SetDvar("player_meleewidth", 64);
//    }
//}
//
//farrev()
//{
//    level.farrev = isDefined(level.farrev) ? undefined : true;
//    if(isDefined(self.farrev))
//    {
//        SetDvar("revive_trigger_radius", 99999);
//    }
//    else
//    {
//        SetDvar("revive_trigger_radius", 64);
//    }
//}
AntiJoin()
{
    level.AntiJoin = isDefined(level.AntiJoin) ? undefined : true;
}

AntiQuit(player) 

{

    self.AntiQuit = isDefined(self.AntiQuit) ? undefined : true;
    if(isDefined(self.AntiQuit))
    {
        SetMatchFlag("disableIngameMenu", 1);
        self iPrintLnBold("Anti Quit ^2Enabled");
        foreach(player in level.players) 
        {
            player CloseInGameMenu();
        }
    } 
    else 
    {
        SetMatchFlag("disableIngameMenu", 0);
        self iPrintLnBold("Anti Quit ^1Disabled");
    }
}
Gravity()
{
    level.Gravity = isDefined(level.Gravity) ? undefined : true;
    if(isDefined(level.Gravity))
        SetDvar("bg_gravity", 100);
    else
        SetDvar("bg_gravity", 350);
}

UnlimitedAmmo(player)
{
    player.UnlimitedAmmo = isDefined(player.UnlimitedAmmo) ? undefined : true;

    self iPrintLnBold("Unlimted Ammo ^1Disabled");
    if(isDefined(player.UnlimitedAmmo))
    {
        self iPrintLnBold("Unlimited Ammo ^2Enabled");
        player endon("disconnect");
        while(isDefined(player.UnlimitedAmmo))
        {
            player GiveMaxAmmo(player GetCurrentWeapon());
            player SetWeaponAmmoClip(player GetCurrentWeapon(), player GetCurrentWeapon().clipsize);
            wait .05;
        }
    }
}

EditPlayerScore(score, player)
{
    player.score = !score ? 0 : player.score + score;
}
selfInstaKill()
{
    self.personal_instakill = isDefined(self.personal_instakill) ? undefined : true;
        if(isDefined(self.personal_instakill))
        self iPrintLnBold("Perma Insta Kill ^2Enabled");
        else
        self iPrintLnBold("Perma Insta Kill ^1Disabled");
}
TeleportZombies(player) 
{
    foreach(zombie in GetAITeamArray(level.zombie_team)) 
    {
        if (isDefined(zombie)) zombie ForceTeleport(player.origin + (+40, 0, 0));
    }
    self iPrintLnBold("All Zombies Teleported To ^2" + player.name);
}

RestartMap()
{
    self iPrintLnBold("Restarting");
    wait .5;
    map_restart(0);
}
KillAllZombies(player) 
{
    foreach(zombie in GetAITeamArray(level.zombie_team)) 
    {
        self iPrintLnBold("All Zombies ^1Killed!");
        if (isDefined(zombie)) zombie dodamage(zombie.maxhealth + 999, zombie.origin, player);
    }
}
StartTeleGun()
{
    self.TeleGun = isDefined(self.TeleGun) ? undefined : true;
    self iPrintLnBold("Teleport Gun ^1Disabled");
    if (isDefined(self.TeleGun))
    {
        self thread TeleportToCrosshair();
    } 
    else 
    {
        self notify("stop_telegun");
    }
}

TeleportToCrosshair() 
{
    self iPrintLnBold("Teleport Gun ^2Enabled");
    self endon("stop_telegun");
    self endon("game_ended");
    for (;;) 
    {
        self waittill("weapon_fired");
        self SetOrigin(bullettrace(self GetTagOrigin("tag_weapon"), self GetTagOrigin("tag_weapon") + vector_scal(AnglesToForward(self GetPlayerAngles()), 10000), 1, self)["position"]);
        wait .1;
    }
    wait .1;
}

vector_scal(vec, scale) 
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
} 
ClientOpts(player, func)
{  
    player endon("disconnect");
    level endon("game_ended");
    switch(func)
    {
        case 0:
            if(player == self)
                return;
            self iPrintLnBold(player.name + "Has Been ^1Kicked");
            Kick(player GetEntityNumber());
            break; 
         case 1:
            player SetOrigin(self.origin + (-10, 0, 0));
            self iPrintLnBold(player.name + " Teleported To ^2Me");
            break;
            
        case 2:
            self SetOrigin(player.origin + (-10, 0, 0));
            self iPrintLnBold("Teleported To ^2" + player.name);
            break;
    }
} 

AllClientOpts(player, func)
{  
    player endon("disconnect");
    level endon("game_ended");
    switch(func)
    {
        case 0:
            if(player == self)
                return;
            break;    
        case 1:
            
            players = GetPlayerArray();
            foreach(player in players)
            player SetOrigin(self.origin + (-10, 0, 0));
            self iPrintLnBold("All Players ^2Teleported");
            break;

        case 2:
            x = randomIntRange(-75, 75);
            y = randomIntRange(-75, 75);
            z = 45;
            location = (0 + x, 0 + y, 500000 + z);
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player SetOrigin(location);
            self iPrintLnBold("All Players ^2Yeeted Into Space");
            break;
        case 3:
            
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player DoDamage(player.health + 1, player.origin);
            self iPrintLnBold("All Players ^2Downed");
            break;
        case 4:
            Weap = player GetCurrentWeapon();
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player TakeWeapon(Weap);
            self iPrintLnBold("All Players Current Weapon ^1Taken");
            break;

        case 5:
            Weap = player GetCurrentWeapon();
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player TakeAllWeapons();
            self iPrintLnBold("All Players Weapons ^1Taken");
            break;

        case 6:
            Weap = player GetCurrentWeapon();
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player DropItem(Weap);
            self iPrintLnBold("All Players Current Weapon ^1Dropped");
            break;

        case 7:
            Weap = player GetCurrentWeapon();
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player giveMaxAmmo(Weap);
            player giveMaxAmmo(player getCurrentOffHand());
            self iPrintLnBold("All Players ^2Given ^7Max Ammo");
            break;
    }
}
AllMultijump(currentNum = 0)
{
    players = GetPlayerArray();
    foreach(player in players)
    player endon("disconnect");
    player notify("SMulti");
    self.Multijump = isDefined(self.Multijump) ? undefined : true;
    player endon("SMulti");
    
    if(isDefined(self.Multijump))
        player setPerk("specialty_fallheight");
    else
        player unSetPerk("specialty_fallheight");
        
    while(IsDefined(self.Multijump))
    {
        if(player JumpButtonPressed() && currentNum < 15)
        {
            player setVelocity(player getVelocity() + (0, 0, 250));
            currentNum++;
        }
        if(currentNum == 15 && player isOnGround())
            currentNum = 0;

        wait .1;
    }
}
AllAchievements(player)
{
    Allunlockall_Achi = array("zm_office_cold_war", "zm_office_ice", "zm_office_shock", "zm_office_power", "zm_office_strike", "zm_office_office", "zm_office_crawl", "zm_office_gas", "zm_office_pentupagon", "zm_office_everywhere", "zm_red_tragedy","zm_red_follower","zm_red_tribute","zm_red_mountains","zm_red_no_obol","zm_red_sun","zm_red_wind","zm_red_eagle","zm_red_defense","zm_red_gods", "zm_white_shard","zm_white_starting","zm_white_unlock","zm_white_mod","zm_white_trap","zm_white_pap","zm_white_knuckles","zm_white_perk","zm_white_stun","zm_white_roof","zm_trophy_doctor_is_in", "zm_trials_round_30","zm_escape_most_escape","zm_escape_patch_up","zm_escape_hot_stuff","zm_escape_hist_reenact","zm_escape_match_made","zm_escape_west_side","zm_escape_senseless","zm_escape_gat","zm_escape_throw_dog", "zm_orange_ascend","zm_orange_bells","zm_orange_freeze","zm_orange_hounds","zm_orange_totems","zm_orange_pack","zm_orange_secret","zm_orange_power","zm_orange_ziplines","zm_orange_jar","ZM_ZODT8_TRIAL_STEP_1", "ZM_MANSION_ARTIFACT","ZM_MANSION_STAKE","ZM_MANSION_BOARD","ZM_MANSION_BITE","ZM_MANSION_QUICK","ZM_MANSION_ALCHEMICAL","ZM_MANSION_CRAFTING","ZM_MANSION_SHOCKING","ZM_MANSION_CLOCK","ZM_MANSION_SHRINKING", "zm_towers_challenges","zm_towers_get_ww","zm_towers_trap_build","zm_towers_ww_kills","zm_towers_kitty_kitty","zm_towers_dismember","zm_towers_boss_kill","zm_towers_arena_survive","zm_towers_fast_pap", "ZM_ZODT8_ARTIFACT","ZM_ZODT8_STOWAWAY","ZM_ZODT8_DEEP_END","ZM_ZODT8_LITTLE_PACK","ZM_ZODT8_SHORTCUT","ZM_ZODT8_TENTACLE","ZM_ZODT8_STOKING","ZM_ZODT8_ROCK_PAPER","ZM_ZODT8_SWIMMING","zm_trophy_jack_of_all_blades", "zm_trophy_straw_purchase","zm_trophy_perkaholic_relapse","zm_trophy_gold","zm_rush_personal_score","zm_rush_team_score","zm_rush_multiplier_100","mp_trophy_special_issue_weaponry","mp_trophy_special_issue_equipment", "wz_specialist_super_fan","wz_first_win","wz_not_a_fluke","wz_blackout_historian","wz_specialist_super_fan","wz_zombie_fanatic","mp_trophy_battle_tested","mp_trophy_welcome_to_the_club","MP_SPECIALIST_MEDALS","MP_MULTI_KILL_MEDALS", "mp_trophy_vanquisher");
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    foreach(Achev in Allunlockall_Achi) 
    {
        player GiveAchievement(Achev);
        player iPrintLnBold("^2" + Achev);
        self iPrintLnBold("^2Unlocking ^7All Players Achievements");
        wait .5;
    }
    wait .5;
    player iPrintLnBold("^6All Achievements Unlocked");
    self iPrintLnBold("All Players Achievements ^2Unlocked");
}
AllCompleteActiveContracts(player)
{
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    foreach(index, contract in player.pers["contracts"])
    {
        targetVal = contract.target_value;
        if(isDefined(targetVal) && targetVal)
            contract.current_value = targetVal;
            self iPrintLnBold("Active Contracts ^2Complete");
            player iPrintLnBold("Active Contracts ^2Completed");
    }
}
AllUnlockAllChallenges(player)
{
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    if(isDefined(player.UnlockAll))
        return;
    player.UnlockAll = true;
    player endon("disconnect");
    

    player iPrintlnBold("Unlock All ^2Started");
    self iPrintlnBold("All Players Unlock All ^2Started");

    for(a=1;a<6;a++)
    {
        if(a == 4) //statsmilestones4.csv is an empty table. So we skip it
            a++;
        
        switch(a)
        {
            case 1:
                start = 1;
                end = 292;
                break;
            case 2:
                start = 292;
                end = 548;
                break;
            case 3:
                start = 548;
                end = 589;
                break;
            case 5:
                start = 1024;
                end = 1412;
                break;
            default:
                start = 0;
                end = 0;
                break;
        }
        
        for(value=start;value<end;value++)
        {
            stat         = SpawnStruct();
            stat.value   = Int(TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 2));
            stat.type    = TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 3);
            stat.name    = TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 4);

            switch(stat.type)
            {
                case "global":
                    player stats::set_stat(#"PlayerStatsList", stat.name, #"StatValue", stat.value);
                    player stats::set_stat(#"PlayerStatsList", stat.name, #"Challengevalue", stat.value);
                    break;
                case "attachment":
                    break; //Without column 13 on the tables, it's pretty useless. So we skip the attachment challenges.
                case "group":
                    groups = Array(#"weapon_pistol", #"weapon_smg", #"weapon_assault", #"weapon_lmg", #"weapon_cqb", #"weapon_sniper", #"weapon_tactical", #"weapon_launcher", #"weapon_cqb", #"weapon_knife", #"weapon_special");
                    foreach(group in groups)
                    {
                        player stats::set_stat(#"GroupStats", group, #"stats", stat.name, #"StatValue", stat.value);
                        player stats::set_stat(#"GroupStats", group, #"stats", stat.name, #"Challengevalue", stat.value);

                        wait 0.01;
                    }
                    break;
                default:
                    foreach(weap in level.zombie_weapons)
                        if(isDefined(weap.weapon) && zm_utility::getweaponclasszm(weap.weapon) == stat.type)
                        {
                            player AddWeaponStat(weap.weapon, stat.name, stat.value);
                            wait 0.01;
                        }
                    break;
            }
            wait 0.1;
            UploadStats(player);
        }
    }

    player iPrintlnBold("Unlock All Challenges ^2Done");
        self iPrintlnBold("All Players Unlock All Challenges ^2Done");
}
AllMaxWeaponRanks(player)
{
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    player endon("disconnect");

    foreach(weap in level.zombie_weapons) //Sets weapon ranks which unlocks attachments
    {
        if(isDefined(weap.weapon))
        {
            player stats::set_stat(#"hash_60e21f66eb3a1f18", weap.weapon.name, #"xp", 665535);
            player stats::set_stat(#"hash_60e21f66eb3a1f18", weap.weapon.name, #"plevel", 2);
            
            wait 0.01;
        }
    }

    attachments = Array(#"reflex", #"acog", #"holo", #"dualoptic", #"mms", #"elo"); //Unlocks reticles
    foreach(attachment in attachments)
    {
        player stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"StatValue", 3000);
        player stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"ChallengeValue", 3000);

        wait 0.01;
    }

    wait 0.1;
    UploadStats(player);

    player iPrintlnBold("Max Weapon Ranks ^2Set");
    self iPrintlnBold("All Players Max Weapon Ranks ^2Set");
}
AllMaxRank(player)
{
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    player AddRankXPValue("kill", 1439600);
    player rank::updaterank();
    wait 0.1;
    UploadStats(player);
    player iPrintLnBold("Rank 55 ^2SET");
    self iPrintLnBold("All Clients Rank 55 ^2SET");
}

AllLevel1000(player)
{
    players = GetPlayerArray();
    foreach(player in players)
    if(!player IsHost())
    player AddRankXPValue("kill", 52486400);
    player rank::updaterank();
    wait 0.1;
    UploadStats(player);
    player iPrintLnBold("Rank 1000 ^2SET");
    self iPrintLnBold("All Clients Rank 1000 ^2SET");
}
EditallPlayerScore(score, player)
{
    players = GetPlayerArray();
    foreach(player in players)
    player.score = !score ? 0 : player.score + score;
}

suicide(player)
{
     self iPrintLnBold("Downed "+ player.name);
     player DoDamage(player.health + 1, player.origin);
}
FreezeMysteryBox()
{
    level.chests[level.chest_index].no_fly_away = (!isDefined(level.chests[level.chest_index].no_fly_away) ? true : undefined);
    self iPrintLnBold("Box Never Moves " + (!level.chests[level.chest_index].no_fly_away ? "^1OFF" : "^2ON") );
}
UnlimitedSprint(player) 
{
    player.UnlimitedSprint = isDefined(player.UnlimitedSprint) ? undefined : true;
    if (isDefined(player.UnlimitedSprint))
    {
        player setperk("specialty_unlimitedsprint");
        player iPrintLnBold("Unlimited Sprint ^2Enabled");
    } 
    else 
    {
        player unsetperk("specialty_unlimitedsprint");
        player iPrintLnBold("Unlimited Sprint ^1Disabled");
    }
}    


Camos(Camo) 
{
    Weapon = self GetCurrentWeapon();
    self TakeWeapon(Weapon);
    self GiveWeapon(Weapon, self CalcWeaponOptions(Int(Camo), 1, 1, true, true, true, true));
    self iPrintLnBold("^2Camo ^1" + Camo + " ^2Given.");
} 
WeaponOpt(i)
{
    Weap = self GetCurrentWeapon();
    switch(i)
    {
        case 0:
            self iPrintLnBold("Taken ^1Weapon");
            self TakeWeapon(Weap);
            break;

        case 1:
            self iPrintLnBold("All Weapons ^1Taken");
            self TakeAllWeapons();
            break;

        case 2:
            self iPrintLnBold("Dropped ^2Weapon");
            self DropItem(Weap);
            break;

        case 3:
            self giveMaxAmmo(Weap);
            self giveMaxAmmo(self getCurrentOffHand());
            self iPrintLnBold("Max Ammo ^2Given");
            break;
    }
}       

unfair_toggleaimbot()
{
    self.aimbot = isDefined(self.aimbot) ? undefined : true;
    if (isDefined(self.aimbot))
    {
        self thread unfair_AimBot();
        self iPrintLnBold("Unfair Aimbot ^2Enabled");
    } 
    else 
    {
        self notify("StopAimbotting");
        self iPrintLnBold("Unfair Aimbot ^1Disabled");
    }
}

unfair_AimBot()
{
    self endon("disconnect");
    self endon("StopAimbotting");
    while(isDefined(self.aimbot))
    {
        ClosestZombie = Array::get_all_closest(self.origin, GetAITeamArray(level.zombie_team));
        
        if(self isFiring() && ClosestZombie.size > 0 && isAlive(ClosestZombie[0]) && !self IsMeleeing())
        {
            Loc = ClosestZombie[0] gettagorigin("tag_origin");
            
            self setplayerangles(VectorToAngles((Loc) - (self gettagorigin("tag_origin"))));
            wait .05;
            ClosestZombie[0] kill();
        }
        wait .05;
    }
}

MaxRank(player)
{
    player AddRankXPValue("kill", 1439600);
    player rank::updaterank();
    wait 0.1;
    UploadStats(player);
    player iPrintLnBold("Rank 55 ^2SET");
}

Level1000(player)
{
    player AddRankXPValue("kill", 52486400);
    player rank::updaterank();
    wait 0.1;
    UploadStats(player);
    player iPrintLnBold("Rank 1000 ^2SET");
}

ForceHost()
{
    if(getDvarString("party_connectTimeout") != "0")
    {
        self iPrintLnBold("Force Host ^2ON");
        SetDvar("lobbySearchListenCountries", "0,103,6,5,8,13,16,23,25,32,34,24,37,42,44,50,71,74,76,75,82,84,88,31,90,18,35");
        SetDvar("excellentPing", 3);
        SetDvar("goodPing", 4);
        SetDvar("terriblePing", 5);
        SetDvar("migration_forceHost", 1);
        SetDvar("migration_minclientcount", 12);
        SetDvar("party_connectToOthers", 0);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 12);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 0);
        SetDvar("party_neverJoinRecent", 1);
        SetDvar("party_readyPercentRequired", .25);
        SetDvar("partyMigrate_disabled", 1);
    }
    else
    {
        self iPrintLnBold("Force Host ^1OFF");
        SetDvar("lobbySearchListenCountries", "");
        SetDvar("excellentPing", 30);
        SetDvar("goodPing", 100);
        SetDvar("terriblePing", 500);
        SetDvar("migration_forceHost", 0);
        SetDvar("migration_minclientcount", 2);
        SetDvar("party_connectToOthers", 1);
        SetDvar("party_dedicatedOnly", 0);
        SetDvar("party_dedicatedMergeMinPlayers", 2);
        SetDvar("party_forceMigrateAfterRound", 0);
        SetDvar("party_forceMigrateOnMatchStartRegression", 0);
        SetDvar("party_joinInProgressAllowed", 1);
        SetDvar("allowAllNAT", 1);
        SetDvar("party_keepPartyAliveWhileMatchmaking", 1);
        SetDvar("party_mergingEnabled", 1);
        SetDvar("party_neverJoinRecent", 0);
        SetDvar("partyMigrate_disabled", 0);
    }
}
Achievements(player)
{
    unlockall_Achi = array("zm_office_cold_war", "zm_office_ice", "zm_office_shock", "zm_office_power", "zm_office_strike", "zm_office_office", "zm_office_crawl", "zm_office_gas", "zm_office_pentupagon", "zm_office_everywhere", "zm_red_tragedy","zm_red_follower","zm_red_tribute","zm_red_mountains","zm_red_no_obol","zm_red_sun","zm_red_wind","zm_red_eagle","zm_red_defense","zm_red_gods", "zm_white_shard","zm_white_starting","zm_white_unlock","zm_white_mod","zm_white_trap","zm_white_pap","zm_white_knuckles","zm_white_perk","zm_white_stun","zm_white_roof","zm_trophy_doctor_is_in", "zm_trials_round_30","zm_escape_most_escape","zm_escape_patch_up","zm_escape_hot_stuff","zm_escape_hist_reenact","zm_escape_match_made","zm_escape_west_side","zm_escape_senseless","zm_escape_gat","zm_escape_throw_dog", "zm_orange_ascend","zm_orange_bells","zm_orange_freeze","zm_orange_hounds","zm_orange_totems","zm_orange_pack","zm_orange_secret","zm_orange_power","zm_orange_ziplines","zm_orange_jar","ZM_ZODT8_TRIAL_STEP_1", "ZM_MANSION_ARTIFACT","ZM_MANSION_STAKE","ZM_MANSION_BOARD","ZM_MANSION_BITE","ZM_MANSION_QUICK","ZM_MANSION_ALCHEMICAL","ZM_MANSION_CRAFTING","ZM_MANSION_SHOCKING","ZM_MANSION_CLOCK","ZM_MANSION_SHRINKING", "zm_towers_challenges","zm_towers_get_ww","zm_towers_trap_build","zm_towers_ww_kills","zm_towers_kitty_kitty","zm_towers_dismember","zm_towers_boss_kill","zm_towers_arena_survive","zm_towers_fast_pap", "ZM_ZODT8_ARTIFACT","ZM_ZODT8_STOWAWAY","ZM_ZODT8_DEEP_END","ZM_ZODT8_LITTLE_PACK","ZM_ZODT8_SHORTCUT","ZM_ZODT8_TENTACLE","ZM_ZODT8_STOKING","ZM_ZODT8_ROCK_PAPER","ZM_ZODT8_SWIMMING","zm_trophy_jack_of_all_blades", "zm_trophy_straw_purchase","zm_trophy_perkaholic_relapse","zm_trophy_gold","zm_rush_personal_score","zm_rush_team_score","zm_rush_multiplier_100","mp_trophy_special_issue_weaponry","mp_trophy_special_issue_equipment", "wz_specialist_super_fan","wz_first_win","wz_not_a_fluke","wz_blackout_historian","wz_specialist_super_fan","wz_zombie_fanatic","mp_trophy_battle_tested","mp_trophy_welcome_to_the_club","MP_SPECIALIST_MEDALS","MP_MULTI_KILL_MEDALS", "mp_trophy_vanquisher");

    foreach(Achev in unlockall_Achi) 
    {
        player GiveAchievement(Achev);
        player iPrintLnBold("^2" + Achev);
        wait .5;
    }
    wait .5;
    player iPrintLnBold("^6All Achievements Unlocked");
}
MaxWeaponRanks(player)
{
    player endon("disconnect");

    foreach(weap in level.zombie_weapons) //Sets weapon ranks which unlocks attachments
    {
        if(isDefined(weap.weapon))
        {
            player stats::set_stat(#"hash_60e21f66eb3a1f18", weap.weapon.name, #"xp", 665535);
            player stats::set_stat(#"hash_60e21f66eb3a1f18", weap.weapon.name, #"plevel", 2);
            
            wait 0.01;
        }
    }

    attachments = Array(#"reflex", #"acog", #"holo", #"dualoptic", #"mms", #"elo"); //Unlocks reticles
    foreach(attachment in attachments)
    {
        player stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"StatValue", 3000);
        player stats::set_stat(#"hash_2ea32bf38705dfdc", attachment, #"kills", #"ChallengeValue", 3000);

        wait 0.01;
    }

    wait 0.1;
    UploadStats(player);

    player iPrintlnBold("Max Weapon Ranks ^2Set");
    if(player != self)
        self iPrintlnBold(player getName() + ": Max Weapon Ranks ^2Set");
}

UnlockAllChallenges(player)
{
    if(isDefined(player.UnlockAll))
        return;
    player.UnlockAll = true;

    player endon("disconnect");

    player iPrintlnBold("Unlock All ^2Started");
    if(player != self)
        self iPrintlnBold(player getName() + ": Unlock All ^2Started");

    for(a=1;a<6;a++)
    {
        if(a == 4) //statsmilestones4.csv is an empty table. So we skip it
            a++;
        
        switch(a)
        {
            case 1:
                start = 1;
                end = 292;
                break;
            case 2:
                start = 292;
                end = 548;
                break;
            case 3:
                start = 548;
                end = 589;
                break;
            case 5:
                start = 1024;
                end = 1412;
                break;
            default:
                start = 0;
                end = 0;
                break;
        }
        
        for(value=start;value<end;value++)
        {
            stat         = SpawnStruct();
            stat.value   = Int(TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 2));
            stat.type    = TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 3);
            stat.name    = TableLookup("gamedata/stats/zm/statsmilestones" + a + ".csv", 0, value, 4);

            switch(stat.type)
            {
                case "global":
                    player stats::set_stat(#"PlayerStatsList", stat.name, #"StatValue", stat.value);
                    player stats::set_stat(#"PlayerStatsList", stat.name, #"Challengevalue", stat.value);
                    break;
                case "attachment":
                    break; //Without column 13 on the tables, it's pretty useless. So we skip the attachment challenges.
                case "group":
                    groups = Array(#"weapon_pistol", #"weapon_smg", #"weapon_assault", #"weapon_lmg", #"weapon_cqb", #"weapon_sniper", #"weapon_tactical", #"weapon_launcher", #"weapon_cqb", #"weapon_knife", #"weapon_special");
                    foreach(group in groups)
                    {
                        player stats::set_stat(#"GroupStats", group, #"stats", stat.name, #"StatValue", stat.value);
                        player stats::set_stat(#"GroupStats", group, #"stats", stat.name, #"Challengevalue", stat.value);

                        wait 0.01;
                    }
                    break;
                default:
                    foreach(weap in level.zombie_weapons)
                        if(isDefined(weap.weapon) && zm_utility::getweaponclasszm(weap.weapon) == stat.type)
                        {
                            player AddWeaponStat(weap.weapon, stat.name, stat.value);
                            wait 0.01;
                        }
                    break;
            }
            wait 0.1;
            UploadStats(player);
        }
    }

    player iPrintlnBold("Unlock All Challenges ^2Done");
    if(player != self)
        self iPrintlnBold(player getName() + ": Unlock All Challenges ^2Done");
}

CompleteActiveContracts(player)
{
    foreach(index, contract in player.pers["contracts"])
    {
        targetVal = contract.target_value;
        if(isDefined(targetVal) && targetVal)
            contract.current_value = targetVal;
    }
}
