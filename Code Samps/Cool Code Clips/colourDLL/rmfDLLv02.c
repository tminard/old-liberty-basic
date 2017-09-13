#include <windows.h>     
#include <richedit.h>
#include <string.h>		// for strupr()
#include <math.h>		// for pow()

#define LB3_API EXTERN_C __declspec(dllexport)

DOUBLE hex2rgb(CHAR *hex);

////////////////////////////
LB3_API
BOOL WINAPI DllMain (HINSTANCE hInstance, DWORD Reason, LPVOID Reserved)
{
  if(Reason==DLL_PROCESS_ATTACH)
	{
  	return   TRUE;
  	}

  if(Reason==DLL_PROCESS_DETACH)
  	{
  	return   TRUE;
  	}

  return   FALSE;
}

////////////////////////////////
LB3_API
HWND InputBoxHEX(HWND handle, CHAR *inkHex, CHAR *paperHex,
		INT x, INT y, INT w, INT h,
		INT limit)
{	
	HINSTANCE   hRTFLIB;
	LONG        hInst;
	HWND        hTB;
	LONG        result;
	CHARFORMAT  cf;
	LONG        selectflag;

	hRTFLIB = LoadLibraryA("RICHED20.DLL");
	
	hInst = GetWindowLong(handle, GWL_HINSTANCE);

	hTB = CreateWindowExA(
                          WS_EX_WINDOWEDGE, // extended style
                          "RICHEDIT20A",    // class name
                          "",               // title or string
                          WS_CHILD | WS_VISIBLE | WS_BORDER, // window style
                          x,                // x org
                          y,                // y org
                          w,                // width
                          h,                // height
                          handle,           // parent window
                          NULL,             // handle to menu = 0 for class menu
                          (HINSTANCE)hInst, //instance handle of parent window
                          NULL);            // always NULL
		
   	cf.cbSize      = sizeof(cf);
	selectflag     = 4;
	cf.dwMask      = CFM_COLOR;
	cf.dwEffects   = 0;
	cf.crTextColor = (LONG)hex2rgb(inkHex);	// See function below which converts the
                                                // string parameters into DOUBLE rgb values.
   	result = SendMessageA(hTB,
			      EM_SETCHARFORMAT,
			      selectflag,
    			      (LPARAM)&cf);

	result = SendMessageA(hTB,
		              EM_SETBKGNDCOLOR,
			      0,
                              (LONG)hex2rgb(paperHex));
	
	result = SendMessageA(hTB,
		              EM_LIMITTEXT,
			      limit,
			      0);

	return hTB;
}

///////////////////////////
LB3_API
HWND InputBoxRGB(HWND handle, INT iRed, INT iGreen, INT iBlue,
			                 INT pRed, INT pGreen, INT pBlue,
						     INT x, INT y, INT w, INT h,
							 INT limit)
{	
	HINSTANCE   hRTFLIB;
	LONG        hInst;
	HWND        hTB;
	LONG        result;
    LONG        ink;
	LONG        paper;
	CHARFORMAT  cf;
	LONG        selectflag;

	hRTFLIB = LoadLibraryA("RICHED20.DLL");
	
	hInst = GetWindowLong(handle, GWL_HINSTANCE);

	hTB = CreateWindowExA(
                          WS_EX_WINDOWEDGE, // extended style
                          "RICHEDIT20A",    // class name
                          "",               // title or string
                          WS_CHILD | WS_VISIBLE | WS_BORDER, // window style
                          x,                // x org
                          y,                // y org
                          w,                // width
                          h,                // height
                          handle,           // parent window
                          NULL,             // handle to menu = 0 for class menu
                          (HINSTANCE)hInst, //instance handle of parent window
                          NULL);            // always NULL

	ink   = iRed + (iGreen*256) + (iBlue*256*256);
	paper = pRed + (pGreen*256) + (pBlue*256*256);

	result = SendMessageA(hTB,
		                  EM_SETBKGNDCOLOR,
						  0,
                          paper);
	
   	cf.cbSize      = sizeof(cf);
	selectflag     = 4;
	cf.dwMask      = CFM_COLOR;
	cf.dwEffects   = 0;
	cf.crTextColor = ink;

   	result = SendMessageA(hTB,
						  EM_SETCHARFORMAT,
						  selectflag,
    					  (LPARAM)&cf);

	result = SendMessageA(hTB,
		                  EM_LIMITTEXT,
						  limit,
						  0);

	return hTB;
}

/////////////////////////
DOUBLE hex2rgb(CHAR *hex)
{
	CHAR temp1[7];
	INT  temp2, j;
	INT  dig5, dig4, dig3,
		 dig2, dig1, dig0;
	DOUBLE rgb;

// Transpose RED and BLUE
	temp1[0] = hex[6];
	temp1[1] = hex[7];
	temp1[2] = hex[4];
	temp1[3] = hex[5];
	temp1[4] = hex[2];
	temp1[5] = hex[3];
	temp1[6] = '\0';
		
// Get decimal values for each char
	strupr(temp1);

	for(j=0; j<=5; j++)
	{
		if(temp1[j] == '0') temp2 =  0;
		if(temp1[j] == '1') temp2 =  1;
		if(temp1[j] == '2') temp2 =  2;
		if(temp1[j] == '3') temp2 =  3;
		if(temp1[j] == '4') temp2 =  4;
		if(temp1[j] == '5') temp2 =  5;
		if(temp1[j] == '6') temp2 =  6;
		if(temp1[j] == '7') temp2 =  7;
		if(temp1[j] == '8') temp2 =  8;
		if(temp1[j] == '9') temp2 =  9;
		if(temp1[j] == 'A') temp2 = 10;
		if(temp1[j] == 'B') temp2 = 11;
		if(temp1[j] == 'C') temp2 = 12;
		if(temp1[j] == 'D') temp2 = 13;
		if(temp1[j] == 'E') temp2 = 14;
		if(temp1[j] == 'F') temp2 = 15;

		if     (j==0)dig5 = temp2;
		else if(j==1)dig4 = temp2;
		else if(j==2)dig3 = temp2;
		else if(j==3)dig2 = temp2;
		else if(j==4)dig1 = temp2;
		else if(j==5)dig0 = temp2;

	}

// Calculate RGB value
	rgb = dig5*(pow(16,5))+
		  dig4*(pow(16,4))+
		  dig3*(pow(16,3))+
		  dig2*(pow(16,2))+
	   	  dig1*(pow(16,1))+
		  dig0*(pow(16,0));

	return rgb;

}
