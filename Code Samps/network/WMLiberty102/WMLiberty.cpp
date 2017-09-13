// WMLiberty.cpp : Defines the entry point for the DLL application.
//
// VERSION 1.0
// 2002-01-17  Brent Thorn  <lbgui@aol.com>
// Created WMLiberty.
//
// VERSION 1.01
// 2002-01-27  Brent Thorn
// Changed SetWMHandler and SetWMRangeHandler. Added "success" parameter.
// Added MDI support.
// Fixed bug not allowing more than one WM range per window.
//
// VERSION 1.02
// 2002-01-30  Brent Thorn
// Enabled MDI system keys (Ctrl+Tab, Ctrl+F4, and Ctrl+F6).
//

#include "stdafx.h"
#include "WMLiberty.h"

LPWINDOW_INFO g_pWndHead = NULL;

UINT g_uMsgLow = WM_NULL;
UINT g_uMsgHigh = WM_NULL;

BOOL APIENTRY DllMain( HANDLE hModule, DWORD fdwReason, LPVOID lpReserved )
{
    switch ( fdwReason )
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
		break;
	case DLL_PROCESS_DETACH:
		LPWINDOW_INFO info;

		for ( info = g_pWndHead; info; info = info->nextWnd )
		{
			if ( IsWindow(info->hWnd) )
			{
				SetWindowLong(info->hWnd, GWL_WNDPROC, (LONG)info->lpfnOldProc);
				RemoveWindowInfo(info->hWnd);
				info = g_pWndHead;
			}
		}
		break;
    }
    return TRUE;
}

EXTERN_C WMLIBERTY_API 
LONG WMLibertyVersion( VOID )
{
	return 101;
}

EXTERN_C WMLIBERTY_API 
LONG SetWMHandler( HWND hWnd, UINT uMsg, WMLIBERTY_CALLBACK lpfnCallback, LONG success )
{
	LPWINDOW_INFO info;
	BOOL found;

	if ( !IsWindow(hWnd) ) return 1;
	if ( uMsg == WM_NULL ) return 2;
	if ( lpfnCallback == NULL ) return 3;

	found = FALSE;
	for ( info = g_pWndHead; info; info = info->nextWnd )
	{
		if ( info->hWnd == hWnd )
		{
			found = TRUE;
			break;
		}
	}
	
	if ( !g_pWndHead ) //add first item
	{
		g_pWndHead = new WINDOW_INFO;
		g_pWndHead->nextWnd = NULL;
		
		g_uMsgLow = g_uMsgHigh = uMsg;
	}
	else //add subsequent items
	{
		LPWINDOW_INFO nextWnd = g_pWndHead;
		g_pWndHead = new WINDOW_INFO;
		g_pWndHead->nextWnd = nextWnd;
		
		if ( uMsg < g_uMsgLow ) g_uMsgLow = uMsg;
		if ( uMsg > g_uMsgHigh ) g_uMsgHigh = uMsg;
	}
	g_pWndHead->hWnd = hWnd;
	g_pWndHead->uMsgLow = g_pWndHead->uMsgHigh = uMsg;
	g_pWndHead->lpfnCallback = lpfnCallback;
	g_pWndHead->success = success;
	
	if ( found ) //don't subclass again
	{
		g_pWndHead->lpfnOldProc = info->lpfnOldProc;
	}
	else //subclass it
	{
		g_pWndHead->lpfnOldProc = (WNDPROC)SetWindowLong(hWnd, GWL_WNDPROC, (LONG)WindowProc);
	}

	return 0;
}

EXTERN_C WMLIBERTY_API 
LONG SetWMRangeHandler( HWND hWnd, UINT uMsgLow, UINT uMsgHigh, WMLIBERTY_CALLBACK lpfnCallback, LONG success )
{
	if ( uMsgLow == WM_NULL	|| uMsgLow > uMsgHigh ) return 2;
	if ( uMsgHigh == WM_NULL ) return 3;

	LONG errcode = SetWMHandler(hWnd, uMsgLow, lpfnCallback, success);

	if ( errcode )
	{
		return errcode + ((errcode >= 3) ? 1 : 0);
	}
	else
	{
		g_pWndHead->uMsgHigh = uMsgHigh;
		
		if ( uMsgLow < g_uMsgLow ) g_uMsgLow = uMsgLow;
		if ( uMsgHigh > g_uMsgHigh ) g_uMsgHigh = uMsgHigh;
	}

	return errcode;
}

EXTERN_C WMLIBERTY_API 
ATOM RegisterMDIFrameClass( LPCTSTR lpszClassName, UINT style, int cbClsExtra, int cbWndExtra, HINSTANCE hInstance, HICON hIcon, HCURSOR hCursor, HBRUSH hbrBackground )
{
	WNDCLASS wc;

	wc.style = style;
	wc.lpfnWndProc = (WNDPROC)FrameProc;
	wc.cbClsExtra = cbClsExtra;
	wc.cbWndExtra = cbWndExtra + sizeof(HWND); //storage for MDICLIENT hWnd
	wc.hInstance = hInstance;
	wc.hIcon = hIcon;
	wc.hCursor = hCursor;
	wc.hbrBackground = hbrBackground;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = lpszClassName;

	return RegisterClass(&wc);
}

EXTERN_C WMLIBERTY_API 
HWND CreateMDIClient( UINT dwStyle, int x, int y, int nWidth, int nHeight, HWND hWndParent, HMENU id, HINSTANCE hInstance, HANDLE hWindowMenu, UINT idFirstChild )
{
	return CreateMDIClientEx(0, dwStyle, x, y, nWidth, nHeight, hWndParent, id, hInstance, hWindowMenu, idFirstChild);
}

EXTERN_C WMLIBERTY_API 
HWND CreateMDIClientEx( UINT dwExStyle, UINT dwStyle, int x, int y, int nWidth, int nHeight, HWND hWndParent, HMENU id, HINSTANCE hInstance, HANDLE hWindowMenu, UINT idFirstChild )
{
	if ( nWidth < 0 || nHeight < 0 )
	{
		RECT rc;

		GetClientRect(hWndParent, &rc);
		
		if ( nWidth < 0 ) nWidth = rc.right;
		if ( nHeight < 0 ) nHeight = rc.bottom;
	}

	CLIENTCREATESTRUCT ccs;

	ccs.hWindowMenu = hWindowMenu;
	ccs.idFirstChild = idFirstChild;

	HWND hWnd = CreateWindowEx(dwExStyle, "MDICLIENT", NULL, dwStyle, x, y, nWidth, nHeight, hWndParent, id, hInstance, (LPVOID)&ccs);
	
	if ( hWnd )
	{
		SetWindowLong(hWndParent, 0, (LONG)hWnd);
	}

	return hWnd;
}

EXTERN_C WMLIBERTY_API 
ATOM RegisterMDIChildClass( LPCTSTR lpszClassName, UINT style, int cbClsExtra, int cbWndExtra, HINSTANCE hInstance, HICON hIcon, HCURSOR hCursor, HBRUSH hbrBackground )
{
	WNDCLASS wc;

	wc.style = style;
	wc.lpfnWndProc = (WNDPROC)ChildProc;
	wc.cbClsExtra = cbClsExtra;
	wc.cbWndExtra = cbWndExtra;
	wc.hInstance = hInstance;
	wc.hIcon = hIcon;
	wc.hCursor = hCursor;
	wc.hbrBackground = hbrBackground;
	wc.lpszMenuName = NULL;
	wc.lpszClassName = lpszClassName;

	return RegisterClass(&wc);
}

LRESULT DoCallback( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam, WINDOW_INFO **info )
{
	for ( *info = g_pWndHead; *info; *info = (*info)->nextWnd )
	{
		if ( hWnd == (*info)->hWnd )
		{
			if ( uMsg >= (*info)->uMsgLow && uMsg <= (*info)->uMsgHigh )
			{
				return (*(*info)->lpfnCallback)(hWnd, uMsg, wParam, lParam);
			}
		}
	}

	return 0;
}

LRESULT ForwardMessage( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam )
{
	LPWINDOW_INFO info;

	for ( info = g_pWndHead; info; info = info->nextWnd )
	{
		if ( hWnd == info->hWnd )
		{
			return CallWindowProc(info->lpfnOldProc, hWnd, uMsg, wParam, lParam);
		}
	}

	return 0;
}

VOID RemoveWindowInfo( HWND hWnd )
{
	if ( g_pWndHead->nextWnd ) //more than one item
	{
		if ( hWnd == g_pWndHead->hWnd ) //check the head item
		{
			LPWINDOW_INFO nextWnd = g_pWndHead->nextWnd;
			delete g_pWndHead;
			g_pWndHead = nextWnd;
		}
		else //traverse the list
		{
			LPWINDOW_INFO prevWnd, info;

			for ( prevWnd = g_pWndHead, info = g_pWndHead->nextWnd; 
			      info; 
			      prevWnd = info, info = info->nextWnd )
			{
				if ( hWnd == info->hWnd )
				{
					prevWnd->nextWnd = info->nextWnd;
					delete info;
					info = prevWnd->nextWnd;
				}
			}
		}
	}
	else //just the one item
	{
		if ( hWnd == g_pWndHead->hWnd )
		{
			delete g_pWndHead;
			g_pWndHead = NULL;
		}
	}
}

LRESULT WINAPI WindowProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam )
{
	if ( WM_DESTROY == uMsg )
	{
		LRESULT result = ForwardMessage(hWnd, uMsg, wParam, lParam);
		RemoveWindowInfo(hWnd);
		return result;
	}
	else if ( uMsg >= g_uMsgLow && uMsg <= g_uMsgHigh )
	{
		LPWINDOW_INFO info;
		LRESULT result = DoCallback(hWnd, uMsg, wParam, lParam, &info);
		if ( info && result == info->success ) return result;
		return ForwardMessage(hWnd, uMsg, wParam, lParam);
	}
	
	return ForwardMessage(hWnd, uMsg, wParam, lParam);
}

LRESULT WINAPI FrameProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam )
{
	HWND hWndMDIClient = (HWND)GetWindowLong(hWnd, 0);

	return DefFrameProc(hWnd, hWndMDIClient, uMsg, wParam, lParam);
}

LRESULT WINAPI ChildProc( HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam )
{
	if ( WM_KEYDOWN == uMsg )
	{
		MSG msg;

		msg.hwnd = hWnd;
		msg.message = uMsg;
		msg.wParam = wParam;
		msg.lParam = lParam;

		TranslateMDISysAccel(GetParent(hWnd), &msg);
	}
	
	return DefMDIChildProc(hWnd, uMsg, wParam, lParam);
}
