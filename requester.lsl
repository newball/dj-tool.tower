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

// Global variables
list requests;
integer chan = 555;
integer switch;

//functions
request_list ()
{
    integer len = llGetListLength( requests );
    integer i;
    integer req_num = 0; 
    if (len == 0)
    {
        llOwnerSay("You do not have any requests in queue");
    } else {
        llOwnerSay("You have " + (string)len + " requests:");
        for( i = 0; i < len; i++)
        {
            req_num++;
            llOwnerSay("No. " + (string)req_num + " " + llList2String(requests, i));
        }
    }
}

reset_request ()
{
    requests = llDeleteSubList(requests, 0, llGetListLength(requests));
    llOwnerSay("The request list has been reset.");
}

remove_request_msg (integer channel)
{
    llDialog(llGetOwner(), "To remove a request, type in '/555 delete request #'.  i.e. /555 delete 3", ["Requests"], channel);
}

remove_request (string message)
{
    integer entrynum = (integer)llGetSubString(message,7,-1);
    entrynum--;
    llOwnerSay("Removing: " + llList2String(requests,entrynum));
    requests = llDeleteSubList(requests, entrynum, entrynum);
    integer req_num = 0;
    request_list ();
}

// States
default
{
    on_rez (integer start_param)
    {
        requests = llDeleteSubList(requests, 0, llGetListLength(requests));
        switch = 0;
    }
    state_entry()
    {
        llListen(chan, "", "", "");
        switch = 0;
    }
    
    link_message(integer sender_num, integer num, string msg, key id)
    {
        if(llToLower(msg) == "request list")
        {
            request_list();
        }

        if(llToLower(msg) == "request reset" )
        {
            reset_request();
        }
        
        if (llToLower(msg) == "reset")
        {
            reset_request();    
        }
        
        if( llToLower(msg) == "request delete" )
        {
            remove_request_msg(num);
        }
    } 

    listen(integer channel, string name, key id, string message )
    {
        if (id != llGetOwner())
        {
            string request  = message + " was requested by " + name;
            requests += request;
            string requester_name = llKey2Name(id);
            llMessageLinked(LINK_THIS, 555, "Thank you " + requester_name + " for making a request, if the DJ is able, he will play it for you", id);
            llOwnerSay(requester_name + " has requested " + message);
            integer reqnum = llGetListLength(requests);
            llMessageLinked(LINK_THIS, reqnum, "request number", NULL_KEY);
        }
        
        if(id == llGetOwner())
        {
            if( llToLower(llGetSubString(message,0,6)) == "delete " )
            {
                remove_request(message);
            } else 
            {
                string request  = message + " was requested by " + name;
                requests += request;
                llOwnerSay("You have successfully placed " + message + " as a request.");
            }
        }
    }
}
