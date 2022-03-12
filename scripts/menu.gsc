runMenuIndex(menu)
{
    self endon(#"disconnect");

    switch(menu)
    {
        case "Main":
            self addMenu(menu, level.menuName);
            if(self getVerification() > 0) //Verified
            {
                self addOpt("Basic Scripts", &newMenu, "Basic Scripts " + self GetEntityNumber());
                self addOpt("Account Management", &newMenu, "Account Management " + self GetEntityNumber());
                self addOpt("Fun Menu", &newMenu, "Fun Menu " + self GetEntityNumber());
                self addOpt("Weapon Options", &newMenu, "Weapon Options " + self GetEntityNumber());
                
                if(self getVerification() > 1) //VIP
                {
                    if(self getVerification() > 2) //Co-Host
                    {
                        if(self getVerification() > 3) //Admin
                        {
                            if(self IsHost())
                                self addOpt("Lobby Menu", &newMenu, "Lobby Menu");
                                self addOpt("Host Menu", &newMenu, "Host Menu");
                                self addOpt("Player Menu", &newMenu, "Players");
                                self addOpt("All Players Menu", &newMenu, "All Players");

                        }
                    }
                }
            }
            break;
            case "Lobby Menu":
            self addMenu(menu, "Lobby Menu");
                self addOptBool(level.nofalldamage, "No Fall", &nofalldamage);
                self addOptBool(level.SuperJump, "Super Jump", &SuperJump);
                self addOptBool(level.SuperSpeed, "Super Speed", &SuperSpeed);
                self addoptBool(level.lowGravity, "Low Gravity", &Gravity);
                self addOptBool(self.AntiQuit, "Anti Quit", &AntiQuit);
                self addOpt("GunGame", &doGunGame);
                self addOptIncSlider("Round: ", &SetRound, 0, 0, 255, 1);
                self addOpt("Turn Power On & Open All Doors", &open_sesame);
                self addOpt("Mystery Box Options", &newMenu, "Mystery Box Options");
            break;
            case "Mystery Box Options":
            self addMenu(menu, "Mystery Box Options");
                self addOpt("Freeze Box Position", &FreezeMysteryBox);
                self addOpt("Show All Boxes", &ShowAllBoxes);
                self addOpt("Hide All Boxes", &HideAllBoxes);
                self addOpt("Price Options", &newMenu, "MysteryBox Price Options");
                self addOpt("Teleport To Chest", &TpToChest);
            break;
        case "MysteryBox Price Options":
            self addMenu(menu, "MysteryBox Price Options");
            self addOpt("Default Box Price", &BoxPrice, 950);
            self addOpt("Free Box Price", &BoxPrice, 0);
            self addOpt("10 Box Price", &BoxPrice, 10);
            self addOpt("69 Box Price", &BoxPrice, 69);
            self addOpt("420 Box Price", &BoxPrice, 420);
            self addOpt("-1000 Box Price", &BoxPrice, -1000);
            self addOpt("Random Box Price", &BoxPrice, randomIntRange(0, 999999));
        break;
        case "Host Menu":
            self addMenu(menu, "Host Menu");
                self addOptBool(self.aimbot, "Unfair Aimbot", &unfair_toggleaimbot);
                self addOpt("Restart Map", &RestartMap);
                self addOpt("End Game", &EndGame);
                self addOpt("Add Bot", &AddBotsToGame);
                self addOptBool(self.forcehost, "Force Host", &ForceHost);
            break;
        case "Players":
            self addMenu(menu, "Players");
                players = GetPlayerArray();
                foreach(player in players)
                {
                    if(player IsHost() && !self IsHost()) //This Will Make It So No One Can See The Host In The Player Menu Besides The Host.
                        continue;
                    if(!isDefined(player.playerSetting["verification"])) //If A Player Doesn't Have A Verification Set, They Won't Show. Mainly Happens If They Are Still Connecting
                        player.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
                    
                    self addOpt("[^2" + player.playerSetting["verification"] + "^7]" + player getName(), &newMenu, "Options " + player GetEntityNumber());
                }
            break;
        case "All Players":
        self addMenu(menu, "All Players");
            self addOptBool(self.AllGod,"All Players Godmode", &AllPlayerGodMod);
            self addOptBool(self.Multijump, "All Players Multi Jump", &Multijump);
            self addOptIncSlider("All Players Score", &EditallPlayerScore, -10000, 0, 10000, 1000, player);
            self addOpt("Kick All Players", &KickAllPlayers);
            self addOpt("Teleport All Players", &AllClientOpts ,self , 1);
            self addOpt("Yeet All To Space", &AllClientOpts ,self , 2);
            self addOpt("Down All Players", &AllClientOpts ,self , 3);
            self addOpt("All Players Weapon Options", &newMenu, "All Players Weapon Options");
            self addOpt("All Players Account Management", &newMenu, "All Players Account Management");
            self addOpt("Give All Players Perks", &allplayersperkaholic, "zm_bgb_perkaholic");
            self addOpt("Revive All Players", &AllClientOpts ,self , 8);
        break;
        case "All Players Weapon Options":
         self addMenu(menu, "All Players Weapon Options");
            self addOpt("Take All Players Current Weapon", &AllClientOpts ,self , 4);
            self addOpt("Take All Players Weapons", &AllClientOpts ,self , 5);
            self addOpt("All Players Drop Weapon", &AllClientOpts ,self , 6);
            self addOpt("Max Ammo All Players", &AllClientOpts ,self , 7);
            self addOpt("Give All Players A Minigun", &GiveallPlayersaWeapon, "minigun",player);
            self addOpt("Give All Players Weapons", &newMenu, "All Players Weapons");
            self addOpt("Give All Players specific map Weapons", &newMenu, "All Players Specific Map Weapons");
            self addOpt("Give All Players Pack-A-Punched Weapons", &newMenu, "All Players Pack-A-Punched Weapons");
        break;
        case "All Players Weapons":
        self addMenu(menu, "All Players Weapons");
            self addOpt("-- Specials --");
            self addOpt("Hellion Salvo", &GiveallPlayersaWeapon, "launcher_standard_t8",player);
            self addOpt("Minigun", &GiveallPlayersaWeapon, "minigun",player);
            self addOpt("Ballistic Knife", &GiveallPlayersaWeapon, "special_ballisticknife_t8_dw");
            self addOpt("Ray Gun MK2", &GiveallPlayersaWeapon, "ray_gun_mk2",player);
            self addOpt("Crossbow", &GiveallPlayersaWeapon, "special_crossbow_t8",player);

            self addOpt("-- Sniper Rifles --");
            self addOpt("Outlaw", &GiveallPlayersaWeapon, "sniper_fastrechamber_t8",player);
            self addOpt("Paladin HB50", &GiveallPlayersaWeapon, "sniper_powerbolt_t8",player);
            self addOpt("SDM", &GiveallPlayersaWeapon, "sniper_powersemi_t8",player);
            self addOpt("Koshka", &GiveallPlayersaWeapon, "sniper_quickscope_t8",player);

            self addOpt("-- Tactical Rifles --");
            self addOpt("Auger DMR", &GiveallPlayersaWeapon, "tr_powersemi_t8",player);
            self addOpt("Swordfish", &GiveallPlayersaWeapon, "tr_longburst_t8",player);
            self addOpt("ABR 223", &GiveallPlayersaWeapon, "tr_midburst_t8",player);

            self addOpt("-- Lightmachine Guns --");
            self addOpt("VKM 750", &GiveallPlayersaWeapon, "lmg_heavy_t8",player);
            self addOpt("Hades", &GiveallPlayersaWeapon, "lmg_spray_t8",player);
            self addOpt("Titan", &GiveallPlayersaWeapon, "lmg_standard_t8",player);

            self addOpt("-- Assault Rifles --");
            self addOpt("ICR-7", &GiveallPlayersaWeapon, "ar_accurate_t8",player);
            self addOpt("Maddox RFB", &GiveallPlayersaWeapon, "ar_fastfire_t8",player);
            self addOpt("Rampart 17", &GiveallPlayersaWeapon, "ar_damage_t8",player);
            self addOpt("Vapr-XKG", &GiveallPlayersaWeapon, "ar_stealth_t8",player);
            self addOpt("KN-57", &GiveallPlayersaWeapon, "ar_modular_t8",player);
            self addOpt("Hitchcock M9", &GiveallPlayersaWeapon, "ar_mg1909_t8",player);

            self addOpt("-- Submachine Guns --");
            self addOpt("MX9", &GiveallPlayersaWeapon, "smg_standard_t8",player);
            self addOpt("Saug 9mm", &GiveallPlayersaWeapon, "smg_handling_t8",player);
            self addOpt("Spitfire", &GiveallPlayersaWeapon, "smg_fastfire_t8",player);
            self addOpt("Cordite", &GiveallPlayersaWeapon, "smg_capacity_t8",player);
            self addOpt("GKS", &GiveallPlayersaWeapon, "smg_accurate_t8",player);
            self addOpt("Escargot", &GiveallPlayersaWeapon, "smg_drum_pistol_t8",player);
            self addOpt("Switchblade x9", &GiveallPlayersaWeapon, "smg_folding_t8",player);

            self addOpt("-- Pistols --");
            self addOpt("RK 7 Garrison", &GiveallPlayersaWeapon, "pistol_burst_t8",player);
            self addOpt("Mozu", &GiveallPlayersaWeapon, "pistol_revolver_t8",player);
            self addOpt("Strife", &GiveallPlayersaWeapon, "pistol_standard_t8",player);
            self addOpt("Welling", &GiveallPlayersaWeapon, "pistol_topbreak_t8",player);

            self addOpt("-- Shotguns --");
            self addOpt("Mog 12", &GiveallPlayersaWeapon, "shotgun_pump_t8",player);
            self addOpt("SG12", &GiveallPlayersaWeapon, "shotgun_semiauto_t8",player);
            self addOpt("Trenchgun", &GiveallPlayersaWeapon, "shotgun_trenchgun_t8",player);
            
            self addOpt("-- Equipment --");
            self addOpt("sticky grenade", &GiveallPlayersaWeapon, "sticky_grenade",player);
        break;
        case "All Players Pack-A-Punched Weapons":
        self addMenu(menu, "All Players Pack-A-Punched Weapons");
            self addOpt("-- Specials --");
            self addOpt("Zitros Orbital Arbalest", &GiveallPlayersaWeapon, "launcher_standard_t8_upgraded",player);
            self addOpt("Thekrauss Refibrillator++", &GivePlayerWeapon, "special_ballisticknife_t8_dw_upgraded",player);
            self addOpt("Porters Mark II Ray Gun", &GivePlayerWeapon, "ray_gun_mk2_upgraded",player);
            self addOpt("Minos's Zeal", &GiveallPlayersaWeapon, "special_crossbow_t8_upgraded",player);
            
            self addOpt("-- Sniper Rifles --");
            self addOpt("D3SOL8 Regulator", &GiveallPlayersaWeapon, "sniper_fastrechamber_t8_upgraded",player);
            self addOpt("Righteous Fury", &GiveallPlayersaWeapon, "sniper_powerbolt_t8_upgraded",player);
            self addOpt("IT-5 LYT", &GiveallPlayersaWeapon, "sniper_powersemi_t8_upgraded",player);
            self addOpt("Bakeneko", &GiveallPlayersaWeapon, "sniper_quickscope_t8_upgraded",player);

            self addOpt("-- Tactical Rifles --");
            self addOpt("Dead Mans ReefRacker", &GiveallPlayersaWeapon, "tr_powersemi_t8_upgraded",player);
            self addOpt("Astralo-Packy-Cormus", &GiveallPlayersaWeapon, "tr_longburst_t8_upgraded",player);
            self addOpt("Br-r-rah", &GiveallPlayersaWeapon, "tr_midburst_t8_upgraded",player);

            self addOpt("-- Lightmachine Guns --");
            self addOpt("Cackling Kaftar", &GiveallPlayersaWeapon, "lmg_heavy_t8_upgraded",player);
            self addOpt("Acheron Alliterator", &GiveallPlayersaWeapon, "lmg_spray_t8_upgraded",player);
            self addOpt("Tartarus Veil", &GiveallPlayersaWeapon, "lmg_standard_t8_upgraded",player);

            self addOpt("-- Assault Rifles --");
            self addOpt("Impertinent Deanimator", &GiveallPlayersaWeapon, "ar_accurate_t8_upgraded",player);
            self addOpt("Red Fiend Bull", &GiveallPlayersaWeapon, "ar_fastfire_t8_upgraded",player);
            self addOpt("Parapetrifrier", &GiveallPlayersaWeapon, "ar_damage_t8_upgraded",player);
            self addOpt("Creeping Haze", &GiveallPlayersaWeapon, "ar_stealth_t8_upgraded",player);
            self addOpt("Ruined Revenger", &GiveallPlayersaWeapon, "ar_modular_t8_upgraded",player);
            self addOpt("Waking Nightmare", &GiveallPlayersaWeapon, "ar_mg1909_t8_upgraded",player);

            self addOpt("-- Submachine Guns --");
            self addOpt("Nuevemuertes xx", &GiveallPlayersaWeapon, "smg_standard_t8_upgraded",player);
            self addOpt("Stellar 92", &GiveallPlayersaWeapon, "smg_handling_t8_upgraded",player);
            self addOpt("Sky Scorcher", &GiveallPlayersaWeapon, "smg_fastfire_t8_upgraded",player);
            self addOpt("Corpsemaker", &GiveallPlayersaWeapon, "smg_capacity_t8_upgraded",player);
            self addOpt("Ghoul Keepers Subjugator", &GiveallPlayersaWeapon, "smg_accurate_t8_upgraded",player);
            self addOpt("PieceDerResistance", &GiveallPlayersaWeapon, "smg_drum_pistol_t8_upgraded",player);
            self addOpt("Excisenin3fold", &GiveallPlayersaWeapon, "smg_folding_t8_upgraded", player);
            
            self addOpt("-- Pistols --");
            self addOpt("Rapskallion 3D", &GiveallPlayersaWeapon, "pistol_burst_t8_upgraded",player);
            self addOpt("Belle Of The Ball", &GiveallPlayersaWeapon, "pistol_revolver_t8_upgraded",player);
            self addOpt("Z-Harmony", &GiveallPlayersaWeapon, "pistol_standard_t8_upgraded",player);
            self addOpt("King & Country", &GiveallPlayersaWeapon, "pistol_topbreak_t8_upgraded",player);

            self addOpt("-- Shotguns --");
            self addOpt("OMG Right Hook", &GiveallPlayersaWeapon, "shotgun_pump_t8_upgraded",player);
            self addOpt("Breccius Rebornus", &GiveallPlayersaWeapon, "shotgun_semiauto_t8_upgraded",player);
            self addOpt("M9-TKG Home Wrecker", &GiveallPlayersaWeapon, "shotgun_trenchgun_t8_upgraded",player);
        break;
        case "All Players Specific Map Weapons":
        self addMenu("All Players Specific Map Weapons");
            self addOpt("-- Maps Specific --");
            self addOpt("Monkey Bombs (all non chaos maps only)", &GiveallPlayersaWeapon, "cymbal_monkey",player);
            self addOpt("tomahawk (blood of the dead only)", &GiveallPlayersaWeapon, "tomahawk_t8_upgraded",player);
            self addOpt("homunculus (all chaos maps only)", &GiveallPlayersaWeapon, "homunculus",player);
            self addOpt("Wunderwaffe (Tag der Toten only)", &GiveallPlayersaWeapon, "tesla_gun",player);
            self addOpt("thundergun (Tag der Toten only)", &GiveallPlayersaWeapon, "thundergun",player);
        break;
        case "All Players Account Management":
        self addMenu(menu, "All Players Account Management");
            self addOpt("-- HOST IS NOT EFFECTED BY THESE OPTIONS --");
            self addOpt("All Players Level 55", &AllMaxRank, player);
            self addOpt("All Players Level 1000", &AllLevel1000, player);
            self addOpt("All Players Max Weapon Rank", &AllMaxWeaponRanks, player);
            self addOpt("All Players Unlock All Achievements", &AllAchievements, player);
            self addOpt("All Players Unlock All Challenges", &AllUnlockAllChallenges, player);
            self addOpt("All Players Complete Active Contracts", &AllCompleteActiveContracts, player);
        break;
        default:
            foundplayer = false;
            players = GetPlayerArray();
            foreach(player in players)
            {
                sepmenu = StrTok(menu, " ");
                if(Int(sepmenu[(sepmenu.size - 1)]) == player GetEntityNumber())
                {
                    foundplayer = true;
                    self MenuOptionsPlayer(menu, player);
                }
            }
            
            if(!foundplayer)
            {
                self addMenu(menu, "404 ERROR");
                    self addOpt("Page Not Found");
            }
            break;
    }
}

MenuOptionsPlayer(menu, player)
{
    self endon(#"disconnect");
    
    sepmenu = StrTok(menu, " " + player GetEntityNumber());
    newmenu = "";
    for(a=0;a<sepmenu.size;a++)
    {
        newmenu += sepmenu[a];
        if(a != (sepmenu.size - 1))
            newmenu += " ";
    }
    
    switch(newmenu)
    {
        case "Basic Scripts":
            self addMenu(menu, "Basic Scripts");
                self addOptBool(player.godmode, "God Mode", &Godmode, player);
                self addOptBool(player.Noclip, "Noclip", &Noclip1, player);
                self addOptBool(player.UnlimitedAmmo, "Unlimited Ammo", &UnlimitedAmmo, player);
                self addOptBool(player.UnlimitedSprint, "Unlimited Sprint", &UnlimitedSprint, player);
                self addOptIncSlider("Score", &EditPlayerScore, -10000, 0, 10000, 1000, player);
                self addOpt("Kill All Zombies", &KillAllZombies, player);
                self addOpt("Teleport Zombies", &TeleportZombies, player);
                self addOpt("Give All Perks", &perkaholic, "zm_bgb_perkaholic");
        break;
        case "Account Management":
            self addMenu(menu, "Account Management");
                self addOptBool(player.PlasmaLoop, "Plasma Loop", &PlasmaLoop, player);
                self addOpt("Level 55", &MaxRank, player);
                self addOpt("Level 1000", &Level1000, player);
                self addOpt("Max Weapon Rank", &MaxWeaponRanks, player);
                self addOpt("Unlock All Challenges", &UnlockAllChallenges, player);
                self addOpt("Unlock All Achievements", &Achievements, player);
                self addOpt("Complete Active Contracts", &CompleteActiveContracts, player);
                self addOpt("Stats Options", &newMenu, "Stats");
        break;

        case "Stats":
            self addMenu(menu,"Stats Options");
            self addOptIncSlider("Total Played", &Stats_TotalPlayed, 0, 0, 10000, 100);
            self addOptIncSlider("Highest Reached", &Stats_HighestReached, 0, 0, 10000, 100);
            self addOptIncSlider("Most Kills", &Stats_MostKills, 0, 0, 10000, 100);
            self addOptIncSlider("Most Headshots", &Stats_MostHeadshots, 0, 0, 10000, 100);
            self addOptIncSlider("Round", &Stats_Round, 0, 0, 10000, 100);
        break;
        case "Fun Menu":
        self addMenu(menu, "Fun Menu");
            self addOptBool(self.Multijump, "Multi Jump", &Multijump);
            self addOpt("Spawn Luna Wolf", &LunaWolf);
            self addOpt("Equipment Stays Healthy", &equipment_stays_healthy);
            self addOpt("Save Location", &SaveLocation, 0);
            self addOpt("Load Location", &SaveLocation, 1);
            self addOptBool(self.ignoreme, "Zombies Ignore You", &zignore);
            self addOptBool(self.killtxt,"kill text", &KillText);
            self addOptBool(self.personal_instakill, "Permanent Insta Kill", &selfInstaKill);
            self addOptBool(self.TeleGun, "Teleport Gun", &StartTeleGun);
            self addOptBool(player.thirdperson, "Third Person", &thirdperson, player);
            self addOpt("Clone Yourself", &Clone);
            self addOpt("Zombies Left", &ZombieCount);
            self addOpt("Send All Zombies Into Space", &ZombiesInSpace);
            self addOpt("HeadLess Zombies", &HeadLess);
            self addOpt("Earthquake", &quake, player);
            self addOpt("Sounds Menu", &newMenu, "Sounds Menu");
            self addOpt("Bullets Menu", &newMenu,"Bullets Menu");
            self addOpt("Powerups Menu", &newMenu, "Powerups Menu");
        break;
        case "Bullets Menu":
        self addMenu(menu, "Bullets Menu");
            self addOpt("= Turn OFF The Current One =");
            self addOpt("= Before Applying Another =");
            self addOpt("Ray Gun mk2", &magicbullets, "ray_gun_mk2_upgraded");
            self addOpt("Hellion Salvo", &magicbullets, "launcher_standard_t8_upgraded");
            self addOpt("Minigun", &magicbullets, "minigun");
            self addOpt("Ballistic Knife", &magicbullets, "special_ballisticknife_t8_dw_upgraded");
            self addOpt("Crossbow", &magicbullets, "special_crossbow_t8_upgraded");
        break;
        case "Powerups Menu":
            self addMenu(menu, "Powerups Menu");
            self addOpt("Max Ammo", &Powerups, 0);
            self addOpt("Fire Sale", &Powerups , 1);
            self addOpt("Bonus Points", &Powerups , 2);
            self addOpt("Free Perk", &Powerups , 3);
            self addOpt("Nuke", &Powerups , 4);
            self addOpt("Hero Weapon", &Powerups , 5);
            self addOpt("Insta kill", &Powerups , 6);
            self addOpt("Double Points", &Powerups , 7);
            self addOpt("Carpenter", &Powerups , 8);
            break;
        case "Sounds Menu":
            self addMenu(menu, "Sounds Menu");
            self addOpt("cha ching", &sound1);
            self addOpt("Max Ammo", &sound2);
            self addOpt("Monkey Scream", &sound3);
            self addOpt("Out Of Bounds", &sound4);
        break;

        case "Weapon Options":
    self addMenu(menu, "Weapon Options");
        self addOpt("Weapons", &newMenu, "Weapons");
        self addOpt("Maps Specific Weapons", &newMenu, "Maps Specific");
        self addOpt("Pack-A-Punched Weapons", &newMenu, "Pack-A-Punched Weapons");
        self addOpt("Camos (Can Cause Crashs)", &newMenu, "Camos"); // camos on specific guns can cause crashs!
        self addOpt("Pack-A-Punch Current Weapon", &packapunchweapon);
        self addOpt("Drop Current Weapon", &WeaponOpt, 2);
        self addOpt("Take Current Weapon", &WeaponOpt, 0);
        self addOpt("Take All Weapons", &WeaponOpt, 1);
        self addOpt("Refill Current Ammo", &WeaponOpt, 3);

        break;

   case "Camos":
        self addMenu(menu, "Camos");
            for(a=0;a<96;a++)
            self addOpt("Camo: " + (a + 1), &Camos, a);
        break;
        case "Weapons":
            self addMenu(menu, "Weapons");
            self addOpt("-- Specials --");
            self addOpt("Hellion Salvo", &GivePlayerWeapon, "launcher_standard_t8");
            self addOpt("Minigun", &GivePlayerWeapon, "minigun");
            self addOpt("Ballistic Knife", &GivePlayerWeapon, "special_ballisticknife_t8_dw");
            self addOpt("Ray Gun MK2", &GivePlayerWeapon, "ray_gun_mk2");
            self addOpt("Crossbow", &GivePlayerWeapon, "special_crossbow_t8");
            
            self addOpt("-- Sniper Rifles --");
            self addOpt("Outlaw", &GivePlayerWeapon, "sniper_fastrechamber_t8");
            self addOpt("Paladin HB50", &GivePlayerWeapon, "sniper_powerbolt_t8");
            self addOpt("SDM", &GivePlayerWeapon, "sniper_powersemi_t8");
            self addOpt("Koshka", &GivePlayerWeapon, "sniper_quickscope_t8");

            self addOpt("-- Tactical Rifles --");
            self addOpt("Auger DMR", &GivePlayerWeapon, "tr_powersemi_t8");
            self addOpt("Swordfish", &GivePlayerWeapon, "tr_longburst_t8");
            self addOpt("ABR 223", &GivePlayerWeapon, "tr_midburst_t8");

            self addOpt("-- Lightmachine Guns --");
            self addOpt("VKM 750", &GivePlayerWeapon, "lmg_heavy_t8");
            self addOpt("Hades", &GivePlayerWeapon, "lmg_spray_t8");
            self addOpt("Titan", &GivePlayerWeapon, "lmg_standard_t8");

            self addOpt("-- Assault Rifles --");
            self addOpt("ICR-7", &GivePlayerWeapon, "ar_accurate_t8");
            self addOpt("Maddox RFB", &GivePlayerWeapon, "ar_fastfire_t8");
            self addOpt("Rampart 17", &GivePlayerWeapon, "ar_damage_t8");
            self addOpt("Vapr-XKG", &GivePlayerWeapon, "ar_stealth_t8");
            self addOpt("KN-57", &GivePlayerWeapon, "ar_modular_t8");
            self addOpt("Hitchcock M9", &GivePlayerWeapon, "ar_mg1909_t8");
            self addOpt("Galil", &GivePlayerWeapon, "ar_galil_t8");

            self addOpt("-- Submachine Guns --");
            self addOpt("MX9", &GivePlayerWeapon, "smg_standard_t8");
            self addOpt("Saug 9mm", &GivePlayerWeapon, "smg_handling_t8");
            self addOpt("Spitfire", &GivePlayerWeapon, "smg_fastfire_t8");
            self addOpt("Cordite", &GivePlayerWeapon, "smg_capacity_t8");
            self addOpt("GKS", &GivePlayerWeapon, "smg_accurate_t8");
            self addOpt("Escargot", &GivePlayerWeapon, "smg_drum_pistol_t8");
            self addOpt("Switchblade x9", &GivePlayerWeapon, "smg_folding_t8");

            self addOpt("-- Pistols --");
            self addOpt("RK 7 Garrison", &GivePlayerWeapon, "pistol_burst_t8");
            self addOpt("Mozu", &GivePlayerWeapon, "pistol_revolver_t8");
            self addOpt("Strife", &GivePlayerWeapon, "pistol_standard_t8");
            self addOpt("Welling", &GivePlayerWeapon, "pistol_topbreak_t8");

            self addOpt("-- Shotguns --");
            self addOpt("Mog 12", &GivePlayerWeapon, "shotgun_pump_t8");
            self addOpt("SG12", &GivePlayerWeapon, "shotgun_semiauto_t8");
            self addOpt("Trenchgun", &GivePlayerWeapon, "shotgun_trenchgun_t8");
            
            self addOpt("-- Equipment --");
            self addOpt("Acid Bomb", &GivePlayerWeapon, "eq_acid_bomb");
            self addOpt("Molotov", &GivePlayerWeapon, "eq_molotov");
            self addOpt("Sticky Grenade", &GivePlayerWeapon, "sticky_grenade");
            self addOpt("Claymore", &GivePlayerWeapon, "claymore");
            self addOpt("Bouncingbetty", &GivePlayerWeapon, "bouncingbetty");
            self addOpt("Mini Turret", &GivePlayerWeapon, "mini_turret");

        break;
        case "Maps Specific":
            self addMenu(menu, "Maps Specific");
            self addOpt("Monkey Bombs (all non chaos maps only)", &GivePlayerWeapon, "cymbal_monkey");
            self addOpt("tomahawk (blood of the dead only)", &GivePlayerWeapon, "tomahawk_t8_upgraded");
            self addOpt("homunculus (all chaos maps only)", &GivePlayerWeapon, "homunculus");
            self addOpt("Wunderwaffe (Tag der Toten only)", &GivePlayerWeapon, "ww_tesla_sniper_t8");
            self addOpt("thundergun (Tag der Toten only)", &GivePlayerWeapon, "thundergun");
            self addOpt("Galvaknuckles (Honestly unsure)", &GivePlayerWeapon, "galvaknuckles_t8");
        break;
        case "Pack-A-Punched Weapons":
            self addMenu(menu, "Pack-A-Punched Weapons");
            self addOpt("-- Specials --");
            self addOpt("Zitros Orbital Arbalest", &GivePlayerWeapon, "launcher_standard_t8_upgraded");
            self addOpt("Thekrauss Refibrillator++", &GivePlayerWeapon, "special_ballisticknife_t8_dw_upgraded");
            self addOpt("Porters Mark II Ray Gun", &GivePlayerWeapon, "ray_gun_mk2_upgraded");
            self addOpt("Minos's Zeal", &GivePlayerWeapon, "special_crossbow_t8_upgraded");
            
            self addOpt("-- Sniper Rifles --");
            self addOpt("D3SOL8 Regulator", &GivePlayerWeapon, "sniper_fastrechamber_t8_upgraded");
            self addOpt("Righteous Fury", &GivePlayerWeapon, "sniper_powerbolt_t8_upgraded");
            self addOpt("IT-5 LYT", &GivePlayerWeapon, "sniper_powersemi_t8_upgraded");
            self addOpt("Bakeneko", &GivePlayerWeapon, "sniper_quickscope_t8_upgraded");

            self addOpt("-- Tactical Rifles --");
            self addOpt("Dead Mans ReefRacker", &GivePlayerWeapon, "tr_powersemi_t8_upgraded");
            self addOpt("Astralo-Packy-Cormus", &GivePlayerWeapon, "tr_longburst_t8_upgraded");
            self addOpt("Br-r-rah", &GivePlayerWeapon, "tr_midburst_t8_upgraded");

            self addOpt("-- Lightmachine Guns --");
            self addOpt("Cackling Kaftar", &GivePlayerWeapon, "lmg_heavy_t8_upgraded");
            self addOpt("Acheron Alliterator", &GivePlayerWeapon, "lmg_spray_t8_upgraded");
            self addOpt("Tartarus Veil", &GivePlayerWeapon, "lmg_standard_t8_upgraded");

            self addOpt("-- Assault Rifles --");
            self addOpt("Impertinent Deanimator", &GivePlayerWeapon, "ar_accurate_t8_upgraded");
            self addOpt("Red Fiend Bull", &GivePlayerWeapon, "ar_fastfire_t8_upgraded");
            self addOpt("Parapetrifrier", &GivePlayerWeapon, "ar_damage_t8_upgraded");
            self addOpt("Creeping Haze", &GivePlayerWeapon, "ar_stealth_t8_upgraded");
            self addOpt("Ruined Revenger", &GivePlayerWeapon, "ar_modular_t8_upgraded");
            self addOpt("Waking Nightmare", &GivePlayerWeapon, "ar_mg1909_t8_upgraded");
            self addOpt("Gravestone", &GivePlayerWeapon, "ar_galil_t8_upgraded");

            self addOpt("-- Submachine Guns --");
            self addOpt("Nuevemuertes xx", &GivePlayerWeapon, "smg_standard_t8_upgraded");
            self addOpt("Stellar 92", &GivePlayerWeapon, "smg_handling_t8_upgraded");
            self addOpt("Sky Scorcher", &GivePlayerWeapon, "smg_fastfire_t8_upgraded");
            self addOpt("Corpsemaker", &GivePlayerWeapon, "smg_capacity_t8_upgraded");
            self addOpt("Ghoul Keepers Subjugator", &GivePlayerWeapon, "smg_accurate_t8_upgraded");
            self addOpt("PieceDerResistance", &GivePlayerWeapon, "smg_drum_pistol_t8_upgraded");
            self addOpt("Excisenin3fold", &GivePlayerWeapon, "smg_folding_t8_upgraded");
            
            self addOpt("-- Pistols --");
            self addOpt("Rapskallion 3D", &GivePlayerWeapon, "pistol_burst_t8_upgraded");
            self addOpt("Belle Of The Ball", &GivePlayerWeapon, "pistol_revolver_t8_upgraded");
            self addOpt("Z-Harmony", &GivePlayerWeapon, "pistol_standard_t8_upgraded");
            self addOpt("King & Country", &GivePlayerWeapon, "pistol_topbreak_t8_upgraded");

            self addOpt("-- Shotguns --");
            self addOpt("OMG Right Hook", &GivePlayerWeapon, "shotgun_pump_t8_upgraded");
            self addOpt("Breccius Rebornus", &GivePlayerWeapon, "shotgun_semiauto_t8_upgraded");
            self addOpt("M9-TKG Home Wrecker", &GivePlayerWeapon, "shotgun_trenchgun_t8_upgraded");
        break;
        case "Options":
            altSubs = StrTok("Basic Scripts,Account Management,Fun Menu,", ",");
            
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("Verification", &newMenu, "Verification " + player GetEntityNumber());
                for(a=0;a<altSubs.size;a++)
                    self addOpt(altSubs[a], &newMenu, altSubs[a] + " " + player GetEntityNumber());
                    self addOpt("Teleports ",&newMenu, "Teleports"+ " " + player GetEntityNumber());
                    self addOpt("Kick: " + player getName() + " | Client Num: " + player GetEntityNumber(), &ClientOpts, player, 0);
                    self addOpt("Suicide " + player getName() + " | Client Num: " + player GetEntityNumber(), &suicide, player);
                    self addOpt("Revive: " + player getName() + " | Client Num: " + player GetEntityNumber(), &ClientOpts, player, 3);
            break;

        case "Verification":
            self addMenu(menu, "Verification");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
            break;
        case "Teleports":
            self addMenu(menu, "Teleports | " + player getName());
            self addOpt("Teleport To: " + player getName() + " | Client Num: " + player GetEntityNumber(), &ClientOpts, player, 2);
            self addOpt("Teleport: " + player getName() + " | Client Num: " + player GetEntityNumber() + " To Me", &ClientOpts, player, 1);
            self addOpt("Teleport Zombies "+ player getName() + " | Client Num: " + player GetEntityNumber() , &TeleportZombies, player);
            self addOpt("Send To Space"+ player getName() + " | Client Num: " + player GetEntityNumber() , &TeleTSpace, player);
            break;
        default:
            self addMenu(menu, "404 ERROR");
                self addOpt("Page Not Found");
            break;
    }
}

menuMonitor()
{
    self endon(#"disconnect");
    
    while(true)
    {
        if(self getVerification() > 0)
        {
            if(!self isInMenu())
            {
                if(self AdsButtonPressed() && self MeleeButtonPressed() && !isDefined(self.menu["DisableMenuControls"]))
                {
                    self openMenu1();
                    wait .25;
                }
            }
            else if(self isInMenu() && !isDefined(self.menu["DisableMenuControls"]))
            {
                if(self AdsButtonPressed() || self AttackButtonPressed())
                {
                    if(!self AdsButtonPressed() || !self AttackButtonPressed())
                    {
                        self.menu["curs"][self getCurrent()] += self AttackButtonPressed();
                        self.menu["curs"][self getCurrent()] -= self AdsButtonPressed();
                        
                        arry = self.menu["items"][self getCurrent()].name;
                        curs = self getCursor();

                        if(curs < 0 || curs > (arry.size - 1))
                            self setCursor((curs < 0) ? (arry.size - 1) : 0);

                        self drawText();
                        wait .13;
                    }
                }
                else if(self UseButtonPressed())
                {
                    menu = self getCurrent();
                    curs = self getCursor();
                    
                    if(isDefined(self.menu["items"][menu].func[curs]))
                    {
                        if(isDefined(self.menuParent[(self.menuParent.size - 1)]) && self.menuParent[(self.menuParent.size - 1)] != "")
                        {
                            backMenu = self BackMenu();
                            if(self.menu["items"][menu].func[curs] == &newMenu && isDefined(backMenu))
                                self MenuArrays(backMenu);
                        }
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], isDefined(self.menu["items"][menu].slider[curs]) ? self.menu_S[menu][curs][self.menu_SS[menu][curs]] : int(self.menu_SS[menu][curs]), self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        else
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        if(isDefined(isDefined(self.menu["items"][menu].bool[curs])))
                            self RefreshMenu();
                        wait .15;
                    }
                }
                else if(self SecondaryOffhandButtonPressed() || self FragButtonPressed())
                {
                    if(!self SecondaryOffhandButtonPressed() || !self FragButtonPressed())
                    {
                        menu = self getCurrent();
                        curs = self getCursor();
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                        {
                            dir = self FragButtonPressed() ? 1 : -1;
                            if(isDefined(self.menu["items"][menu].slider[curs]))
                                self SetSlider(dir);
                            else
                                self SetIncSlider(dir);
                            self RefreshMenu();
                            wait .15;
                        }
                    }
                }
                else if(self MeleeButtonPressed())
                {
                    if(self getCurrent() == "Main")
                        self closeMenu1();
                    else
                        self newMenu();
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

ExecuteFunction(function, i1, i2, i3, i4, i5, i6)
{
    if(!isDefined(function))
        return;
    
    if(isDefined(i6))
        return self thread [[ function ]](i1, i2, i3, i4, i5, i6);
    if(isDefined(i5))
        return self thread [[ function ]](i1, i2, i3, i4, i5);
    if(isDefined(i4))
        return self thread [[ function ]](i1, i2, i3, i4);
    if(isDefined(i3))
        return self thread [[ function ]](i1, i2, i3);
    if(isDefined(i2))
        return self thread [[ function ]](i1, i2);
    if(isDefined(i1))
        return self thread [[ function ]](i1);
    
    return self thread [[ function ]]();
}

drawText()
{
    self endon("menuClosed");
    self endon(#"disconnect");
    
    if(!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;
    
    text = self.menu["items"][self getCurrent()].name;
    start = 0;

    if(self getCursor() > 3 && self getCursor() < (text.size - 4) && text.size > 8)
        start = self getCursor() - 3;
    if(self getCursor() > (text.size - 5) && text.size > 8)
        start = text.size - 8;
    
    if(text.size > 0)
    {        
        if(isDefined(self.menu["items"][self getCurrent()].title))
            self iPrintln("^0[ " + self.menu["items"][self getCurrent()].title + " ]");
        
        numOpts = text.size;
        if(numOpts >= 8)
            numOpts = 8;
        
        for(a=0;a<numOpts;a++)
        {
            str = text[(a + start)];
            if(isDefined(self.menu["items"][self getCurrent()].bool[(a + start)]))
                str += (isDefined(self.menu_B[self getCurrent()][(a + start)]) && self.menu_B[self getCurrent()][(a + start)]) ? " [ON]" : " [OFF]";
            else if(isDefined(self.menu["items"][self getCurrent()].incslider[(a + start)]))
                str += " < " + self.menu_SS[self getCurrent()][(a + start)] + " >";
            else if(isDefined(self.menu["items"][self getCurrent()].slider[(a + start)]))
                str += " < " + self.menu_S[self getCurrent()][(a + start)][self.menu_SS[self getCurrent()][(a + start)]] + " >";
            
            if(self getCursor() == (a + start))
                self iPrintln("^0  > " + str);
            else
                self iPrintln("^1" + str);
        }

        if(numOpts <= 8)
        {
            printSize = 8 - numOpts;
            for(a=0;a<printSize;a++)
                self iPrintln(".");
        }
    }

    self.lastRefresh = GetTime();
}

RefreshMenu()
{
    if(self hasMenu() && self isInMenu())
    {
        self MenuArrays(self getCurrent());
        self runMenuIndex(self getCurrent());
        self drawText();
    }
}

openMenu1(menu)
{
    if(!isDefined(menu) || isDefined(menu) && menu == "")
        menu = (isDefined(self.menu["currentMenu"]) && self.menu["currentMenu"] != "") ? self.menu["currentMenu"] : "Main";
    
    self.menu["currentMenu"] = menu;
    self.playerSetting["isInMenu"] = true;
    self RefreshMenu();
    self thread MonitorMenuRefresh();
}

MonitorMenuRefresh()
{
    self endon(#"disconnect");
    self endon("menuClosed");

    if(self isInMenu())
    {
        while(self isInMenu())
        {
            if(self.lastRefresh < GetTime() - 6000)
                self drawText();
            wait 1;
        }
    }
}

closeMenu1()
{
    self DestroyOpts();
    self notify("menuClosed");
    self.playerSetting["isInMenu"] = undefined;
}

DestroyOpts()
{
    for(a=0;a<3;a++)
        self iPrintln(".");
    self iPrintln("^0Menu Closed");
    self iPrintln("^1" + level.menuName);
    self iPrintln(" ^3By - " + level.menuDeveloper);
    self iPrintln ("^0Credits");
    self iPrintln("^1 Original & Help From - ^3" + level.menuDeveloper1);
    for(a=0;a<4;a++)
        self iPrintln(".");
}
