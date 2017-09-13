
// The following ifdef block is the standard way of creating macros which make exporting 
// from a DLL simpler. All files within this DLL are compiled with the WMLIBERTY_EXPORTS
// symbol defined on the command line. this symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see 
// WMLIBERTY_API functions as being imported from a DLL, wheras this DLL sees symbols
// defined with this macro as being exported.
#ifdef WMLIBERTY_EXPORTS
#define WMLIBERTY_API __declspec(dllexport)
#else
#define WMLIBERTY_API __declspec(dllimport)
#endif

typedef LRESULT (CALLBACK *WMLIBERTY_CALLBACK)( HWND, UINT, WPARAM, LPARAM );

typedef struct WINDOW_INFO *LPWINDOW_INFO;

struct WINDOW_INFO
{
	HWND hWnd;
	UINT uMsgLow;
	UINT uMsgHigh;
	WNDPROC lpfnOldProc;
	WMLIBERTY_CALLBACK lpfnCallback;
	LONG success;

	LPWINDOW_INFO nextWnd;
};

extern LPWINDOW_INFO g_pWndHead;

extern UINT g_uMsgLow;
extern UINT g_uMsgHigh;

EXTERN_C WMLIBERTY_API ATOM RegisterMDIFrameClass( LPCTSTR, UINT, int, int, HINSTANCE, HICON, HCURSOR, HBRUSH );
EXTERN_C WMLIBERTY_API ATOM RegisterMDIChildClass( LPCTSTR, UINT, int, int, HINSTANCE, HICON, HCURSOR, HBRUSH );

EXTERN_C WMLIBERTY_API HWND CreateMDIClient( UINT, int, int, int, int, HWND, HMENU, HINSTANCE, HANDLE, UINT );
EXTERN_C WMLIBERTY_API HWND CreateMDIClientEx( UINT, UINT, int, int, int, int, HWND, HMENU, HINSTANCE, HANDLE, UINT );

EXTERN_C WMLIBERTY_API LONG SetWMHandler( HWND, UINT, WMLIBERTY_CALLBACK, LONG );
EXTERN_C WMLIBERTY_API LONG SetWMRangeHandler( HWND, UINT, UINT, WMLIBERTY_CALLBACK, LONG );

EXTERN_C WMLIBERTY_API LONG WMLibertyVersion( VOID );

LRESULT DoCallback( HWND, UINT, WPARAM, LPARAM, LPWINDOW_INFO );
LRESULT ForwardMessage( HWND, UINT, WPARAM, LPARAM );
VOID RemoveWindowInfo( HWND );

LRESULT WINAPI WindowProc( HWND, UINT, WPARAM, LPARAM );
LRESULT WINAPI FrameProc( HWND, UINT, WPARAM, LPARAM );
LRESULT WINAPI ChildProc( HWND, UINT, WPARAM, LPARAM );
