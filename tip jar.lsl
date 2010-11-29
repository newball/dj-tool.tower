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

integer tot_amt;
string sowner;


default
{
    on_rez (integer startparam)
    {
        tot_amt = 0;   
    }
    money(key giver, integer amount)
    {
        string giver_name = llKey2Name(giver);
        tot_amt += amount;
        sowner = llKey2Name(llDetectedOwner(0));
  
       llInstantMessage(giver, "Thank you " + giver_name + " for tipping " + (string)amount + "$L to " + sowner);
       llOwnerSay(giver_name + " has tipped you " + (string)amount + "$L");
       llOwnerSay("So far you have been tipped " + (string)tot_amt + "$L");
    }

    link_message(integer sender_num, integer num, string msg, key id)
    {
        if (llToLower(msg) == "tip total")
        {
            llOwnerSay("You have made " + (string)tot_amt + " $L total.");
        }
        
        if (llToLower(msg) == "tip reset")
        {
            llOwnerSay("You have made " + (string)tot_amt + " $L total.");
            tot_amt = 0;
            llOwnerSay("Your tip jar has been reset.");
        }
        
        if (msg == "reset")
        {
            tot_amt = 0;            
        }
    }
}