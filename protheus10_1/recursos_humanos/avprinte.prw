#INCLUDE "Avprinte.ch"
#include "FiveWin.ch"
#include "set.ch"

#define HORZSIZE            4
#define VERTSIZE            6
#define HORZRES             8
#define VERTRES            10
#define LOGPIXELSX         88
#define LOGPIXELSY         90
                                                	
#define MM_TEXT             1
#define MM_LOMETRIC         2       		
#define MM_HIMETRIC         3
#define MM_LOENGLISH        4
#define MM_HIENGLISH        5
#define MM_TWIPS            6
#define MM_ISOTROPIC        7
#define MM_ANISOTROPIC      8

#define PAD_LEFT            0
#define PAD_RIGHT           1
#define PAD_CENTER          2

// New defines for the oPrn:SetPage(nPage) method (The printer MUST support it)

#define DMPAPER_LETTER      1           // Letter 8 1/2 x 11 in
#define DMPAPER_LETTERSMALL 2           // Letter Small 8 1/2 x 11 in
#define DMPAPER_TABLOID     3           // Tabloid 11 x 17 in
#define DMPAPER_LEDGER      4           // Ledger 17 x 11 in
#define DMPAPER_LEGAL       5           // Legal 8 1/2 x 14 in
#define DMPAPER_STATEMENT   6           // Statement 5 1/2 x 8 1/2 in
#define DMPAPER_EXECUTIVE   7           // Executive 7 1/4 x 10 1/2 in
#define DMPAPER_A3          8           // A3 297 x 420 mm
#define DMPAPER_A4          9           // A4 210 x 297 mm
#define DMPAPER_A4SMALL     10          // A4 Small 210 x 297 mm
#define DMPAPER_A5          11          // A5 148 x 210 mm
#define DMPAPER_B4          12          // B4 250 x 354
#define DMPAPER_B5          13          // B5 182 x 257 mm
#define DMPAPER_FOLIO       14          // Folio 8 1/2 x 13 in
#define DMPAPER_QUARTO      15          // Quarto 215 x 275 mm
#define DMPAPER_10X14       16          // 10x14 in
#define DMPAPER_11X17       17          // 11x17 in
#define DMPAPER_NOTE        18          // Note 8 1/2 x 11 in
#define DMPAPER_ENV_9       19          // Envelope #9 3 7/8 x 8 7/8
#define DMPAPER_ENV_10      20          // Envelope #10 4 1/8 x 9 1/2
#define DMPAPER_ENV_11      21          // Envelope #11 4 1/2 x 10 3/8
#define DMPAPER_ENV_12      22          // Envelope #12 4 \276 x 11
#define DMPAPER_ENV_14      23          // Envelope #14 5 x 11 1/2
#define DMPAPER_CSHEET      24          // C size sheet
#define DMPAPER_DSHEET      25          // D size sheet
#define DMPAPER_ESHEET      26          // E size sheet
#define DMPAPER_ENV_DL      27          // Envelope DL 110 x 220mm
#define DMPAPER_ENV_C5      28          // Envelope C5 162 x 229 mm
#define DMPAPER_ENV_C3      29          // Envelope C3  324 x 458 mm
#define DMPAPER_ENV_C4      30          // Envelope C4  229 x 324 mm
#define DMPAPER_ENV_C6      31          // Envelope C6  114 x 162 mm
#define DMPAPER_ENV_C65     32          // Envelope C65 114 x 229 mm
#define DMPAPER_ENV_B4      33          // Envelope B4  250 x 353 mm
#define DMPAPER_ENV_B5      34          // Envelope B5  176 x 250 mm
#define DMPAPER_ENV_B6      35          // Envelope B6  176 x 125 mm
#define DMPAPER_ENV_ITALY   36          // Envelope 110 x 230 mm
#define DMPAPER_ENV_MONARCH 37          // Envelope Monarch 3.875 x 7.5 in
#define DMPAPER_ENV_PERSONAL 38         // 6 3/4 Envelope 3 5/8 x 6 1/2 in
#define DMPAPER_FANFOLD_US  39          // US Std Fanfold 14 7/8 x 11 in
#define DMPAPER_FANFOLD_STD_GERMAN  40  // German Std Fanfold 8 1/2 x 12 in
#define DMPAPER_FANFOLD_LGL_GERMAN  41  // German Legal Fanfold 8 1/2 x 13 in

#define BTN_OK        101
#define BTN_PRNSETUP  104
#define BTN_PREVIEW   105

#IFDEF PROTHEUS
#ELSE
extern Set
#ENDIF

static oPrinter

//----------------------------------------------------------------------------//

#IFDEF PROTHEUS
#ELSE
CLASS TAvPrinter

   DATA   oFont
   DATA   hDC, hDCOut
   DATA   aMeta
   DATA   cDir, cDocument, cModel
   DATA   nPage, nXOffset, nYOffset
   DATA   lMeta, lStarted, lModified
   DATA   lShow   //mjb1297

   METHOD New( cDocument, lUser, lMeta, cModel, cUser, cForm, lShow ) CONSTRUCTOR

   MESSAGE StartPage() METHOD _StartPage()
   MESSAGE EndPage() METHOD _EndPage()

   METHOD End()

   METHOD Say( nRow, nCol, cText, oFont, nWidth, nClrText, nBkMode, nPad )

   METHOD CmSay( nRow, nCol, cText, oFont, nWidth, nClrText, nBkMode, nPad );
           INLINE ;
           (::Cmtr2Pix(@nRow, @nCol),;
            ::Say( nRow, nCol, cText, oFont, nWidth, nClrText, nBkMode, nPad ))

   METHOD InchSay( nRow, nCol, cText, oFont, nWidth, nClrText, nBkMode, nPad );
           INLINE ;
           (::Inch2Pix(@nRow, @nCol),;
            ::Say( nRow, nCol, cText, oFont, nWidth, nClrText, nBkMode, nPad ))

   METHOD SayBitmap( nRow, nCol, cBitmap, nWidth, nHeight, nRaster )

   METHOD SetPos( nRow, nCol )  INLINE MoveTo( ::hDCOut, nCol, nRow )

   METHOD Line( nTop, nLeft, nBottom, nRight, oPen ) INLINE ;
                      MoveTo( ::hDCOut, nLeft, nTop ),;
                      LineTo( ::hDCOut, nRight, nBottom,;
                              If( oPen != nil, oPen:hPen, 0 ) )

   METHOD Box( nRow, nCol, nBottom, nRight, oPen ) INLINE ;
                      Rectangle( ::hDCOut, nRow, nCol, nBottom, nRight,;
                                 If( oPen != nil, oPen:hPen, 0 ) )

   METHOD Cmtr2Pix( nRow, nCol )

   METHOD DraftMode( lOnOff ) INLINE (DraftMode( lOnOff ),;
                                      ::Rebuild()         )

   METHOD Inch2Pix( nRow, nCol )

   METHOD Pix2Mmtr(nRow, nCol) INLINE ;
                               ( nRow := nRow * 25.4 / ::nLogPixelX() ,;
                                 nCol := nCol * 25.4 / ::nLogPixelY() ,;
                                 {nRow, nCol}                          )

   METHOD Pix2Inch(nRow, nCol) INLINE ;
                               ( nRow := nRow / ::nLogPixelX() ,;
                                 nCol := nCol / ::nLogPixelY() ,;
                                 {nRow, nCol}                   )

   METHOD nVertRes()  INLINE  GetDeviceCaps( ::hDC, VERTRES  )
   METHOD nHorzRes()  INLINE  GetDeviceCaps( ::hDC, HORZRES  )

   METHOD nVertSize() INLINE  GetDeviceCaps( ::hDC, VERTSIZE )
   METHOD nHorzSize() INLINE  GetDeviceCaps( ::hDC, HORZSIZE )

   METHOD nLogPixelX() INLINE GetDeviceCaps( ::hDC, LOGPIXELSX )
   METHOD nLogPixelY() INLINE GetDeviceCaps( ::hDC, LOGPIXELSY )

   METHOD SetPixelMode()  INLINE SetMapMode( ::hDC, MM_TEXT )
   METHOD SetTwipsMode()  INLINE SetMapMode( ::hDC, MM_TWIPS )

   METHOD SetLoInchMode() INLINE SetMapMode( ::hDC, MM_LOENGLISH )
   METHOD SetHiInchMode() INLINE SetMapMode( ::hDC, MM_HIENGLISH )

   METHOD SetLoMetricMode() INLINE SetMapMode( ::hDC, MM_LOMETRIC )
   METHOD SetHiMetricMode() INLINE SetMapMode( ::hDC, MM_HIMETRIC )

   METHOD SetIsotropicMode()   INLINE SetMapMode( ::hDC, MM_ISOTROPIC )
   METHOD SetAnisotropicMode() INLINE SetMapMode( ::hDC, MM_ANISOTROPIC )

   METHOD SetWindowExt( nUnitsWidth, nUnitsHeight ) INLINE ;
                        SetWindowExt( ::hDC, nUnitsWidth, nUnitsHeight )

   METHOD SetViewPortExt( nWidth, nHeight ) INLINE ;
                          SetViewPortExt( ::hDC, nWidth, nHeight )

   METHOD GetTextWidth( cText, oFont ) INLINE ;
                        GetTextWidth( ::hDC, cText, ::SetFont(oFont):hFont)

   METHOD GetTextHeight( cText, oFont ) INLINE ::SetFont(oFont):nHeight

   METHOD Preview() INLINE If( ::lMeta, (AvPrevi( Self ),SysRefresh()), ::End() )

   MESSAGE FillRect( aRect, oBrush )  METHOD _FillRect( aRect, oBrush )

   METHOD ResetDC() INLINE ResetDC( ::hDC )

   METHOD GetOrientation() INLINE  PrnGetOrientation()

   METHOD SetLandscape() INLINE ( PrnLandscape( ::hDC ),;
                                  ::Rebuild() )

   METHOD SetPortrait()  INLINE ( PrnPortrait( ::hDC ),;
                                  ::Rebuild() )

   METHOD SetCopies( nCopies ) INLINE ;
                               ( PrnSetCopies( ::hDC, nCopies ),;
                                 ::Rebuild()                    )

   METHOD SetSize( nWidth, nHeight ) INLINE ;
                               ( PrnSetSize( nWidth, nHeight ),;
                                 ::Rebuild()                   )

   METHOD SetPage( nPage ) INLINE ;
                           ( PrnSetPage( nPage ),;
                             ::Rebuild()         )

   METHOD GetModel() INLINE PrnGetName()

   METHOD GetPhySize()

   METHOD Setup() INLINE ( PrinterSetup(),;
                           ::Rebuild()    )

   METHOD Rebuild()

   METHOD SetFont( oFont )
   METHOD CharSay( nRow, nCol, cText )
   METHOD CharWidth()
   METHOD CharHeight()

   METHOD ImportWMF( cFile )

ENDCLASS

//----------------------------------------------------------------------------//

METHOD New( cDocument, lUser, lMeta, cModel, cUser, cForm, lShow ) CLASS TAvPrinter

   local aOffset
   local cPrinter

   DEFAULT cDocument := "AVERAGE FORMs", lUser := .f. , lMeta := .f.
   DEFAULT lShow := .F.

   if lUser
      ::hDC := GetPrintDC( GetActiveWindow() )    // com Dialog
   elseif cModel == NIL
      ::hDC  := GetPrintDefault( GetActiveWindow() ) // sem Dialog
      cModel := ::GetModel()
   else
      cPrinter := GetProfStr( "windows", "device" , "" )
      WriteProfStr( "windows", "device", cModel )
      SysRefresh()
      PrinterInit()
      ::hDC := GetPrintDefault( GetActiveWindow() )
      SysRefresh()
      WriteProfStr( "windows", "device", cPrinter  )
   endif

   if ::hDC != 0
      aOffset    := PrnOffset( ::hDC )
      ::nXOffset := aOffset[1]
      ::nYOffset := aOffset[2]
   endif

   ::cDocument  := cDocument
   ::cModel     := cModel
   ::nPage      := 0
   ::lMeta      := lMeta
   ::lStarted   := .F.
   ::lModified  := .F.
   ::lShow      := lShow

   if !lMeta
      ::hDcOut := ::hDC
   else
      ::aMeta  := {}
      ::cDir   := GetEnv("TEMP")

      if empty(::cDir)
         ::cDir := GetEnv("TMP")
      endif

      if !empty(::cDir)
         if !lIsDir(::cDir)
            MsgAlert(STR0001+; //"Sua variavel TEMP aponta para um diretorio errado"
                     CRLF+CRLF+upper(::cDir),;
                     "Printer object Error")
            ::cDir := GetWinDir()
         endif
      else
         ::cDir := GetWinDir()
      endif

      if Right( ::cDir, 1 ) == "\"
         ::cDir = SubStr( ::cDir, 1, Len( ::cDir ) - 1 )
      endif

   endif

return nil

//----------------------------------------------------------------------------//

METHOD End() CLASS TAvPrinter

   If ::hDC != 0
      if !::lMeta
         if ::lStarted
            EndDoc(::hDC)
         endif
      else
         if LEN(::aMeta) >0
            if LEFT(::aMeta[1],3)=="TMP"
               Aeval(::aMeta,{|val| ferase(val) })
            endif
         endif
         ::hDCOut := 0
      endif
      DeleteDC(::hDC)
      ::hDC := 0
   endif

   if ::lModified
     PrinterInit()
   endif

   oPrinter := NIL
   SysRefresh()  // by RS
Return NIL

//----------------------------------------------------------------------------//

METHOD Rebuild() CLASS TAvPrinter

   if ::lStarted
      if !::lMeta
         EndDoc(::hDC)
      else
         Aeval(::aMeta,{|val| ferase(val) })
         ::hDCOut := 0
      endif
   endif

   DeleteDC(::hDC)

   ::hDC        := GetPrintDefault( GetActiveWindow() )
   ::lStarted   := .F.
   ::lModified  := .T.

   if ::hDC != 0
      if !::lMeta
         ::hDcOut = ::hDC
      else
         ::aMeta  = {}
      endif
   endif

return nil

//----------------------------------------------------------------------------//

METHOD _StartPage() CLASS TAvPrinter

   LOCAL lSetFixed := Set( _SET_FIXED, .F. )

   if !::lMeta .AND. !::lStarted
      ::lStarted := .T.
      StartDoc( ::hDC, ::cDocument )
   endif

   ::nPage++

   if ::lMeta
      AAdd(::aMeta,::cDir+"\tmp"+Padl(::nPage,4,"0")+".wmf")
      ::hDCOut := CreateMetaFile(Atail(::aMeta))
   else
      StartPage(::hDC)
   endif

   Set(_SET_FIXED,lSetFixed )

Return NIL

//----------------------------------------------------------------------------//

METHOD _EndPage() CLASS TAvPrinter

   if ::lMeta
      ::hDCOut := DeleteMetaFile( CloseMetaFile( ::hDCOut ) )
      if !file(Atail(::aMeta))
          MsgAlert(STR0002+If(Atail(::aMeta) # NIL,; //"O Metafile nao pode ser criado"
                  CRLF+CRLF+Upper(Atail(::aMeta)),""),;
                  "Printer object Error")
      endif
   else
      EndPage( ::hDC )
   endif

Return NIL

//----------------------------------------------------------------------------//

METHOD Say( nRow, nCol, cText, oFont,;
            nWidth, nClrText, nBkMode, nPad ) CLASS TAvPrinter

   DEFAULT oFont   := ::oFont ,;
           nBkMode := 1       ,;
           nPad    := PAD_LEFT

   if oFont != nil
      oFont:Activate( ::hDCOut )
   endif

   SetbkMode( ::hDCOut, nBkMode )               // 1,2 transparent or Opaque

   if nClrText != NIL
     SetTextColor( ::hDCOut, nClrText )
   endif

   DO CASE
      CASE nPad == 0
      CASE nPad == PAD_RIGHT
          nCol := Max(0, nCol - ::GetTextWidth( cText, oFont ))
      CASE nPad == PAD_CENTER
          nCol := Max(0, nCol - (::GetTextWidth( cText, oFont )/2))
   ENDCASE

   TextOut( ::hDCOut, nRow, nCol, cText )

   if oFont != nil
      oFont:DeActivate( ::hDCOut )
   endif

return nil

//----------------------------------------------------------------------------//

METHOD SayBitmap( nRow, nCol, xBitmap, nWidth, nHeight, nRaster ) CLASS TAvPrinter

   local hDib, hPal, hBmp

   if ( valtype( xBitmap ) == "N" ) .OR. !file( xBitmap )
      hBmp := LoadBitmap( GetResources(), xBitmap )
      hPal := PalBmpLoad( xBitmap )
      hDib := DibFromBitmap( hBmp, nHiWord(hPal) )
   else
      hDib := DibRead( xBitmap )
   endif

   if hDib <= 0
     RETU NIL
   endif

   if ! ::lMeta
     hPal := DibPalette( hDib )
   endif

   DibDraw( ::hDCOut, hDib, hPal, nRow, nCol,;
            nWidth, nHeight, nRaster )

   GlobalFree( hDib )

   if ! ::lMeta
     DeleteObject( hPal )
   endif

return nil

//----------------------------------------------------------------------------//

METHOD _FillRect( aCols, oBrush ) CLASS TAvPrinter

   FillRect( ::hDCOut, aCols, oBrush:hBrush )

return nil

//----------------------------------------------------------------------------//

METHOD Cmtr2Pix( nRow, nCol ) CLASS TAvPrinter

   nRow := Max( 0, ( nRow * 10 * ::nVertRes() / ::nVertSize() ) - ::nXoffset )
   nCol := Max( 0, ( nCol * 10 * ::nHorzRes() / ::nHorzSize() ) - ::nYoffset )

return { nRow, nCol }

//----------------------------------------------------------------------------//

METHOD Inch2Pix( nRow, nCol ) CLASS TAvPrinter

   nRow := Max( 0, ( nRow * ::nVertRes() / (::nVertSize() / 25.4 ))-::nXoffset )
   nCol := Max( 0, ( nCol * ::nHorzRes() / (::nHorzSize() / 25.4 ))-::nYoffset )

return { nRow, nCol }

//----------------------------------------------------------------------------//

METHOD GetPhySize() CLASS TAvPrinter

   local aData := PrnGetSize( ::hDC )
   local nWidth, nHeight

   nWidth  := aData[ 1 ] / ::nLogPixelX() * 25.4
   nHeight := aData[ 2 ] / ::nLogPixelY() * 25.4

return { nWidth, nHeight }

//----------------------------------------------------------------------------//

METHOD SetFont( oFont ) CLASS TAvPrinter

   IF oFont != NIL
      ::oFont := oFont
   ELSEIF ::oFont == NIL
      DEFINE FONT ::oFont NAME "COURIER" SIZE 0,-12 OF Self
   ENDIF

RETURN ::oFont

//----------------------------------------------------------------------------//

METHOD CharSay( nRow, nCol, cText ) CLASS TAvPrinter

   LOCAL nPxRow, nPxCol

   ::SetFont()

   nRow   := Max(--nRow, 0)
   nCol   := Max(--nCol, 0)
   nPxRow := nRow * ::GetTextHeight( "", ::oFont )
   nPxCol := nCol * ::GetTextWidth( "B", ::oFont )

   ::Say( nPxRow, nPxCol, cText, ::oFont )

RETURN NIL

//----------------------------------------------------------------------------//

METHOD CharWidth() CLASS TAvPrinter

   ::SetFont()

RETURN Int( ::nHorzRes() / ::GetTextWidth( "B", ::oFont ))

//----------------------------------------------------------------------------//

METHOD CharHeight() CLASS TAvPrinter

   ::SetFont()

RETURN Int( ::nVertRes() / ::GetTextHeight( "",::oFont ))

//----------------------------------------------------------------------------//

METHOD ImportWMF( cFile, lPlaceable ) CLASS TAvPrinter

     LOCAL hMeta
     LOCAL aData := PrnGetSize( ::hDC )

     DEFAULT lPlaceable := .T.

     IF !file(cFile)
          RETU NIL
     ENDIF

     SaveDC( ::hDCOut )

     IF lPlaceable
          hMeta := GetPMetaFile( cFile )
     ELSE
          hMeta := GetMetaFile( cFile )
     ENDIF

     ::SetIsoTropicMode()
     ::SetWindowExt( aData[1], aData[2] )
     ::SetViewPortExt( aData[1], aData[2] )

     IF !::lMeta
          SetViewOrg( ::hDCOut, -::nXoffset, -::nYoffset )
     ENDIF

     SetBkMode(::hDCOut, 1)

     PlayMetaFile( ::hDCOut, hMeta )

     DeleteMetafile(hMeta)

     RestoreDC( ::hDCOut )

RETURN NIL
#ENDIF // #IFNDEF PROTHEUS
//----------------------------------------------------------------------------//

FUNCTION AvPrintBegin( cDoc, lUser, lPreview, xModel )

LOCAL oIni, cText, lFound:=.F., cDevice
LOCAL oDlg, oGet  //mjb1197
LOCAL cUser:=Subs(cUsuario,7,15), cPrinter:=PrnGetName() //mjb1197
LOCAL lShow:=.F.
#IFDEF PROTHEUS
	LOCAL aSessions, cIniFile
#ENDIF

If cDoc # NIL .And. !Empty(cDoc)

   //SetResources("SIGAEIC.DLL")	// Ramalho

   lShow:=.F.  ; lPreview:=.T.
	 #IFDEF PROTHEUS
   		DEFINE MSDIALOG oDlg OF oMainWnd FROM 0,0 TO 170,380 PIXEL TITLE STR0003 //"Impressão"
       		@ 10,10 MSGET cDoc SIZE 100,10 WHEN .F. OF oDlg PIXEL
          @ 30,10 MSGET cUser SIZE 100,10 WHEN .F. OF oDlg PIXEL
          @ 50,10 MSGET oGet VAR cPrinter SIZE 100,10 WHEN .F. OF oDlg PIXEL

					@ 10,130 BUTTON oBtnOk PROMPT STR0004 OF oDlg ACTION (lShow:=.F.,oDlg:End()) PIXEL //"&Ok"
          @ 30,130 BUTTON oBtnSetup PROMPT STR0005 OF oDlg ACTION (PrinterSetup(),cPrinter:=PrnGetName(),oGet:Refresh()) PIXEL //"&Setup"
          @ 50,130 BUTTON oBtnPreview PROMPT STR0006 OF oDlg ACTION (lShow:=.T.,oDlg:End()) PIXEL //"&Preview"
      ACTIVATE MSDIALOG oDlg CENTERED
   #ELSE
	   DEFINE MSDIALOG oDlg RESOURCE "AVPRNSET" OF oMainWnd

  	 REDEFINE MSGET  cDoc              When .F. ID 106 OF oDlg
	   REDEFINE MSGET  cUser             When .F. ID 110 OF oDlg
  	 REDEFINE MSGET  oGet VAR cPrinter When .F. ID 107 OF oDlg

	   REDEFINE BUTTON ID BTN_OK       OF oDlg ACTION (lShow:=.F.,oDlg:End())
  	 REDEFINE BUTTON ID BTN_PRNSETUP OF oDlg ACTION (PrinterSetup(),cPrinter:=PrnGetName(),oGet:Refresh())
	   REDEFINE BUTTON ID BTN_PREVIEW  OF oDlg ACTION (lShow:=.T.,oDlg:End())

  	 ACTIVATE MSDIALOG oDlg CENTERED
	 #ENDIF
   //SetResources(hSigaRes)		// Ramalho
Else
   lShow:=.T.
   If(Select("SY0")>0,cDoc:=SY0->Y0_DOC,)
Endif

#IFDEF PROTHEUS	

	if xModel == NIL
  	return oPrinter := TAvPrinter():New( cDoc, lUser, lPreview,,,,lShow )
	endif
    
	cIniFile:= GetRemoteIniName() 
	aSessions:= GetIniSessions(cIniFile)	

	if Ascan( aSessions,"PRINTER" )==0        
		tone(100,1)
    return oPrinter := TAvPrinter():New( cDoc, .T., lPreview,,,,lShow )
	endif

	if Valtype(xModel) == "C"		
		xModel := upper(xModel)	
	  cDevice:= GetPvProfString("PRINTER","DEFAULT","",cIniFile )	
		lFound:= ( Len( cDevice )>0 .and. Upper(cDevice)==xModel )
	else
	  cDevice:= GetPvProfString("PRINTER","DEFAULT","",cIniFile )	
		lFound:= Len( cDevice )>0
	endif

  if !lFound
  	tone(100,1)
    return oPrinter := TAvPrinter():New( cDoc, .T., lPreview )
	endif

	RETURN oPrinter := TAvPrinter():New( cDoc, .f., lPreview, cDevice )
	      
#ELSE
   if xModel == NIL
			return oPrinter := TAvPrinter():New( cDoc, lUser, lPreview,,,,lShow )
   endif

   oIni := tTxtFile():New(GetWinDir()+"\WIN.INI")

   if !oIni:Seek("[DEVICES]", 0, 1)
      tone(100,1)
      oIni:End()
      return oPrinter := TAvPrinter():New( cDoc, .T., lPreview,,,,lShow )
   endif

   if Valtype(xModel) == "C"

      oIni:Advance()

      xModel := upper(xModel)
      cText  := oIni:ReadLine()
      lFound := .F.

      Do While !empty(cText) .and. !"["$cText
         if xModel$upper(cText)
             lFound := .T.
             Exit
         endif
         oIni:Advance()
         cText := oIni:ReadLine()
      Enddo

   else

      oIni:Advance()
      cText := oIni:ReadLine()

      Do While !empty(cText) .and. !"["$cText
          xModel--
          if xModel == 0
               lFound := .T.
               Exit
          endif
         oIni:Advance()
         cText := oIni:ReadLine()
      Enddo

   endif

   oIni:End()

   if !lFound
      tone(100,1)
      return oPrinter := TAvPrinter():New( cDoc, .T., lPreview )
   endif

   cDevice := StrToken( cText, 1, "=" )
   cText   := StrToken( cText, 2, "=" )
   cDevice += "," + StrToken( cText, 1, "," )
   cDevice += "," + StrToken( cText, 2, "," )

	RETURN oPrinter := TAvPrinter():New( cDoc, .f., lPreview, cDevice )
#ENDIF
//----------------------------------------------------------------------------//

FUNCTION AvPageBegin() ; oPrinter:StartPage() ; RETURN nil

//----------------------------------------------------------------------------//

FUNCTION AvPageEnd() ; oPrinter:EndPage(); RETURN nil

//----------------------------------------------------------------------------//

FUNCTION AvPrintEnd()

LOCAL nOldArea:=Select()
LOCAL cDocument, aFiles

#IFDEF PROTHEUS
	LOCAL aToPrint, nCopias
#ENDIF	

IF oPrinter:lMeta

   If oPrinter:lShow
      oPrinter:Preview()
   Else
   		cDocument:= oPrinter:cDocument
   		aFiles:= AClone( oPrinter:aMeta ) 
      oPrinter:End()   
      #IFDEF PROTHEUS
      	aToPrint:=PgToPrint( oPrinter:nPage,,@nCopias )
      	if Len( aToPrint ) > 0     
	      	oPrinter:Print(aToPrint,nCopias)
				endif	      	
      #ELSE
	      AvGrvPrint( cDocument, aFiles ,.F.)      
	      AvDocView()
			#ENDIF	      
      // SY0->(DbCloseArea())   RS 1102
      DbSelectArea(nOldArea)
   Endif
Else
      oPrinter:End()
Endif

oPrinter := nil

RETURN nil
//----------------------------------------------------------------------------//
Function AvGrvPrint(cDocument,aPrintFiles)
//----------------------------------------------------------------------------//
LOCAL cDir:=GetMv("MV_RELT"), cNewFile, nPag

If ChkFile("SY0")

   While File(cDir+(cNewFile:="AV"+Subs(CriaTrab(,.F.),3))+'.001')
   End

   FOR I:=1 TO (nPag:=LEN(aPrintFiles))

       COPY FILE (aPrintFiles[I]) TO (cDir+cNewFile+'.'+Padl(I,3,'0'))

   NEXT

   RecLock("SY0",.T.)
   SY0->Y0_DOC    :=cDocument
   SY0->Y0_DATA   :=dDataBase
   SY0->Y0_HORA   :=Time()
   SY0->Y0_USUARIO:=Subs(cUsuario,7,15)
   SY0->Y0_ARQWMF :=cNewFile
   SY0->Y0_PAGINAS:=nPag
   SY0->Y0_CHVDTHR:=Str( CTOD("31/12/2999") - dDataBase,6,0) + ;
                    Str( 86400 - SECONDS(),6,0)
   MsUnlock()
Else
   MsgStop(STR0007) //"Nao foi possivel abrir o arquivo SY0"
Endif

*---------------------------------------------------------------------------
Function AvDocView(cAlias,nReg,nOpc)
*---------------------------------------------------------------------------
LOCAL cFile:=GetMv("MV_RELT")+Trim(SY0->Y0_ARQWMF)
LOCAL nPag, nTotPag:=SY0->Y0_PAGINAS, cImgFile, aMeta:={}
LOCAL lPrinter := (cAlias=NIL), oPrn

If !lPrinter
   oPrn:=AvPrintBegin(,.F.,.T.)
Endif

For nPag:=1 To nTotPag
    If File(cImgFile:=cFile+'.'+Padl(nPag,3,'0'))
       AADD(If(!lPrinter,oPrn:aMeta,aMeta),cImgFile)
    Else
       MsgStop(STR0008+cImgFile+STR0009) //"Arquivo de Imagem "###" nao encontrado"
    Endif
Next

If !lPrinter
   If Len(oPrn:aMeta) > 0
      oPrn:Preview()
   Endif
Elseif Len(aMeta) > 0
       AvPrintPage(aMeta)
Endif
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³AxPesqui	³ Autor ³ MJBARROS              ³ Data ³03/12/97  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Pesquisa Cadastro de Documentos Impressos                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ AxPesqDoc()                              		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso	     ³ SIGAEIC  						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Function AvPesqDoc
*---------------------------------------------------------------------------
LOCAL cAlias,cCampo,nReg,oDlg,nOpca:=0,bSav12 := SetKey(VK_F12,Nil)
Local cFil:="",nChave:=1,dCampo,cOrd,oCbx,nOpt1,nI, nSavReg
LOCAL dData:=SY0->Y0_DATA, cUser:="", cDoc:="", oData, oUser, oDoc, cData
cAlias  := ALIAS()

dbSelectArea(cAlias)
cCpoFil := Subs(cAlias,2,2)+"_FILIAL"
nSavReg := Recno()

IF cCpofil $ Indexkey() //TYPE(cCpoFil) != "U"
   dbSeek(cFilial)
Else
   DbGoTop()
Endif

If Eof()
   Help(" ",1,"A000FI")
   SetKey(VK_F12,bSav12)
   Return 3
ENDIF

dbGoTo(nSavReg)

nOpt1   := 1
PRIVATE aOrd := { }
nMaiorStr := 0

PesqOrd(cAlias)

// Pesquisa indices
aSize(aOrd,3)
cOrd := aOrd[1]
cCampo:=SPACE(40)
For ni:=1 to Len(aOrd)
    aOrd[nI] := OemToAnsi(aOrd[nI])
Next

IF IndexOrd() >= Len(aOrd)
   cOrd := aOrd[Len(aOrd)]
   nOpt1 := Len(aOrd)
ElseIf IndexOrd() <= 1
   cOrd := aOrd[1]
   nOpt1 := 1
Else
   cOrd := aOrd[IndexOrd()]
   nOpt1 := IndexOrd()
Endif

DEFINE MSDIALOG oDlg FROM 5, 5 TO 16, 50 TITLE OemToAnsi(STR0010) //"Pesquisa"

@ 0.6,1.3 COMBOBOX oCBX VAR cOrd ITEMS aOrd  SIZE 165,44 ;
          ON CHANGE (nOpt1:=oCbx:nAt,AvPesqGet(oCbx:nAt,oData,oUser,oDoc)) OF oDlg FONT oDlg:oFont

@ 25,010 SAY  STR0011               SIZE 020,08 PIXEL //"Data"
@ 25,085 SAY  OemToAnsi(STR0012)    SIZE 030,08 PIXEL //"Usuario"
@ 45,010 SAY  STR0013               SIZE 030,08 PIXEL //"Documento"

@ 25,045 MSGET oData VAR dData     SIZE 040,08 PIXEL 
@ 25,110 MSGET oUser VAR cUser     SIZE 065,08 PIXEL 
@ 45,045 MSGET oDoc  VAR cDoc      SIZE 105,08 PIXEL 

DEFINE SBUTTON FROM 065,120   TYPE 1 ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 065,149.1 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

IF nOpca == 0
   SetKey(VK_F12,bSav12)
   Return 0
Endif

nReg := RecNo()

dbSetOrder(nOpt1)

IF (SubStr(cAlias,2,2)+"_FILIAL") $ IndexKey()  //Procura pela filial
   cFil:=cFilial
   nChave:=11
EndIF

cData:=Str( CTOD("31/12/2999") - dData,6,0)

If nOpt1 == 1
   cCampo:=cData

Elseif nOpt1 == 2
       cCampo:=cDoc+cData

Elseif nOpt1 == 3
       cCampo:=cUser+cData
Endif

IF ("DTOS" $ IndexKey(nOpt1)) .or. ("DTOC" $ IndexKey(nOpt1))
   cCampo := ConvData(IndexKey(nOpt1),cCampo)
Endif

DbSeek(cFilial+RTrim(cCampo),.T.)

IF Subs(&(IndexKey()),1,2) != cFilial	 // IR Para EOF
   DbSeek(chr(255))
Endif

IF Eof()
   DbGoTo(nReg)
   Help(" ",1,"PESQ01")
EndIF

lRefresh := .t.
SetKey(VK_F12,bSav12)
*---------------------------------------------------------------------------
Function AvPesqGet(nAt,oData,oUser,oDoc)
*---------------------------------------------------------------------------
LOCAL cSpcUser:=Space(Len(SY0->Y0_USUARIO)), cSpcDoc:=Space(Len(SY0->Y0_DOC))

If nAt == 1

//   oUser:Paste(cSpcUser)
   oUser:cText(cSpcUser)
   oUser:Refresh()
   oUser:Disable()
//   oDoc:Paste(cSpcDoc)
   oDoc:cText(cSpcDoc)
   oDoc:Refresh()
   oDoc:Disable()

Elseif nAt == 2
  
//   oUser:Paste(cSpcUser)
   oUser:cText(cSpcUser)
   oUser:Refresh()
   oUser:Disable()
   oDoc:Enable()
//   oDoc:Paste(SY0->Y0_DOC)
   oDoc:cText(SY0->Y0_DOC)
   oDoc:Refresh()

Elseif nAt == 3
 
//   oDoc:Paste(cSpcDoc)
   oDoc:cText(cSpcDoc)
   oDoc:Refresh()
   oDoc:Disable()
   oUser:Enable()
//   oUser:Paste(SY0->Y0_USUARIO)
   oUser:cText(SY0->Y0_USUARIO)
   oUser:Refresh()
Endif

oData:Refresh()

Function AvSetPortrait()
LOCAL oPrn

PRINT oPrn NAME ""
oPrn:SetPortrait()
ENDPRINT

RETURN .T.