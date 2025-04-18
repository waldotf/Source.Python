/**
* =============================================================================
* Source Python
* Copyright (C) 2012-2015 Source Python Development Team.  All rights reserved.
* =============================================================================
*
* This program is free software; you can redistribute it and/or modify it under
* the terms of the GNU General Public License, version 3.0, as published by the
* Free Software Foundation.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
* details.
*
* You should have received a copy of the GNU General Public License along with
* this program.  If not, see <http://www.gnu.org/licenses/>.
*
* As a special exception, the Source Python Team gives you permission
* to link the code of this program (as well as its derivative works) to
* "Half-Life 2," the "Source Engine," and any Game MODs that run on software
* by the Valve Corporation.  You must obey the GNU General Public License in
* all respects for all other code used.  Additionally, the Source.Python
* Development Team grants this exception to all derivative works.
*/

#ifndef _PLAYERS_WRAP_H
#define _PLAYERS_WRAP_H

//-----------------------------------------------------------------------------
// Includes.
//-----------------------------------------------------------------------------
#include "game/server/player.h"
#include "public/game/server/iplayerinfo.h"
#include "boost/python.hpp"
using namespace boost::python;


//-----------------------------------------------------------------------------
// IPlayerInfo extension class
//-----------------------------------------------------------------------------
class IPlayerInfoExt
{
public:
	static PyObject* GetName(IPlayerInfo* pInfo)
	{
		const char* szValue = pInfo->GetName();
		return PyUnicode_DecodeUTF8(szValue, strlen(szValue), "ignore");
	}
};


//-----------------------------------------------------------------------------
// IClient extension class
//-----------------------------------------------------------------------------
class IClientExt
{
public:
	static void disconnect(IClient* pClient, const char* reason)
	{
// TODO: Get rid of this preproc and move that to their respective engine files.
#if defined(ENGINE_CSGO) || defined(ENGINE_BLADE)
		pClient->Disconnect(reason);
#else
		pClient->Disconnect("%s", reason);
#endif
	}

	static void Disconnect(IClient* pClient, const char* reason)
	{
		static object disconnect = make_function(&IClientExt::disconnect);
		static object Player = import("players").attr("entity").attr("Player");

		Player.attr("from_userid")(pClient->GetUserID()).attr("delay")(
			0,
			disconnect,
			make_tuple(ptr(pClient), reason)
		);
	}

#if !defined(ENGINE_BLADE) && !defined(ENGINE_CSGO) && !defined(ENGINE_LEFT4DEAD2)
	static bool IsHumanPlayer(IClient* pClient)
	{
		if (!pClient->IsConnected() || pClient->IsFakeClient() || pClient->IsHLTV())
			return false;

		return true;
	}
#endif

	static bool IsHearingClient(IClient* pClient, IClient* pSender)
	{
		if (!pSender)
			return false;

		return pClient->IsHearingClient(pSender->GetPlayerSlot());
	}

	static bool IsProximityHearingClient(IClient* pClient, IClient* pSender)
	{
		if (!pSender)
			return false;

		return pClient->IsProximityHearingClient(pSender->GetPlayerSlot());
	}
};


#endif // _PLAYERS_WRAP_H
