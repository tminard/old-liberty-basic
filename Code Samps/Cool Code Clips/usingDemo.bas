'   usingDemo.bas  --  Bill Jennings, April 2002
'       Format a number with non-numerics

    fmat$="г╡зо$ ##,###,###,###,###,###,###.## в"

       'numbers to be formatted:
    DATA 22222222222222229999  'large whole number
    DATA -12345678912.4567     'typical rounding
    DATA -123456789123.4567    'minus sign spaced over
    DATA 1199.999999999999
    DATA 1.4555599999
    DATA -1234567891234.555999999
    for num=1 to 6
      READ n
        'subroutine checks number:
    gosub [checkNumber]
        'first function rounds number:
    roun$=Rounded$(n,dp,lp)
        'second function imposes format:
    formatNum$=fmatNum$(fmat$,roun$)

      print num;"  ";formatNum$
    next num
  END
'-------------------------------------------
[checkNumber]
    dp=0   'find decimal places (dp) & leading places (lp)
    d=instr(fmat$,".")  'check for decimal in format
    if d then
      for j=d+1 to len(fmat$)
        if mid$(fmat$,j,1)="#" then dp=dp+1
      next j
    else
      d=len(fmat$)
    end if
    for j=1 to d
      if mid$(fmat$,j,1)="#" then lp=lp+1
    next j

        'see if integer portion is too large for format:
    nLen=len(str$(int(n)))
    if nLen>lp then_
      notice "Notice:"+chr$(13)+"Format "+fmat$+" is"+_
      chr$(13)+"inadequate for "+str$(n) : stop
  RETURN
'----------------------------------
Function fmatNum$(fmat$,roun$)
    DIM c$(len(fmat$))
    for j=1 to len(fmat$)
      c$(j)=mid$(fmat$,j,1)
    next j

    DIM d$(len(roun$))
    for j=1 to len(roun$)
      d$(j)=mid$(roun$,j,1)
    next j

      'Find commas permissable in integer:
    a$=trim$(roun$)  'remove minus sign if present
    if left$(a$,1)="-" then a$=mid$(a$,2)
    p=instr(a$,".")-1  'start from left of decimal point,
    if p<1 then p=len(a$)  'or end of string
    comPermis=int((p+2)/3)-1

       'swap characters going backwards:
    fmatNum$="" : n=len(roun$)+1
    for j=len(fmat$) to 1 step-1
      SELECT CASE c$(j)
        CASE "."  'decimal point
          n=n-1
          fmatNum$="."+fmatNum$
        CASE "#"  'digit or space or minus
          n=n-1
          if n<1 then  'add spaces in front
            fmatNum$=" "+fmatNum$
          else
            fmatNum$=d$(n)+fmatNum$
          end if
        CASE ","  'comma delimiter
          nCom=nCom+1
          if nCom<=comPermis then
            fmatNum$=","+fmatNum$
          else
            fmatNum$=" "+fmatNum$
          end if
        CASE else
          fmatNum$=c$(j)+fmatNum$
      END SELECT
    next j
  End Function
'-------------------------------------
Function Rounded$(n,dp,lp)
    'IN: n
    'OUT: Rounded$
    '*** Specify dp (decimal places)
    '        and lp (leading places)
    xp=1   ' Get exact value of 10^dp
           ' to avoid exponent operation.
    for j=1 to dp : xp=xp*10 : next j

    if n=0 then a=0 else a=int(n*xp+n/abs(n)/2)
    if n<0 then a=abs(a) : sign$="-"
    a$=str$(a)
    int$=sign$+left$(a$,len(a$)-dp)
    if int$="" then int$="0"
    while len(int$)<lp : int$=" "+int$ : wend
    d$="00000000000000000000"
    d$=d$+d$+d$  'long enough!
    dec$=right$(d$+a$,dp)
    dot$="." : if dp=0 then dot$=""
    Rounded$=int$+dot$+dec$
  End Function
'-------------------------------------
