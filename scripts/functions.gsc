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
        self iPrintLnBold("Godmode ^1Disabled");
        player DisableInvulnerability();
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
GiveallPlayersaWeapon(weapon,player,team)
{
    players = GetPlayerArray();
    foreach(player in players)
    player GiveWeapon(GetWeapon(weapon));
    player SwitchToWeapon(GetWeapon(weapon));
    self iPrintLnBold("All Players Given " + weapon);
    player playsound(#"zmb_cha_ching");
}
GivePlayerWeapon(weapon)
{
    self GiveWeapon(GetWeapon(weapon));
    self SwitchToWeapon(GetWeapon(weapon));
    self iPrintLnBold(weapon + " ^2Given");
    self playsound(#"zmb_cha_ching");
}

//sounds
sound1()
{
    self playsound(#"zmb_cha_ching");
    self iPrintLnBold("Sound ^2Played");
}
sound2()
{
    self playsound(#"zmb_full_ammo");
    self iPrintLnBold("Sound ^2Played");
}
sound3()
{
    self playsound(#"zmb_vox_monkey_scream");
    self iPrintLnBold("Sound ^2Played");
}
sound4()
    {
    self playsound(#"zmb_player_outofbounds");
    self iPrintLnBold("Sound ^2Played");
		}
//
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
LunaWolf()
{
    spawnactor(#"hash_3f174b9bcc408705", self.origin, self.angles, "wolf_protector", 1);
}
ZombiesInSpace() 
{
    x = randomIntRange(-75, 75);
    y = randomIntRange(-75, 75);
    z = 45;
    
    location = (0 + x, 0 + y, 500000 + z);
    foreach(zombie in GetAITeamArray(level.zombie_team)) 
    {
        if (isDefined(zombie)) zombie ForceTeleport(location);
    }
    self iPrintLnBold("All Zombies Teleported To ^2Space");
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
    foreach(player in level.players)
    level.nofalldamage = isDefined(level.nofalldamage) ? undefined : true;
    if(isDefined(level.nofalldamage))
    {
        self iPrintLnBold("No Fall ^2Enabled");
        SetDvar(#"bg_fallDamageMinHeight", 9999);
        SetDvar(#"bg_fallDamageMaxHeight", 9999);
        player setPerk("specialty_fallheight");
    }
    else
    {        
        self iPrintLnBold("No Fall ^1Disabled");
        player unSetPerk("specialty_fallheight");
        setdvar(#"bg_falldamageminheight", 256);
		setdvar(#"bg_falldamagemaxheight", 512);
    }
}

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
    level.lowGravity = isDefined(level.lowGravity) ? undefined : true;
    if(isDefined(level.lowGravity))
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
    playfx(level._effect[#"teleport_splash"], player.origin);
	playfx(level._effect[#"teleport_aoe"], player.origin);
    foreach(zombie in GetAITeamArray(level.zombie_team)) 
    {
        if (isDefined(zombie)) zombie ForceTeleport(player.origin + (+40, 0, 0));
    }
    self iPrintLnBold("All Zombies Teleported To ^2" + player.name);
}
quake(player)
{
    earthquake( 0.6, 5, player.origin, 1000000 );
}

magicbullets(bullettype)
{
    if(!isDefined(self.gamevars["magicbullet"]) || self.gamevars["magicbullet"] == false)
    {
        self.gamevars["magicbullet"] = true;
        self iprintlnBold("Magic Bullets ^2ON");
        while(self.gamevars["magicbullet"])
        {
            self waittill( "weapon_fired" );
            if(self.gamevars["magicbullet"] == false)
                continue;
            MagicBullet( GetWeapon( bullettype ), self GetEye(), BulletTrace(self GetEye(), self GetEye() + AnglesToForward(self GetPlayerAngles()) * 100000, false, self)["position"], self);
            wait .025;
        }
    }
    else
    {
        self.gamevars["magicbullet"] = false;
        self iprintlnBold("Magic Bullets ^1OFF");
    }
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
            playfx(level._effect[#"teleport_splash"], player.origin);
	        playfx(level._effect[#"teleport_aoe"], player.origin);
            self iPrintLnBold(player.name + "Has Been ^1Kicked");
            Kick(player GetEntityNumber());
            break; 
         case 1:

            playfx(level._effect[#"teleport_splash"], self.origin);
	        playfx(level._effect[#"teleport_aoe"], self.origin);
            wait .2;
            player SetOrigin(self.origin + (-10, 0, 0));
            self iPrintLnBold(player.name + " Teleported To ^2Me");
            break;
            
        case 2:
            playfx(level._effect[#"teleport_splash"], self.origin);
	        playfx(level._effect[#"teleport_aoe"], self.origin);
            wait .2;
            self SetOrigin(player.origin + (-10, 0, 0));
            self iPrintLnBold("Teleported To ^2" + player.name);
            break;

        case 3:
            self iPrintlnBold("^1 "+player.name+" ^7Revived ^1!");
            player reviveplayer();
            break;
    }
} 
equipment_stays_healthy()
{
		self endon(#"disconnect");
		self notify(#"preserve_equipment");
		self endon(#"preserve_equipment");
		if(!(isdefined(self.preserving_equipment) && self.preserving_equipment))
		{
			self.preserving_equipment = 1;
			while(true)
			{
				self.equipment_damage = [];
				self.shielddamagetaken = 0;
				if(isdefined(level.destructible_equipment))
				{
					foreach(equip in level.destructible_equipment)
					{
						if(isdefined(equip))
						{
							equip.shielddamagetaken = 0;
							equip.damage = 0;
							equip.headchopper_kills = 0;
							equip.springpad_kills = 0;
							equip.subwoofer_kills = 0;
						}
					}
				}
				wait(0.1);
			}
		}
		self.preserving_equipment = 0;
}
packapunchweapon()
{
    weapon = self GetCurrentWeapon();
    self TakeWeapon(weapon);
    wait .1;
    self GiveWeapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self SwitchToWeapon(self zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon)));
    self IPrintLnBold("Your Current Weapon Has Been ^2Upgraded!");
}

TpToChest()
{
    Chest = level.chests[level.chest_index];
    origin = Chest.zbarrier.origin;
    FORWARD = AnglesToForward(Chest.zbarrier.angles);
    right = AnglesToRight(Chest.zbarrier.angles);
    BAngles = VectorToAngles(right);
    BOrigin = origin - 48 * right;
    switch(randomInt(3))
    {
        case 0:
            BOrigin = BOrigin + 16 * right;
            break;
        case 1:
            BOrigin = BOrigin + 16 * FORWARD;
            break;
        case 2:
            BOrigin = BOrigin - 16 * right;
            break;
        case 3:
            BOrigin = BOrigin - 16 * FORWARD;
            break;
    }
    playfx(level._effect[#"teleport_splash"], self.origin);
	playfx(level._effect[#"teleport_aoe"], self.origin);
    wait .1;
    self SetOrigin(BOrigin);
    self SetPlayerAngles(BAngles);
}
Powerups(func)
{  
    switch(func)
    {
        case 0:
            self zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, 1);
        case 1:
            self zm_powerups::specific_powerup_drop("fire_sale", self.origin, undefined, undefined, undefined, 1);
        case 2:
            self zm_powerups::specific_powerup_drop("bonus_points_player", self.origin, undefined, undefined, undefined, 1);
        case 3:
            self zm_powerups::specific_powerup_drop("free_perk", self.origin, undefined, undefined, undefined, 1);
        case 4:
            self zm_powerups::specific_powerup_drop("nuke", self.origin, undefined, undefined, undefined, 1);
        case 5:
            self zm_powerups::specific_powerup_drop("hero_weapon_power", self.origin, undefined, undefined, undefined, 1);
        case 6:
            self zm_powerups::specific_powerup_drop("insta_kill", self.origin, undefined, undefined, undefined, 1);
        case 7:
            self zm_powerups::specific_powerup_drop("double_points", self.origin, undefined, undefined, undefined, 1);
        case 8:
            self zm_powerups::specific_powerup_drop("carpenter", self.origin, undefined, undefined, undefined, 1);
    }
} 

Stats_TotalPlayed(score)
{
    self zm_stats::function_ab006044("TOTAL_GAMES_PLAYED", score);
}

Stats_HighestReached(score)
{
    self zm_stats::function_1b763e4("HIGHEST_ROUND_REACHED", score);
}

Stats_MostKills(score)
{
    self zm_stats::function_1b763e4("kills", score);
}

Stats_MostHeadshots(score)
{
    self zm_stats::function_1b763e4("MOST_HEADSHOTS", score);
}

Stats_Round(score)
{
    self zm_stats::function_ab006044("TOTAL_ROUNDS_SURVIVED", score);
    self zm_stats::function_a6efb963("TOTAL_ROUNDS_SURVIVED", score);
    self zm_stats::function_9288c79b("TOTAL_ROUNDS_SURVIVED", score);
}

ShowAllBoxes()
{
    foreach(chest in level.chests)
	{
		chest zm_magicbox::show_chest();
	}
}
BoxPrice(value)
{
    foreach(chest in level.chests) chest.zombie_cost = value;
    self IprintLnBold("Price Changed To ^1"+value);
}
perkaholic(str_bgb)
{
    self thread bgb::run_activation_func(str_bgb);
    self IprintLnBold("All Perks ^2Given");
}
allplayersperkaholic(str_bgb)
{
    players = GetPlayerArray();
    foreach(player in players)
    player thread bgb::run_activation_func(str_bgb);
    self IprintLnBold("All Players Perks ^2Given");
}

open_sesame()
{
	setdvar(#"zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 1);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int + 1);
		}
	}
	players = getplayers();
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened))
		{
			zombie_doors[i] notify(#"trigger", {#activator:players[0]});
		}
		if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
		{
			zombie_doors[i] notify(#"power_on");
		}
		waitframe(1);
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
		waitframe(1);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(isdefined(zombie_debris[i]))
		{
			zombie_debris[i] notify(#"trigger", {#activator:players[0]});
		}
		waitframe(1);
	}
	level notify(#"open_sesame");
	wait(1);
	setdvar(#"zombie_unlock_all", 0);
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
            playfx(level._effect[#"teleport_splash"], player.origin);
	        playfx(level._effect[#"teleport_aoe"], player.origin);
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
            player iPrintLnBold("Looks Like You Broke A Leg");
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
            player giveMaxAmmo(Weap);
            player giveMaxAmmo(player getCurrentOffHand());
            self iPrintLnBold("All Players ^2Given ^7Max Ammo");
            player playsound(#"zmb_full_ammo");
            break;
        case 8:
            players = GetPlayerArray();
            foreach(player in players)
            if(!player IsHost())
            player reviveplayer();
            self iPrintlnBold("^1All Players ^2Revived^1!");
            break;
    }
}

HeadLess()
{
    Zh=GetAiSpeciesArray("axis","all");
    for(i=0;i<Zh.size;i++)
    {
        Zh[i] DetachAll();
    }
    self iPrintlnBold("Zombies Are ^2Headless!");
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
     player iPrintLnBold("Looks Like You Broke A Leg");
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
            self playsound(#"zmb_full_ammo");
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
    self.forcehost = isDefined(self.forcehost) ? undefined : true;
    if(isDefined(self.forcehost))
    {
    self iPrintLnBold("Force Host ^2ON");
    if(getDvarString("party_connectTimeout") != "0")
    {
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
