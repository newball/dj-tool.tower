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

string gName = "!Floating Text"; //notecard to be red
string float_Text="";
integer gLine = 0; //Line to start at
key gQueryID; //id used to identify dataserver queries

notice_message () 
{
    gLine = 0;
    gQueryID = llGetNotecardLine(gName, gLine);
}

default 
{
    state_entry()
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
                    float_Text += data + "\n";
                    ++gLine;                // increase line count
                    gQueryID = llGetNotecardLine(gName, gLine);    // request next line
                } else if (llSubStringIndex(data, "##") != -1)
                {
                   ++gLine;
                    gQueryID = llGetNotecardLine(gName, gLine);    // request next line
                }                     
            } else {
                llSetText(float_Text, <1,0,0>, 3.0);
            } 
        }
    }

    link_message (integer sender_num, integer num, string msg, key id)
    {
        if ( llToLower(msg) == "title off")
        {
            state off;
        }  
    }    
}

state off
{
    state_entry()
    {

        llSetText(llDeleteSubString(float_Text, 0, -1), <1,0,0>, 3.0);
        float_Text = "";
    }

    link_message(integer sender_num, integer num, string msg, key id)
    {
        if (llToLower(msg) == "title on")
        {
            state default;
        }   
    }
}