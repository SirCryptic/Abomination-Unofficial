getName()
{
    name = self.name;
    if(name[0] != "[")
        return name;
    for(a=(name.size - 1);a>=0;a--)
        if(name[a] == "]")
            break;
    return GetSubStr(name, (a + 1));
}

isInMenu()
{
    if(!isDefined(self.playerSetting["isInMenu"]))
        return false;
    return true;
}

isInArray(array, text)
{
    if(!isDefined(array) || isDefined(array) && !array.size)
        return false;
    
    for(a=0;a<array.size;a++)
        if(array[a] == text)
            return true;
    return false;
}

arrayRemove(array, value)
{
    if(!isDefined(array) || !isDefined(value))
        return;
    
    newArray = [];
    for(a=0;a<array.size;a++)
        if(array[a] != value)
            newArray[newArray.size] = array[a];
    return newArray;
}

getCurrent()
{
    return self.menu["currentMenu"];
}

getCursor()
{
    return self.menu["curs"][self getCurrent()];
}

setCursor(curs)
{
    self.menu["curs"][self getCurrent()] = curs;
}

SetSlider(dir)
{
    menu = self getCurrent();
    curs = self getCursor();
    max  = (self.menu_S[menu][curs].size - 1);
    slider = self.menu_SS[menu][curs];

    self.menu_SS[menu][curs] += dir > 0 ? 1 : -1;
    
    if(self.menu_SS[menu][curs] > max || self.menu_SS[menu][curs] < 0)
        self.menu_SS[menu][curs] = self.menu_SS[menu][curs] > max ? 0 : max;
}

SetIncSlider(dir)
{
    menu = self getCurrent();
    curs = self getCursor();
    slider = self.menu_SS[menu][curs];
    inc = self.menu["items"][menu].intincrement[curs];
    
    max = self.menu["items"][menu].incslidermax[curs];
    min = self.menu["items"][menu].incslidermin[curs];

    if(Int(self.menu_SS[menu][curs]) < max && self.menu_SS[menu][curs] + inc > max || Int(self.menu_SS[menu][curs]) > min && self.menu_SS[menu][curs] - inc < min)
        self.menu_SS[menu][curs] = (Int(self.menu_SS[menu][curs]) < max && self.menu_SS[menu][curs] + inc > max) ? max : min;
    else
        self.menu_SS[menu][curs] += dir > 0 ? inc : (inc * -1);

    if(self.menu_SS[menu][curs] > max || self.menu_SS[menu][curs] < min)
        self.menu_SS[menu][curs] = self.menu_SS[menu][curs] > max ? min : max;
}

BackMenu()
{
    return self.menuParent[(self.menuParent.size - 1)];
}

GetPlayerArray()
{
    players = GetEntArray("player", "classname");
    return players;
}

SpawnScriptModel(origin, model, angles)
{
    ent = Spawn("script_model", origin);
    ent SetModel(model);
    if(isDefined(angles))
        ent.angles = angles;
    
    return ent;
}