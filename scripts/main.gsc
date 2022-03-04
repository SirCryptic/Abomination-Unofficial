/*
    Black Ops 4 Abomination - Unofficial 1.0.4
    Developed By: SirCryptic

    Credits:
        CF4_99  ~ For Helping & The Base Menu
        Extinct ~ Wouldn't have the attachment stats without him
        Serious ~ BO4 Compiler
        Discord.gg/MXT



    - Is This A Full Unlock All, or is it just partial like that menu Lucy?
        ~ This is a full unlock all. 100% completion with all camos.
    
    - Will This work for multiplayer?
        ~ No
    
    - Do you need to wait for the pop-up to stop to end the game?
        ~ No. When it notifies you it's over, then you can end the game.
    
    - How do you give other clients unlock all
        ~ Player Menu -> player's name -> Account Management



    Includes:
        - Max Rank
        - Max Weapon Rank
        - All Camos(Included with Unlock All Challenges)
        - All Attachments(Included with the Max Weapon Ranks)
        - All Reticles(Included with the Max Weapon Ranks)
        - All Calling Cards(Included with Unlock All Challenges)
        - Complete Active Contracts
    
    Known issues:
        - You will have to get a kill with each scope attachment to complete the reticle unlocks

    The only free "unlock all" that was released wasn't a full unlock all and was made by a nub.
    You'll probably see this in his menu at some point

    NOTE: It will only unlock camos for weapons you have unlocked. So if you don't have a weapon unlocked, it won't unlock all camos for that weapon.
    So it's best if you or the client you're running the unlock all on, is max rank.
    
    For Best Results:
        - Start A Game
        - Set Max Rank
        - End The Game
        - Start A New Game
        - Complete All Challenges
    
    If you use this to make a full menu, please leave credit.
*/

init()
{
    level thread InitializeVarsPrecaches();
}

onPlayerSpawned()
{
    if(!isDefined(self.menuThreaded))
        self thread playerSetup();
}

InitializeVarsPrecaches()
{
    if(isDefined(level.InitializeVarsPrecaches))
        return;
    level.InitializeVarsPrecaches = true;

    level.menuName = "Abomination - Unofficial";
    level.menuDeveloper = "SirCryptic";
    level.menuDeveloper1 = "CF4_99";
    level.AutoVerify = 0; //Auto Verification
    level.MenuStatus = StrTok("None,Verified,VIP,Co-Host,Admin,Host,Developer", ",");
}

playerSetup()
{
    if(isDefined(self.menuThreaded))
        return;
    
    self defineVariables();
    if(!self IsHost())
    {
        if(!isDefined(self.playerSetting["verification"]))
            self.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
    }
    else
        self.playerSetting["verification"] = level.MenuStatus[(level.MenuStatus.size - 2)];
    
    wait 1;
    if(self hasMenu())
    {
        for(a=0;a<3;a++)
            self iPrintln(".");
        self iPrintln("^1Welcome To " + level.menuName);
    self iPrintln(" ^3By - " + level.menuDeveloper);
    self iPrintln ("^0Credits");
    self iPrintln("^1 Original & Help From - ^3" + level.menuDeveloper1);
        self iPrintln("^1Status: " + self.playerSetting["verification"]);
        for(a=0;a<4;a++)
            self iPrintln(".");
    }
    
    self thread menuMonitor();
    self.menuThreaded = true;
}
 
defineVariables()
{
    if(isDefined(self.DefinedVariables))
        return;
    self.DefinedVariables = true;
    
    if(!isDefined(self.menu))
        self.menu = [];
    if(!isDefined(self.playerSetting))
        self.playerSetting = [];
        
    self.playerSetting["isInMenu"] = undefined;
}
