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
                self addOpt("Misc", &newMenu, "Misc " + self GetEntityNumber());
                self addOpt("Weapons", &newMenu, "Weapons " + self GetEntityNumber());
                
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
                self addoptBool(level.B4Gravity, "Low Gravity", &Gravity);
                self addOptBool(self.AntiQuit, "Anti Quit", &AntiQuit);
                self addOpt("Anti Join", &AntiJoin);
                self addOpt("Restart Map", &RestartMap);
                self addOptIncSlider("Round: ", &SetRound, 0, 0, 255, 1);
        break;
        case "Host Menu":
            self addMenu(menu, "Host Menu");
                self addOptBool(self.aimbot, "Unfair Aimbot", &unfair_toggleaimbot);
                self addOpt("End Game", &EndGame);
                self addOpt("Add Bot", &AddBotsToGame);
                self addOpt("Force Host", &ForceHost);
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
                self addOpt("Teleport Zombies", &TeleportZombies);
                self addOpt("Drop Weapon", &DropWeapon);
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
            break;
        case "Fun Menu":
            self addMenu(menu, "Fun Menu");
            self addOptBool(self.Multijump, "Multi Jump", &Multijump);
            self addOpt("Save Location", &SaveLocation, 0);
            self addOpt("Load Location", &SaveLocation, 1);
            self addOptBool(self.personal_instakill, "Permanent Insta Kill", &selfInstaKill);
            self addOpt("Freeze Box Position", &FreezeMysteryBox);
            self addOptBool(self.TeleGun, "Teleport Gun", &StartTeleGun);
            self addOptBool(player.thirdperson, "Third Person", &thirdperson, player);
            self addOpt("Clone Yourself", &Clone);
        break;
                case "Misc":
            self addMenu(menu, "Misc");
            self addOpt("Zombies Left", &ZombieCount);
            self addOpt("Send To Space", &TeleTSpace, player);
            self addOpt("Suicide Player", &suicide, player);
            self addOpt("Teleport Me to Player", &ClientOpts, player, 2);
            self addOpt("Teleport Player to Me", &ClientOpts, player, 1);
        break;
               case "Weapons":
            self addMenu(menu, "Weapons");
            self addOpt("minigun", &minigun);
            self addOpt("ICR-7", &icr7);
            self addOpt("KN-57", &kn57);
            self addOpt("Maddox RFB", &maddox);
            self addOpt("Outlaw", &outlaw);
            self addOpt("Paladin HB50", &paladinhb50);
            self addOpt("VKM 750", &vkm750);
            self addOpt("Hades", &hades);
        break;


        case "Options":
            altSubs = StrTok("Basic Scripts,Account Management,Fun Menu,Misc", ",");
            
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("Verification", &newMenu, "Verification " + player GetEntityNumber());
                for(a=0;a<altSubs.size;a++)
                    self addOpt(altSubs[a], &newMenu, altSubs[a] + " " + player GetEntityNumber());
            break;
        case "Verification":
            self addMenu(menu, "Verification");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
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
