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

integer reqnum;

request_number()
{
    llOwnerSay("There are currently " + (string)reqnum + " requests waiting.");
}

default
{
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if (msg == "request reminder on")
        {
            llSetTimerEvent(300);
        }

        if (msg == "request reminder off")
        {
            llSetTimerEvent(0);
        }
        
        if (msg == "request number")
        {
            reqnum = num;
        }
    }
    
    timer()
    {
        request_number();
    }
}
