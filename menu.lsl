////////////////////////////////////////////////////////////////////////////////////////////////////
//
// dj tool.tower v.1.5
// by Nexeus Fatale / Leo Newball
// Copyright (c) 2008, 2009, 2010 by Leo Newball
// 
// This script is a part of the dj tool.tower v.1.5
//
// This script is for use within SecondLife, OpenSim and related worlds.
// It can be used as a part of commercial, and non-commercial products.
// It CANNOT be sold on it's own.
// Must retain this copyright notice in all related dj tool.tower v.1.5 scripts.
// 
// Permission is granted to copy, distribute and/or modify this document
// under the terms of the GNU Free Documentation License, Version 1.3
// or any later version published by the Free Software Foundation;
// with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
// A copy of the license is included in the file entitled "GNU_License.txt"
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//Version number
string version = "1.5";

//Counters for switches
integer switch_shout = 0;
integer switch_reminder = 0;
integer switch_title = 1;

//Variable Listing for menu commands
string menu_main = "Main";

// Main Menu
string mm_shout = "Shout";
string mm_reset_tool = "Reset Tool";
string mm_tips = "Tips";
string mm_requests_menu = "Requests";
string mm_title = "Title";
string mm_instructions = "Instructions";

// Request Menu
string rm_delete = "Delete";
string rm_reset = "Reset";
string rm_notice = "Reminder";
string rm_request_list = "Show";

// Tip Menu
string tm_amount = "Total";

// Shout Menu
string sm_ten_min = "10 minutes";
string sm_twenty_min = "20 minutes";
string sm_thirty_min = "30 minutes";
string sm_fourty_min = "40 minutes";
string sm_fifty_min = "50 minutes";
string sm_sixty_min = "60 minutes";
string sm_off = "Shout Off";

integer USER_REQ_ID;

integer CHANNEL;

//Menus
list MAIN_MENU = [mm_tips, mm_reset_tool, mm_requests_menu, mm_shout, mm_title, mm_instructions];
list REQUEST_MENU = [rm_reset, rm_delete, rm_notice, menu_main, rm_request_list];
list SHOUT_MENU = [sm_fourty_min, sm_fifty_min, sm_sixty_min, sm_ten_min, sm_twenty_min, sm_thirty_min, menu_main, sm_off];

_menu(integer chan) {
    llDialog(llGetOwner(), "The dj tool.tower Main Menu (version:" + version + ")
Instruction - Sends you the Instruction Manual
Requests - Displays the Request Menu.
Shout - Displays the Shout Menu.
Title - Toggles the hovering text.
Tips - Displays the amount of tips you have received since being rezzed.
Reset - Resets your tool to its default state.", MAIN_MENU, chan);
}

_requestmenu(integer chan) {
    llDialog(llGetOwner(), "the dj tool. tower request menu (version: " + version + ")
Main - Returns you to the Main Menu
Show - Displays a list of your current requests
Reset - Clears all of your current requests
Delete - Displays instructions for removing requests from the queue
Reminder - Toggles on/off a reminder updating the owner/dj how many requests are still in queue, every 5 minutes", REQUEST_MENU, chan);
}

_shoutmenu(integer chan) {
    llDialog(llGetOwner(), "the dj tool. tower shout timer (version: " + version + ")
    Determine how long you would like your announcement to be made", SHOUT_MENU, chan);
}

default
{
    on_rez(integer startparam)
    {
        llOwnerSay("Your DJ Tool has been rezzed and is reseting requests, and tip amounts since the last use");
        switch_shout = 0;
        switch_reminder = 0;
        switch_title = 1;   
    }
    
    state_entry() 
    {
        llOwnerSay("Your DJ Tool has been rezzed and is reseting requests, and tip amounts since the last use");
        switch_shout = 0;
        switch_reminder = 0;
        switch_title = 1;   
    }
        
    touch_start(integer total_number)
    {
        CHANNEL = (integer)(llFrand(99999.0) * -1);
        if (CHANNEL == 555) {
            CHANNEL = (integer)(llFrand(99999.0) * -1);
        }

        llListen(CHANNEL, "", NULL_KEY, "");
        key owner = llGetOwner();
        key toucher = llDetectedKey(0);
        
        if (owner == toucher)
        {
            _menu(CHANNEL);
        }
    }
    
    listen (integer chan, string name, key id, string msg)
    {
        if (msg == "Requests")
        {
            _requestmenu(CHANNEL);
        }
    
        if (msg == "Reset Tool")
        {
            llOwnerSay("The tool is being reset to it's default settings");
            llMessageLinked(LINK_THIS, 0, "Reset", llDetectedOwner(0));
            llMessageLinked(LINK_THIS, 0, "request reminder off", llDetectedOwner(0));
            llMessageLinked(LINK_THIS, 0, "Turn Off", NULL_KEY);
            llMessageLinked(LINK_THIS, 0, "Title On", NULL_KEY);
            _menu(CHANNEL);
        }
        
        if (msg == "Title")
        {
            if (switch_title == 0)
            {
                llMessageLinked(LINK_THIS, 0, "Title On", NULL_KEY);
                switch_title = 1;
                _menu(CHANNEL);
            } else if (switch_title == 1)
            {
                llMessageLinked(LINK_THIS, 0, "Title Off", NULL_KEY);
                switch_title = 0;
                _menu(CHANNEL);
            }
        }
    
        if (msg =="Tips")
        {
            llMessageLinked(LINK_THIS, 0, "Tip Total", llDetectedOwner(0));        
            _menu(CHANNEL);
        }
    
        if (msg == "Shout")
        {
            _shoutmenu(CHANNEL);
        }
        
        if (msg == "10 minutes" || msg == "20 minutes" || msg == "30 minutes" || msg == "40 minutes" || msg == "50 minutes" || msg == "60 minutes" || msg == "Shout Off")
        {
            _menu(CHANNEL);
            if (msg == "10 minutes")
            {
                llMessageLinked(LINK_THIS, 100, "Turn On", NULL_KEY);
            }
        
            if (msg == "20 minutes")
            {
                llMessageLinked(LINK_THIS, 200, "Turn On", NULL_KEY);
            }
            
            if (msg == "30 minutes")
            {
                llMessageLinked(LINK_THIS, 300, "Turn On", NULL_KEY);
            }
            
            if (msg == "40 minutes")
            {
                llMessageLinked(LINK_THIS, 400, "Turn On", NULL_KEY);
            }
            
            if (msg == "50 minutes")
            {
                llMessageLinked(LINK_THIS, 500, "Turn On", NULL_KEY);
            }
            
            if (msg == "60 minutes")
            {
                llMessageLinked(LINK_THIS, 600, "Turn On", NULL_KEY);
            }

            if (msg == "Shout Off")
            {
                llMessageLinked(LINK_THIS, 0, "Turn Off", NULL_KEY);
            }
        }
    
        if (msg == "Show")
        {
            llMessageLinked(LINK_THIS, 0, "Request List", NULL_KEY);
            _requestmenu(CHANNEL);
        }
        
        if (msg == "Delete")
        {
            llMessageLinked(LINK_THIS, CHANNEL, "Request Delete", NULL_KEY);
        }

        if (msg == "Reset")
        {
            llOwnerSay("Resetting your request list.");
            llMessageLinked(LINK_THIS, 0, "Request Reset", NULL_KEY);
            _requestmenu(CHANNEL);
        }
        
        if (msg == "Reminder")
        {
            if (switch_reminder == 0)
            {
                llOwnerSay("Request Reminder On: Every Five Minutes You Will Be Notified of how many requests you have waiting");
                llMessageLinked(LINK_THIS, 0, "request reminder on", NULL_KEY);
                switch_reminder = 1;
                _requestmenu(CHANNEL);
            } else if (switch_reminder == 1)
            {
                llOwnerSay("Request Reminder Off");
                llMessageLinked(LINK_THIS, 0, "request reminder off", NULL_KEY);
                switch_reminder = 0;
                _requestmenu(CHANNEL);
            }
        }
        
        if (msg == "Instructions")
        {
            llGiveInventory(llGetOwner(), "!Instructions");
            _menu(CHANNEL);
        }
        
        if (msg == "Main")
        {
            _menu(CHANNEL);
        }
    }
}