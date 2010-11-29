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
// Must retain this copyright notice in all realted dj tool.tower v.1.5 scripts.
// 
// Permission is granted to copy, distribute and/or modify this document
// under the terms of the GNU Free Documentation License, Version 1.3
// or any later version published by the Free Software Foundation;
// with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
// A copy of the license is included in the file entitled "GNU_License.txt"
//
////////////////////////////////////////////////////////////////////////////////////////////////////

string gName = "!Shout"; //notecard to be red
string gText;
integer gLine = 0; //Line to start at
key gQueryID; //id used to identify dataserver queries

float minutes = 600; //10 minutes

notice_message () 
{
    gQueryID = llGetNotecardLine(gName, 0);
}

default
{
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if ( llToLower(msg) == "turn on")
        {   
            integer textMinutes = num/10;
            llOwnerSay("Your message will be shouted every " + (string)textMinutes + " minutes");
            llOwnerSay("Remember your message is set by what is in the !Shout notecard");
            minutes = num;
            state on;
        }

        if ( llToLower(msg) == "turn off")
        {
            llOwnerSay("Your announcement message is off.");
            llResetScript();
        }  
    }
}

state on
{
    state_entry()
    {
        notice_message();
        llSetTimerEvent(minutes);
    }
    
    timer()
    {
        notice_message();
    }

    dataserver(key query_id, string data) 
    {
        if (query_id == gQueryID) 
        {
            if (data != EOF)    // not at the end of the notecard
            {
                if (llSubStringIndex(data, "##") == -1)
                {
                    llShout (0, data);
                    ++gLine;                // increase line count
                    gQueryID = llGetNotecardLine(gName, gLine);    // request next line
                } else if (llSubStringIndex(data, "##") != -1)
                {
                   ++gLine;
                    gQueryID = llGetNotecardLine(gName, gLine);    // request next line
                }
            }
        }
    }

    link_message (integer sender_num, integer num, string msg, key id)
    {
        if ( llToLower(msg) == "turn on")
        {  
            integer textMinutes = num/10;
            llOwnerSay("Your message will be shouted every " + (string)textMinutes + " minutes");
            llOwnerSay("Remember your message is set by what is in the !Shout notecard");
            minutes = num;
            llSetTimerEvent(0.); 
            llSetTimerEvent(minutes); 
        }
        
        if ( llToLower(msg) == "turn off")
        {
            llOwnerSay("Your announcement message will stop being shouted");
            llResetScript();
        }  
    }
    
    state_exit()
    {
        llSetTimerEvent(0.0);
    }
}