

   MEMBER('Narudzbenica.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE

                     MAP
                       INCLUDE('NARUDZBENICA004.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisRokovaIsporuke PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(ROK_ISPORUKE)
                       PROJECT(ROK:Datum_roka_isporuke)
                       PROJECT(ROK:Sifra_roka_isporuke)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         STRING('Popis Rokova Isporuke'),AT(-10,-10,3500),USE(?STRING4),FONT(,25,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja:'),AT(31,708),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1312,708),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,875),USE(?Detail)
                         STRING(@s6),AT(1521,31),USE(ROK:Sifra_roka_isporuke)
                         STRING(@D6B),AT(1521,292),USE(ROK:Datum_roka_isporuke)
                         LINE,AT(-468,687,7177,-20),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                         STRING('Šifra Roka Isporuke:'),AT(31,31),USE(?STRING1)
                         STRING('Datum Roka Isporuke:'),AT(31,292,1427,198),USE(?STRING1:2)
                       END
                       FOOTER,AT(1000,9688,6250,771),USE(?Footer)
                         STRING(@N3),AT(3500,469),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice: '),AT(2458,469,875,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
  TRN
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisRokovaIsporuke')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:ROK_ISPORUKE.SetOpenRelated()
  Relate:ROK_ISPORUKE.Open                                 ! File ROK_ISPORUKE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisRokovaIsporuke',ProgressWindow)       ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:ROK_ISPORUKE, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:ROK_ISPORUKE.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ROK_ISPORUKE.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisRokovaIsporuke',ProgressWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisNacinaOtpreme PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(NACIN_OTPREME)
                       PROJECT(NAC:Naziv_nacina_otpreme)
                       PROJECT(NAC:Sifra_nacina_otpreme)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         STRING('Popis Nacina Otpreme'),AT(-10,-10,3469),USE(?STRING4),FONT(,25,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja: '),AT(31,729),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1354,740),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,833),USE(?Detail)
                         STRING(@s6),AT(1562,31),USE(NAC:Sifra_nacina_otpreme,,?NAC:Sifra_nacina_otpreme:2)
                         STRING(@s19),AT(1562,292),USE(NAC:Naziv_nacina_otpreme)
                         STRING('Šifra Nacina Otpreme: '),AT(31,31),USE(?STRING1)
                         STRING('Naziv Nacina Otpreme: '),AT(31,292,1385,198),USE(?STRING1:2)
                         LINE,AT(-926,604,8094,-20),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                       END
                       FOOTER,AT(1000,9688,6250,729),USE(?Footer)
                         STRING(@s6),AT(854,2917),USE(NAC:Sifra_nacina_otpreme)
                         STRING(@N3),AT(3250,417),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice: '),AT(2146,417,1042,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
  TRN
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisNacinaOtpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:NACIN_OTPREME.Open                                ! File NACIN_OTPREME used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisNacinaOtpreme',ProgressWindow)        ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:NACIN_OTPREME, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:NACIN_OTPREME.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:NACIN_OTPREME.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisNacinaOtpreme',ProgressWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisPlacanja PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(PLACANJE)
                       PROJECT(PLA:Nacin_placanja)
                       PROJECT(PLA:Sifra_placanja)
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         STRING('Popis Placanja'),AT(-10,-10,2698),USE(?STRING4),FONT(,30,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja:'),AT(31,708),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1312,708),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,792),USE(?Detail)
                         STRING(@s6),AT(1135,31),USE(PLA:Sifra_placanja,,?PLA:Sifra_placanja:2)
                         STRING(@s19),AT(1135,292),USE(PLA:Nacin_placanja)
                         LINE,AT(-457,625,7177,-20),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                         STRING('Šifra Placanja:'),AT(31,31),USE(?STRING1)
                         STRING('Nacin Placanja:'),AT(31,292,1042,198),USE(?STRING1:2)
                       END
                       FOOTER,AT(1000,9688,6250,781),USE(?Footer)
                         STRING(@s6),AT(490,1729),USE(PLA:Sifra_placanja)
                         STRING(@N3),AT(3385,490),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice:'),AT(2281,490,1042,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
  TRN
                       END
                       FORM,AT(1000,1000,6250,9688),USE(?Form)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('IspisPlacanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:PLACANJE.Open                                     ! File PLACANJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisPlacanja',ProgressWindow)             ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:PLACANJE, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:PLACANJE.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:PLACANJE.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisPlacanja',ProgressWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp{PROP:Text} = FORMAT(TODAY(),@D17)
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
GUMBIspisNarudzbenica PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(NARUDZBENICA)
                       PROJECT(NAR:Broj_narudzbenice)
                       PROJECT(NAR:Datum_narudzbenice)
                       JOIN(POT:PK_Potpisuje,NAR:Broj_narudzbenice)
                         PROJECT(POT:OIB)
                         JOIN(DJE:PK_OIB,POT:OIB)
                           PROJECT(DJE:Ime_djelatnika)
                         END
                       END
                       JOIN(ULO:PK_Uloga,NAR:Broj_narudzbenice)
                         PROJECT(ULO:Dobavljac_narucitelj)
                         PROJECT(ULO:Maticni_broj_firme)
                         JOIN(FIR:PK_MaticniBrojFirme,ULO:Maticni_broj_firme)
                           PROJECT(FIR:Naziv_firme)
                         END
                       END
                       JOIN(STA:PK_Stavke,NAR:Broj_narudzbenice)
                         PROJECT(STA:Iznos)
                         PROJECT(STA:Kolicina)
                         PROJECT(STA:Redni_broj_stavke)
                         PROJECT(STA:Sifra_robe)
                         JOIN(ROB:PK_SifraRobe,STA:Sifra_robe)
                           PROJECT(ROB:Naziv_robe)
                         END
                       END
                     END
ReportPageNumber     LONG,AUTO
ProgressWindow       WINDOW('Progress...'),AT(,,142,59),DOUBLE,CENTER,GRAY,TIMER(1)
                       PROGRESS,AT(15,15,111,12),USE(Progress:Thermometer),RANGE(0,100)
                       STRING(''),AT(0,3,141,10),USE(?Progress:UserString),CENTER
                       STRING(''),AT(0,30,141,10),USE(?Progress:PctText),CENTER
                       BUTTON('Cancel'),AT(45,42,50,15),USE(?Progress:Cancel)
                     END

Report               REPORT,AT(1000,2000,6250,7688),PRE(RPT),PAPER(PAPER:A4),FONT('Arial',10,,FONT:regular,CHARSET:ANSI), |
  THOUS
                       HEADER,AT(1000,1000,6250,1000),USE(?Header)
                         IMAGE('Backgrounds\logo.png'),AT(3833,21,2406,635),USE(?IMAGE1)
                         STRING('Popis Narudžbenica'),AT(-10,21,3781),USE(?STRING4),FONT(,28,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         STRING('Datum izvještaja:'),AT(31,740,1229,219),USE(?ReportDatePrompt:2),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1365,740,1365,219),USE(?ReportDateStamp:2),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
BreakBrojNarudzbenice  BREAK(NAR:Broj_narudzbenice),USE(?BREAK3)
                         HEADER,AT(0,0,6250,2135),USE(?GROUPHEADER1)
                           STRING(@s7),AT(1531,31),USE(ULO:Maticni_broj_firme)
                           STRING(@s15),AT(1531,552),USE(ULO:Dobavljac_narucitelj)
                           STRING('Maticni Broj Firme:'),AT(31,31),USE(?STRING2),FONT(,,,FONT:regular)
                           STRING('Uloga: '),AT(31,552,437,198),USE(?STRING2:2),FONT(,,,FONT:regular)
                           STRING(@s6),AT(5365,31,458,198),USE(NAR:Broj_narudzbenice,,?NAR:Broj_narudzbenice:2),RIGHT(1)
                           STRING('Broj Narudžbenice:'),AT(3937,31,1292,198),USE(?STRING2:3),FONT(,,,FONT:regular)
                           STRING(@D6B),AT(5365,292),USE(NAR:Datum_narudzbenice)
                           STRING('Datum Narudžbenice:'),AT(3937,292,1365,198),USE(?STRING2:4),FONT(,,,FONT:regular)
                           LINE,AT(-489,2031,7156,0),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                           STRING('Redni Broj Stavke'),AT(302,1771,1344,198),USE(?STRING2:6),FONT(,,,FONT:bold)
                           STRING('Sifra Robe'),AT(1812,1771,792,198),USE(?STRING2:7),FONT(,,,FONT:bold)
                           STRING('Kolicina'),AT(4229,1771,792,198),USE(?STRING2:8),FONT(,,,FONT:bold)
                           STRING('Iznos'),AT(5302,1771,792,198),USE(?STRING2:9),FONT(,,,FONT:bold)
                           STRING(@s11),AT(1531,812,979,198),USE(POT:OIB,,?POT:OIB:2)
                           STRING('Naziv Robe'),AT(2948,1771,792,198),USE(?STRING2:5),FONT(,,,FONT:bold)
                           STRING('OIB Davatelja Potpisa:'),AT(31,812,1406,198),USE(?STRING2:10),FONT(,,,FONT:regular)
                           STRING(@s29),AT(2385,-4728),USE(FIR:Naziv_firme)
                           STRING('Ime Davatelja Potpisa:'),AT(31,1073,1406,198),USE(?STRING2:11),FONT(,,,FONT:regular)
                           STRING(@s19),AT(1531,1073),USE(DJE:Ime_djelatnika)
                           STRING('Naziv Firme:'),AT(31,292,740,198),USE(?STRING2:12),FONT(,,,FONT:regular)
                           STRING(@s29),AT(1531,292,2021),USE(FIR:Naziv_firme,,?FIR:Naziv_firme:2)
                         END
Detail                   DETAIL,AT(0,0,6250,260),USE(?Detail)
                           STRING(@s6),AT(1240,-468),USE(NAR:Broj_narudzbenice),RIGHT(1)
                           STRING(@n-7),AT(302,31),USE(STA:Redni_broj_stavke,,?STA:Redni_broj_stavke:2),RIGHT(1)
                           STRING(@s6),AT(1812,31),USE(STA:Sifra_robe)
                           STRING(@n-7),AT(4229,21),USE(STA:Kolicina),RIGHT(1)
                           STRING(@n-7),AT(5208,21),USE(STA:Iznos),RIGHT(1)
                           STRING(@s29),AT(2948,31,948),USE(ROB:Naziv_robe)
                         END
                         FOOTER,AT(0,0,6250,437),USE(?GROUPFOOTER1),PAGEAFTER(1)
                           STRING('UKUPNO:'),AT(4823,156),USE(?STRING3),FONT(,,,FONT:bold)
                           STRING(@n-7),AT(5583,156),USE(STA:Iznos,,?STA:Iznos:2),SUM,RESET(BreakBrojNarudzbenice)
                           LINE,AT(4844,62,1250,0),USE(?LINE1:2),COLOR(00400000h),LINEWIDTH(2)
                         END
                       END
                       FOOTER,AT(1000,9688,6250,635),USE(?Footer)
                         STRING('Broj Stranice:'),AT(2490,396,833,198),USE(?STRING1),FONT(,,,FONT:regular+FONT:underline)
                         STRING(@N3),AT(3385,396),USE(ReportPageNumber)
                       END
                       FORM,AT(1000,1000,6250,2625),USE(?FORM1)
                       END
                     END
ThisWindow           CLASS(ReportManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
OpenReport             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ThisReport           CLASS(ProcessClass)                   ! Process Manager
TakeRecord             PROCEDURE(),BYTE,PROC,DERIVED
                     END

ProgressMgr          StepStringClass                       ! Progress Manager
Previewer            PrintPreviewClass                     ! Print Previewer

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('GUMBIspisNarudzbenica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:NARUDZBENICA.SetOpenRelated()
  Relate:NARUDZBENICA.Open                                 ! File NARUDZBENICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('GUMBIspisNarudzbenica',ProgressWindow)     ! Restore window settings from non-volatile store
  ProgressMgr.Init(ScrollSort:AllowAlpha+ScrollSort:AllowNumeric,ScrollBy:RunTime)
  ThisReport.Init(Process:View, Relate:NARUDZBENICA, ?Progress:PctText, Progress:Thermometer, ProgressMgr, NAR:Broj_narudzbenice)
  ThisReport.CaseSensitiveValue = FALSE
  ThisReport.AddSortOrder(NAR:PK_BrojNarudzbenice)
  ThisReport.AddRange(NAR:Broj_narudzbenice)
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:NARUDZBENICA.SetQuickScan(1,Propagate:OneMany)
  ProgressWindow{PROP:Timer} = 10                          ! Assign timer interval
  SELF.SkipPreview = False
  Previewer.SetINIManager(INIMgr)
  Previewer.AllowUserZoom = True
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:NARUDZBENICA.Close
  END
  IF SELF.Opened
    INIMgr.Update('GUMBIspisNarudzbenica',ProgressWindow)  ! Save window data to non-volatile store
  END
  ProgressMgr.Kill()
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    Report$?ReportPageNumber{PROP:PageNo} = True
  END
  RETURN ReturnValue


ThisReport.TakeRecord PROCEDURE

ReturnValue          BYTE,AUTO

SkipDetails BYTE
  CODE
  ReturnValue = PARENT.TakeRecord()
  PRINT(RPT:Detail)
  RETURN ReturnValue

