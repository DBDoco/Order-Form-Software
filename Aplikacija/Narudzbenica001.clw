

   MEMBER('Narudzbenica.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('NARUDZBENICA001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('NARUDZBENICA002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('NARUDZBENICA003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('NARUDZBENICA004.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Frame
!!! </summary>
Main PROCEDURE 

SplashProcedureThread LONG
DisplayDayString STRING('Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ')
DisplayDayText   STRING(9),DIM(7),OVER(DisplayDayString)
AppFrame             APPLICATION('Narudžbenica'),AT(,,356,190),FONT('Arial',,,FONT:regular,CHARSET:DEFAULT),RESIZE, |
  ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),MAX,STATUS(-1, |
  80,120,45),SYSTEM,WALLPAPER('Backgrounds\angryimg.png'),IMM
                       MENUBAR,USE(?MENUBAR1)
                         MENU('&Datoteka'),USE(?FileMenu),ICON('Icons\datoteka.png')
                           ITEM('P&ostavke Printanja...'),USE(?PrintSetup),ICON(ICON:Print),MSG('Setup Printer'),STD(STD:PrintSetup)
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           ITEM('I&zlaz'),USE(?Exit),ICON(ICON:Cross),MSG('Exit this application'),STD(STD:Close)
                         END
                         MENU('&Uredi'),USE(?EditMenu),ICON('Icons\uredi.png')
                           ITEM('Iz&reži'),USE(?Cut),ICON(ICON:Cut),MSG('Remove item to Windows Clipboard'),STD(STD:Cut)
                           ITEM('&Kopiraj'),USE(?Copy),MSG('Copy item to Windows Clipboard'),STD(STD:Copy)
                           ITEM('&Zalijepi'),USE(?Paste),ICON(ICON:Paste),MSG('Paste contents of Windows Clipboard'), |
  STD(STD:Paste)
                         END
                         MENU('&Prozor'),USE(?MENU1),ICON('Icons\prozor.png'),MSG('Create and Arrange windows'),STD(STD:WindowList)
                           ITEM('P&loca'),USE(?Tile),MSG('Make all open windows visible'),STD(STD:TileWindow)
                           ITEM('&Kaskada'),USE(?Cascade),MSG('Stack all open windows'),STD(STD:CascadeWindow)
                           ITEM('&Poslozi Ikone'),USE(?Arrange),MSG('Align all window icons'),STD(STD:ArrangeIcons)
                         END
                         MENU('Pregled'),USE(?MENU3),ICON('Icons\pregled.png')
                           ITEM('Narudžbenica'),USE(?ITEM1)
                           ITEM('Firmi'),USE(?ITEM2)
                           ITEM('Mjesta'),USE(?ITEM3)
                           ITEM('Robe'),USE(?ITEM4)
                           ITEM('Djelatnika'),USE(?ITEM5)
                           ITEM('Jedinica Mjere'),USE(?ITEM6)
                           ITEM('Rokova Isporuke'),USE(?ITEM7)
                           ITEM('Nacina Otpreme'),USE(?ITEM8)
                           ITEM('Placanja'),USE(?ITEM9)
                         END
                         MENU('Ispis'),USE(?MENU4),ICON('Icons\print.png')
                           ITEM('Narudžbenica'),USE(?ITEM10)
                           ITEM('Firma'),USE(?ITEM11)
                           ITEM('Mjesta'),USE(?ITEM12)
                           ITEM('Robe'),USE(?ITEM13)
                           ITEM('Djelatnika'),USE(?ITEM14)
                           ITEM('Jedinica Mjere'),USE(?ITEM15)
                           ITEM('Rokova Isporuke'),USE(?ITEM16)
                           ITEM('Nacina Otpreme'),USE(?ITEM17)
                           ITEM('Placanja'),USE(?ITEM18)
                         END
                         MENU('&Pomoc'),USE(?MENU2),ICON('Icons\pomoc.png'),MSG('Windows Help')
                           ITEM('&Sadržaj'),USE(?Helpindex),MSG('View the contents of the help file'),STD(STD:HelpIndex)
                           ITEM('&Traži Pomoc Na...'),USE(?HelpSearch),MSG('Search for help on a subject'),STD(STD:HelpSearch)
                           ITEM('&Kako Koristiti Pomoc'),USE(?HelpOnHelp),ICON(ICON:Help),MSG('How to use Windows Help'), |
  STD(STD:HelpOnHelp)
                         END
                       END
                       TOOLBAR,AT(0,0,356,80),USE(?TOOLBAR1),COLOR(COLOR:White)
                         BUTTON('Narudžbenica'),AT(2,4,59,46),USE(?BUTTON1),FONT(,,,FONT:bold)
                         BUTTON('Firma'),AT(65,4,69,22),USE(?BUTTON2),FONT(,,,FONT:bold)
                         BUTTON('Mjesto'),AT(65,28,69,22),USE(?BUTTON3),FONT(,,,FONT:bold)
                         BUTTON('Roba'),AT(137,4,69,22),USE(?BUTTON4),FONT(,,,FONT:bold)
                         BUTTON('Djelatnik'),AT(137,28,69,22),USE(?BUTTON5),FONT(,,,FONT:bold)
                         BUTTON('Jedinica<0DH,0AH>Mjere'),AT(209,4,69,22),USE(?BUTTON6),FONT(,,,FONT:bold)
                         BUTTON('Rok<0DH,0AH>Isporuke'),AT(209,28,69,22),USE(?BUTTON7),FONT(,,,FONT:bold)
                         BUTTON('Nacin<0DH,0AH>Otpreme'),AT(281,4,69,22),USE(?BUTTON8),FONT(,,,FONT:bold)
                         BUTTON('Placanje'),AT(281,28,69,22),USE(?BUTTON9),FONT(,,,FONT:bold)
                         BUTTON('Kalendar'),AT(137,53,69,22),USE(?Calendar),FONT(,,,FONT:bold)
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Calendar2            CalendarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
Menu::MENUBAR1 ROUTINE                                     ! Code for menu items on ?MENUBAR1
Menu::FileMenu ROUTINE                                     ! Code for menu items on ?FileMenu
Menu::EditMenu ROUTINE                                     ! Code for menu items on ?EditMenu
Menu::MENU1 ROUTINE                                        ! Code for menu items on ?MENU1
Menu::MENU3 ROUTINE                                        ! Code for menu items on ?MENU3
  CASE ACCEPTED()
  OF ?ITEM1
    START(PregledNarudzbenica, 25000)
  OF ?ITEM2
    START(PregledFirmi, 25000)
  OF ?ITEM3
    START(PregledMjesta, 25000)
  OF ?ITEM4
    START(PregledRobe, 25000)
  OF ?ITEM5
    START(PregledDjelatnika, 25000)
  OF ?ITEM6
    START(PregledJedinicaMjere, 25000)
  OF ?ITEM7
    START(PregledRokovaIsporuke, 25000)
  OF ?ITEM8
    START(PregledNacinaOtpreme, 25000)
  OF ?ITEM9
    START(PregledPlacanja, 25000)
  END
Menu::MENU4 ROUTINE                                        ! Code for menu items on ?MENU4
  CASE ACCEPTED()
  OF ?ITEM10
    START(IspisNarudzbenica, 25000)
  OF ?ITEM11
    START(IspisFirmi, 25000)
  OF ?ITEM12
    START(IspisMjesta, 25000)
  OF ?ITEM13
    START(IspisRobe, 25000)
  OF ?ITEM14
    START(IspisDjelatnika, 25000)
  OF ?ITEM15
    START(IspisJedinicaMjere, 25000)
  OF ?ITEM16
    START(IspisRokovaIsporuke, 25000)
  OF ?ITEM17
    START(IspisNacinaOtpreme, 25000)
  OF ?ITEM18
    START(IspisPlacanja, 25000)
  END
Menu::MENU2 ROUTINE                                        ! Code for menu items on ?MENU2

ThisWindow.Ask PROCEDURE

  CODE
  IF NOT INRANGE(AppFrame{PROP:Timer},1,100)
    AppFrame{PROP:Timer} = 100
  END
    AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D2)
    AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = 1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(AppFrame)                                      ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('Main',AppFrame)                            ! Restore window settings from non-volatile store
  SELF.SetAlerts()
      AppFrame{PROP:TabBarVisible}  = False
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',AppFrame)                         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    ELSE
      DO Menu::MENUBAR1                                    ! Process menu items on ?MENUBAR1 menu
      DO Menu::FileMenu                                    ! Process menu items on ?FileMenu menu
      DO Menu::EditMenu                                    ! Process menu items on ?EditMenu menu
      DO Menu::MENU1                                       ! Process menu items on ?MENU1 menu
      DO Menu::MENU3                                       ! Process menu items on ?MENU3 menu
      DO Menu::MENU4                                       ! Process menu items on ?MENU4 menu
      DO Menu::MENU2                                       ! Process menu items on ?MENU2 menu
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON1
      START(PregledNarudzbenica, 25000)
    OF ?BUTTON2
      START(PregledFirmi, 25000)
    OF ?BUTTON3
      START(PregledMjesta, 25000)
    OF ?BUTTON4
      START(PregledRobe, 25000)
    OF ?BUTTON5
      START(PregledDjelatnika, 25000)
    OF ?BUTTON6
      START(PregledJedinicaMjere, 25000)
    OF ?BUTTON7
      START(PregledRokovaIsporuke, 25000)
    OF ?BUTTON8
      START(PregledNacinaOtpreme, 25000)
    OF ?BUTTON9
      START(PregledPlacanja, 25000)
    OF ?Calendar
      Calendar2.Ask('Izaberite Datum')
      IF Calendar2.Response = RequestCompleted THEN
      END
      ThisWindow.Reset(True)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:OpenWindow
      SplashProcedureThread = START(SplashScreen)          ! Run the splash window procedure
    OF EVENT:Timer
      AppFrame{Prop:StatusText,3} = CLIP(DisplayDayText[(TODAY()%7)+1]) & ', ' & FORMAT(TODAY(),@D2)
      AppFrame{PROP:StatusText,4} = FORMAT(CLOCK(),@T1)
    ELSE
      IF SplashProcedureThread
        IF EVENT() = Event:Accepted
          POST(Event:CloseWindow,,SplashProcedureThread)   ! Close the splash window
          SplashPRocedureThread = 0
        END
     END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Splash
!!! </summary>
SplashScreen PROCEDURE 

window               WINDOW,AT(,,204,112),FONT('Microsoft Sans Serif',8,,FONT:regular),NOFRAME,CENTER,GRAY,MDI
                       PANEL,AT(0,-42,204,154),USE(?PANEL1),BEVEL(6),FILL(COLOR:White)
                       PANEL,AT(7,6,191,98),USE(?PANEL2),BEVEL(-2,1),FILL(COLOR:White)
                       STRING('Narudžbenica'),AT(13,12,182,10),USE(?String2),FONT('Arial',10,,,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White)
                       IMAGE('sv_small.jpg'),AT(68,61),USE(?Image1)
                       PANEL,AT(12,33,182,12),USE(?PANEL3),BEVEL(-1,1,9),FILL(COLOR:White)
                       STRING('By: Dominik Bedenic'),AT(13,48,182,10),USE(?String1),FONT('Arial',10,,,CHARSET:DEFAULT), |
  CENTER,COLOR(COLOR:White)
                       IMAGE('Backgrounds\logo.png'),AT(35,62,135,35),USE(?IMAGE2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

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
  GlobalErrors.SetProcedureName('SplashScreen')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?PANEL1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(window)                                        ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('SplashScreen',window)                      ! Restore window settings from non-volatile store
  TARGET{Prop:Timer} = 300                                 ! Close window on timer event, so configure timer
  TARGET{Prop:Alrt,255} = MouseLeft                        ! Alert mouse clicks that will close window
  TARGET{Prop:Alrt,254} = MouseLeft2
  TARGET{Prop:Alrt,253} = MouseRight
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('SplashScreen',window)                   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)                            ! Splash window will close on mouse click
      END
    OF EVENT:LoseFocus
        POST(Event:CloseWindow)                            ! Splash window will close when focus is lost
    OF Event:Timer
      POST(Event:CloseWindow)                              ! Splash window will close on event timer
    OF Event:AlertKey
      CASE KEYCODE()                                       ! Splash window will close on mouse click
      OF MouseLeft
      OROF MouseLeft2
      OROF MouseRight
        POST(Event:CloseWindow)
      END
    ELSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledNarudzbenica PROCEDURE 

BRW1::View:Browse    VIEW(NARUDZBENICA)
                       PROJECT(NAR:Broj_narudzbenice)
                       PROJECT(NAR:Datum_narudzbenice)
                       PROJECT(NAR:Sifra_roka_isporuke)
                       PROJECT(NAR:Sifra_nacina_otpreme)
                       PROJECT(NAR:Sifra_placanja)
                       JOIN(ROK:PK_SifraRokaIsporuke,NAR:Sifra_roka_isporuke)
                         PROJECT(ROK:Datum_roka_isporuke)
                         PROJECT(ROK:Sifra_roka_isporuke)
                       END
                       JOIN(NAC:PK_SifraNacinaOtpreme,NAR:Sifra_nacina_otpreme)
                         PROJECT(NAC:Naziv_nacina_otpreme)
                         PROJECT(NAC:Sifra_nacina_otpreme)
                       END
                       JOIN(PLA:PK_SifraPlacanja,NAR:Sifra_placanja)
                         PROJECT(PLA:Nacin_placanja)
                         PROJECT(PLA:Sifra_placanja)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
NAR:Broj_narudzbenice  LIKE(NAR:Broj_narudzbenice)    !List box control field - type derived from field
NAR:Datum_narudzbenice LIKE(NAR:Datum_narudzbenice)   !List box control field - type derived from field
NAR:Sifra_roka_isporuke LIKE(NAR:Sifra_roka_isporuke) !List box control field - type derived from field
ROK:Datum_roka_isporuke LIKE(ROK:Datum_roka_isporuke) !List box control field - type derived from field
NAR:Sifra_nacina_otpreme LIKE(NAR:Sifra_nacina_otpreme) !List box control field - type derived from field
NAC:Naziv_nacina_otpreme LIKE(NAC:Naziv_nacina_otpreme) !List box control field - type derived from field
NAR:Sifra_placanja     LIKE(NAR:Sifra_placanja)       !List box control field - type derived from field
PLA:Nacin_placanja     LIKE(PLA:Nacin_placanja)       !List box control field - type derived from field
ROK:Sifra_roka_isporuke LIKE(ROK:Sifra_roka_isporuke) !Related join file key field - type derived from field
NAC:Sifra_nacina_otpreme LIKE(NAC:Sifra_nacina_otpreme) !Related join file key field - type derived from field
PLA:Sifra_placanja     LIKE(PLA:Sifra_placanja)       !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW5::View:Browse    VIEW(POTPISUJE)
                       PROJECT(POT:Redni_broj_potpisa)
                       PROJECT(POT:OIB)
                       PROJECT(POT:Broj_narudzbenice)
                       JOIN(DJE:PK_OIB,POT:OIB)
                         PROJECT(DJE:Ime_djelatnika)
                         PROJECT(DJE:OIB)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
POT:Redni_broj_potpisa LIKE(POT:Redni_broj_potpisa)   !List box control field - type derived from field
POT:OIB                LIKE(POT:OIB)                  !List box control field - type derived from field
DJE:Ime_djelatnika     LIKE(DJE:Ime_djelatnika)       !List box control field - type derived from field
POT:Broj_narudzbenice  LIKE(POT:Broj_narudzbenice)    !Primary key field - type derived from field
DJE:OIB                LIKE(DJE:OIB)                  !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Narudžbenica'),AT(0,0,622,272),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(5,5,608,100),USE(?List),HVSCROLL,FORMAT('84L(2)|M~Broj Narudžbenice~C(0)@s6@76L' & |
  '(2)|M~Datum Narudžbenice~C(0)@D6B@[94L(2)|M~Sifra Roka Isporuke~C(0)@s6@40L(2)|M~Dat' & |
  'um roka isporuke~C(0)@D6B@](166)|~Podaci o Roku Isporuke~[85L(2)|M~Sifra Nacina Otpr' & |
  'eme~C(0)@s6@76L(2)|M~Naziv Nacina Otpreme~C(0)@s19@]|~Podaci o Nacinu Otpreme~[60L(2' & |
  ')|M~Sifra Placanja~C(0)@s6@76L(2)|M~Nacin placanja~C(0)@s19@]|~Podaci o Placanju~'),FROM(Queue:Browse), |
  IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(289,246,40,12),USE(?Close)
                       LIST,AT(6,157,280,100),USE(?List:2),RIGHT(1),FORMAT('74L(2)|M~Redni Broj Potpisa~C(1)@n' & |
  '-7@[50L(2)|M~OIB~C(0)@s11@76L(2)|M~Ime Djelatnika~C(0)@s19@]|~Podaci o Djelatniku~'),FROM(Queue:Browse:1), |
  IMM
                       BUTTON('&Unos'),AT(289,156,42,12),USE(?Insert:2)
                       BUTTON('&Izmjena'),AT(289,172,42,12),USE(?Change:2)
                       BUTTON('&Brisanje'),AT(289,187,42,12),USE(?Delete:2)
                       BUTTON('&Ispis Narudžbenice'),AT(524,110,90,28),USE(?Print),ICON(ICON:Print)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW5                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PregledNarudzbenica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:NARUDZBENICA.SetOpenRelated()
  Relate:NARUDZBENICA.Open                                 ! File NARUDZBENICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:NARUDZBENICA,SELF) ! Initialize the browse manager
  BRW5.Init(?List:2,Queue:Browse:1.ViewPosition,BRW5::View:Browse,Queue:Browse:1,Relate:POTPISUJE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(NAR:Broj_narudzbenice,BRW1.Q.NAR:Broj_narudzbenice) ! Field NAR:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Datum_narudzbenice,BRW1.Q.NAR:Datum_narudzbenice) ! Field NAR:Datum_narudzbenice is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Sifra_roka_isporuke,BRW1.Q.NAR:Sifra_roka_isporuke) ! Field NAR:Sifra_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(ROK:Datum_roka_isporuke,BRW1.Q.ROK:Datum_roka_isporuke) ! Field ROK:Datum_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Sifra_nacina_otpreme,BRW1.Q.NAR:Sifra_nacina_otpreme) ! Field NAR:Sifra_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(NAC:Naziv_nacina_otpreme,BRW1.Q.NAC:Naziv_nacina_otpreme) ! Field NAC:Naziv_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(NAR:Sifra_placanja,BRW1.Q.NAR:Sifra_placanja) ! Field NAR:Sifra_placanja is a hot field or requires assignment from browse
  BRW1.AddField(PLA:Nacin_placanja,BRW1.Q.PLA:Nacin_placanja) ! Field PLA:Nacin_placanja is a hot field or requires assignment from browse
  BRW1.AddField(ROK:Sifra_roka_isporuke,BRW1.Q.ROK:Sifra_roka_isporuke) ! Field ROK:Sifra_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(NAC:Sifra_nacina_otpreme,BRW1.Q.NAC:Sifra_nacina_otpreme) ! Field NAC:Sifra_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(PLA:Sifra_placanja,BRW1.Q.PLA:Sifra_placanja) ! Field PLA:Sifra_placanja is a hot field or requires assignment from browse
  BRW5.Q &= Queue:Browse:1
  BRW5.AddSortOrder(,POT:PK_Potpisuje)                     ! Add the sort order for POT:PK_Potpisuje for sort order 1
  BRW5.AddLocator(BRW5::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,POT:Redni_broj_potpisa,1,BRW5) ! Initialize the browse locator using  using key: POT:PK_Potpisuje , POT:Redni_broj_potpisa
  BRW5.AddField(POT:Redni_broj_potpisa,BRW5.Q.POT:Redni_broj_potpisa) ! Field POT:Redni_broj_potpisa is a hot field or requires assignment from browse
  BRW5.AddField(POT:OIB,BRW5.Q.POT:OIB)                    ! Field POT:OIB is a hot field or requires assignment from browse
  BRW5.AddField(DJE:Ime_djelatnika,BRW5.Q.DJE:Ime_djelatnika) ! Field DJE:Ime_djelatnika is a hot field or requires assignment from browse
  BRW5.AddField(POT:Broj_narudzbenice,BRW5.Q.POT:Broj_narudzbenice) ! Field POT:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW5.AddField(DJE:OIB,BRW5.Q.DJE:OIB)                    ! Field DJE:OIB is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledNarudzbenica',BrowseWindow)         ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeNarudzbenica
  BRW5.AskProcedure = 2                                    ! Will call: AzuriranjePotpisa
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.PrintProcedure = 3
  BRW1.PrintControl = ?Print
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
    INIMgr.Update('PregledNarudzbenica',BrowseWindow)      ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeNarudzbenica
      AzuriranjePotpisa
      GUMBIspisNarudzbenica
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW5.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledFirmi PROCEDURE 

BRW1::View:Browse    VIEW(FIRMA)
                       PROJECT(FIR:Maticni_broj_firme)
                       PROJECT(FIR:Naziv_firme)
                       PROJECT(FIR:Adresa_firme)
                       PROJECT(FIR:Postanski_broj)
                       JOIN(MJE:PK_PostanskiBroj,FIR:Postanski_broj)
                         PROJECT(MJE:Naziv_mjesta)
                         PROJECT(MJE:Postanski_broj)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
FIR:Maticni_broj_firme LIKE(FIR:Maticni_broj_firme)   !List box control field - type derived from field
FIR:Naziv_firme        LIKE(FIR:Naziv_firme)          !List box control field - type derived from field
FIR:Adresa_firme       LIKE(FIR:Adresa_firme)         !List box control field - type derived from field
FIR:Postanski_broj     LIKE(FIR:Postanski_broj)       !List box control field - type derived from field
MJE:Naziv_mjesta       LIKE(MJE:Naziv_mjesta)         !List box control field - type derived from field
MJE:Postanski_broj     LIKE(MJE:Postanski_broj)       !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(ULOGA)
                       PROJECT(ULO:Dobavljac_narucitelj)
                       PROJECT(ULO:Broj_narudzbenice)
                       PROJECT(ULO:Maticni_broj_firme)
                       JOIN(NAR:PK_BrojNarudzbenice,ULO:Broj_narudzbenice)
                         PROJECT(NAR:Broj_narudzbenice)
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
NAR:Broj_narudzbenice  LIKE(NAR:Broj_narudzbenice)    !List box control field - type derived from field
ULO:Dobavljac_narucitelj LIKE(ULO:Dobavljac_narucitelj) !List box control field - type derived from field
ULO:Broj_narudzbenice  LIKE(ULO:Broj_narudzbenice)    !Primary key field - type derived from field
ULO:Maticni_broj_firme LIKE(ULO:Maticni_broj_firme)   !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Firmi'),AT(0,0,492,258),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(5,5,480,100),USE(?List),HVSCROLL,FORMAT('72L(2)|M~Maticni Broj Firme~C(0)@s7@11' & |
  '6L(2)|M~Naziv Firme~C(0)@s29@116L(2)|M~Adresa Firme~C(0)@s29@[72L(2)|M~Postanski Bro' & |
  'j~C(0)@s5@116L(2)|M~Naziv Mjesta~C(0)@s29@]|~Podaci o Mjestu~'),FROM(Queue:Browse),IMM, |
  MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       LIST,AT(6,144,206,100),USE(?List:2),FORMAT('110L(2)|M~Broj Narudžbenice~C(0)@s6@60L(2)|' & |
  'M~Dobavljac/Narucitelj~C(0)@s15@'),FROM(Queue:Browse:1),IMM
                       BUTTON('&Unos'),AT(220,144,42,12),USE(?Insert:2)
                       BUTTON('&Izmjena'),AT(220,158,42,12),USE(?Change:2)
                       BUTTON('&Brisanje'),AT(220,174,42,12),USE(?Delete:2)
                       BUTTON('Zatvori'),AT(220,230,42),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW8                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator

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
  GlobalErrors.SetProcedureName('PregledFirmi')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:FIRMA.SetOpenRelated()
  Relate:FIRMA.Open                                        ! File FIRMA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:FIRMA,SELF) ! Initialize the browse manager
  BRW8.Init(?List:2,Queue:Browse:1.ViewPosition,BRW8::View:Browse,Queue:Browse:1,Relate:ULOGA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(FIR:Maticni_broj_firme,BRW1.Q.FIR:Maticni_broj_firme) ! Field FIR:Maticni_broj_firme is a hot field or requires assignment from browse
  BRW1.AddField(FIR:Naziv_firme,BRW1.Q.FIR:Naziv_firme)    ! Field FIR:Naziv_firme is a hot field or requires assignment from browse
  BRW1.AddField(FIR:Adresa_firme,BRW1.Q.FIR:Adresa_firme)  ! Field FIR:Adresa_firme is a hot field or requires assignment from browse
  BRW1.AddField(FIR:Postanski_broj,BRW1.Q.FIR:Postanski_broj) ! Field FIR:Postanski_broj is a hot field or requires assignment from browse
  BRW1.AddField(MJE:Naziv_mjesta,BRW1.Q.MJE:Naziv_mjesta)  ! Field MJE:Naziv_mjesta is a hot field or requires assignment from browse
  BRW1.AddField(MJE:Postanski_broj,BRW1.Q.MJE:Postanski_broj) ! Field MJE:Postanski_broj is a hot field or requires assignment from browse
  BRW8.Q &= Queue:Browse:1
  BRW8.AddSortOrder(,ULO:PK_Uloga)                         ! Add the sort order for ULO:PK_Uloga for sort order 1
  BRW8.AddRange(ULO:Broj_narudzbenice,Relate:ULOGA,Relate:FIRMA) ! Add file relationship range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,ULO:Maticni_broj_firme,1,BRW8) ! Initialize the browse locator using  using key: ULO:PK_Uloga , ULO:Maticni_broj_firme
  BRW8.AddField(NAR:Broj_narudzbenice,BRW8.Q.NAR:Broj_narudzbenice) ! Field NAR:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW8.AddField(ULO:Dobavljac_narucitelj,BRW8.Q.ULO:Dobavljac_narucitelj) ! Field ULO:Dobavljac_narucitelj is a hot field or requires assignment from browse
  BRW8.AddField(ULO:Broj_narudzbenice,BRW8.Q.ULO:Broj_narudzbenice) ! Field ULO:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW8.AddField(ULO:Maticni_broj_firme,BRW8.Q.ULO:Maticni_broj_firme) ! Field ULO:Maticni_broj_firme is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledFirmi',BrowseWindow)                ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeFirmi
  BRW8.AskProcedure = 2                                    ! Will call: AzuriranjeUloge
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:FIRMA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PregledFirmi',BrowseWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      AzuriranjeFirmi
      AzuriranjeUloge
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledMjesta PROCEDURE 

BRW1::View:Browse    VIEW(MJESTO)
                       PROJECT(MJE:Postanski_broj)
                       PROJECT(MJE:Naziv_mjesta)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
MJE:Postanski_broj     LIKE(MJE:Postanski_broj)       !List box control field - type derived from field
MJE:Naziv_mjesta       LIKE(MJE:Naziv_mjesta)         !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Mjesta'),AT(0,0,247,140),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('80L(2)|M~Postanski Broj~C(0)@s5@116L(2' & |
  ')|M~Naziv Mjesta~C(0)@s29@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::MJE:Postanski_broj EditEntryClass             ! Edit-in-place class for field MJE:Postanski_broj
EditInPlace::MJE:Naziv_mjesta EditEntryClass               ! Edit-in-place class for field MJE:Naziv_mjesta

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
  GlobalErrors.SetProcedureName('PregledMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:MJESTO,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(MJE:Postanski_broj,BRW1.Q.MJE:Postanski_broj) ! Field MJE:Postanski_broj is a hot field or requires assignment from browse
  BRW1.AddField(MJE:Naziv_mjesta,BRW1.Q.MJE:Naziv_mjesta)  ! Field MJE:Naziv_mjesta is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledMjesta',BrowseWindow)               ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MJESTO.Close
  END
  IF SELF.Opened
    INIMgr.Update('PregledMjesta',BrowseWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeMjesta
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::MJE:Postanski_broj,1)
  SELF.AddEditControl(EditInPlace::MJE:Naziv_mjesta,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledRobe PROCEDURE 

BRW1::View:Browse    VIEW(ROBA)
                       PROJECT(ROB:Sifra_robe)
                       PROJECT(ROB:Naziv_robe)
                       PROJECT(ROB:Cijena)
                       PROJECT(ROB:Sifra_jedinice_mjere)
                       JOIN(JED:PK_SifraJediniceMjere,ROB:Sifra_jedinice_mjere)
                         PROJECT(JED:Naziv_jedinice_mjere)
                         PROJECT(JED:Sifra_jedinice_mjere)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ROB:Sifra_robe         LIKE(ROB:Sifra_robe)           !List box control field - type derived from field
ROB:Naziv_robe         LIKE(ROB:Naziv_robe)           !List box control field - type derived from field
ROB:Cijena             LIKE(ROB:Cijena)               !List box control field - type derived from field
ROB:Sifra_jedinice_mjere LIKE(ROB:Sifra_jedinice_mjere) !List box control field - type derived from field
JED:Naziv_jedinice_mjere LIKE(JED:Naziv_jedinice_mjere) !List box control field - type derived from field
JED:Sifra_jedinice_mjere LIKE(JED:Sifra_jedinice_mjere) !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Robe'),AT(0,0,497,277),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(10,8,473,100),USE(?List),HVSCROLL,FORMAT('59L(2)|M~Sifra Robe~C(0)@s6@116L(2)|M' & |
  '~Naziv Robe~C(0)@s29@55L(2)|M~Cijena~D(12)@n-10.2@[101L(2)|M~Sifra Jedinice Mjere~C(' & |
  '0)@s6@76L(2)|M~Naziv Jedinice Mjere~C(0)@s19@]|~Podaci o Jedinici Mjere~'),FROM(Queue:Browse), |
  IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(10,114,40,12),USE(?Insert),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT)
                       BUTTON('&Izmjena'),AT(55,114,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(100,114,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(150,114,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(443,114,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END


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
  GlobalErrors.SetProcedureName('PregledRobe')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:ROBA.SetOpenRelated()
  Relate:ROBA.Open                                         ! File ROBA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ROBA,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(ROB:Sifra_robe,BRW1.Q.ROB:Sifra_robe)      ! Field ROB:Sifra_robe is a hot field or requires assignment from browse
  BRW1.AddField(ROB:Naziv_robe,BRW1.Q.ROB:Naziv_robe)      ! Field ROB:Naziv_robe is a hot field or requires assignment from browse
  BRW1.AddField(ROB:Cijena,BRW1.Q.ROB:Cijena)              ! Field ROB:Cijena is a hot field or requires assignment from browse
  BRW1.AddField(ROB:Sifra_jedinice_mjere,BRW1.Q.ROB:Sifra_jedinice_mjere) ! Field ROB:Sifra_jedinice_mjere is a hot field or requires assignment from browse
  BRW1.AddField(JED:Naziv_jedinice_mjere,BRW1.Q.JED:Naziv_jedinice_mjere) ! Field JED:Naziv_jedinice_mjere is a hot field or requires assignment from browse
  BRW1.AddField(JED:Sifra_jedinice_mjere,BRW1.Q.JED:Sifra_jedinice_mjere) ! Field JED:Sifra_jedinice_mjere is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledRobe',BrowseWindow)                 ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeRobe
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:ROBA.Close
  END
  IF SELF.Opened
    INIMgr.Update('PregledRobe',BrowseWindow)              ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeRobe
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledDjelatnika PROCEDURE 

BRW1::View:Browse    VIEW(DJELATNIK)
                       PROJECT(DJE:OIB)
                       PROJECT(DJE:Ime_djelatnika)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
DJE:OIB                LIKE(DJE:OIB)                  !List box control field - type derived from field
DJE:Ime_djelatnika     LIKE(DJE:Ime_djelatnika)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Djelatnika'),AT(0,0,280,151),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(12,19,235,100),USE(?List),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),HVSCROLL,FORMAT('75L(2)|M~O' & |
  'IB~C(0)@s11@76L(2)|M~Ime Djelatnika~C(0)@s19@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(12,123,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(58,123,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(102,123,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(152,123,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(208,123,40,12),USE(?Close)
                       SHEET,AT(12,7,236,128),USE(?SHEET1)
                         TAB('Po OIB-u'),USE(?TAB1)
                         END
                         TAB('Po Imenu'),USE(?TAB2)
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort1:Locator  StepLocatorClass                      ! Conditional Locator - CHOICE(?SHEET1)=2
BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::DJE:OIB EditEntryClass                        ! Edit-in-place class for field DJE:OIB
EditInPlace::DJE:Ime_djelatnika EditEntryClass             ! Edit-in-place class for field DJE:Ime_djelatnika

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
  GlobalErrors.SetProcedureName('PregledDjelatnika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:DJELATNIK.SetOpenRelated()
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:DJELATNIK,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,DJE:SK_Ime)                           ! Add the sort order for DJE:SK_Ime for sort order 1
  BRW1.AddLocator(BRW1::Sort1:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort1:Locator.Init(,DJE:Ime_djelatnika,1,BRW1)     ! Initialize the browse locator using  using key: DJE:SK_Ime , DJE:Ime_djelatnika
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 2
  BRW1.AddField(DJE:OIB,BRW1.Q.DJE:OIB)                    ! Field DJE:OIB is a hot field or requires assignment from browse
  BRW1.AddField(DJE:Ime_djelatnika,BRW1.Q.DJE:Ime_djelatnika) ! Field DJE:Ime_djelatnika is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledDjelatnika',BrowseWindow)           ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:DJELATNIK.Close
  END
  IF SELF.Opened
    INIMgr.Update('PregledDjelatnika',BrowseWindow)        ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeDjelatnika
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::DJE:OIB,1)
  SELF.AddEditControl(EditInPlace::DJE:Ime_djelatnika,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?SHEET1)=2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledJedinicaMjere PROCEDURE 

BRW1::View:Browse    VIEW(JEDINICA_MJERE)
                       PROJECT(JED:Sifra_jedinice_mjere)
                       PROJECT(JED:Naziv_jedinice_mjere)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
JED:Sifra_jedinice_mjere LIKE(JED:Sifra_jedinice_mjere) !List box control field - type derived from field
JED:Naziv_jedinice_mjere LIKE(JED:Naziv_jedinice_mjere) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Jedinica Mjere'),AT(0,0,247,140),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI, |
  SYSTEM,WALLPAPER('Backgrounds\angryimg.png'),IMM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('91L(2)|M~Sifra Jedinice Mjere~C(0)@s6@' & |
  '76L(2)|M~Naziv Jedinice Mjere~C(0)@s19@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END


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
  GlobalErrors.SetProcedureName('PregledJedinicaMjere')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:JEDINICA_MJERE.SetOpenRelated()
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:JEDINICA_MJERE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(JED:Sifra_jedinice_mjere,BRW1.Q.JED:Sifra_jedinice_mjere) ! Field JED:Sifra_jedinice_mjere is a hot field or requires assignment from browse
  BRW1.AddField(JED:Naziv_jedinice_mjere,BRW1.Q.JED:Naziv_jedinice_mjere) ! Field JED:Naziv_jedinice_mjere is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledJedinicaMjere',BrowseWindow)        ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeJedinicaMjere
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:JEDINICA_MJERE.Close
  END
  IF SELF.Opened
    INIMgr.Update('PregledJedinicaMjere',BrowseWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeJedinicaMjere
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledRokovaIsporuke PROCEDURE 

BRW1::View:Browse    VIEW(ROK_ISPORUKE)
                       PROJECT(ROK:Sifra_roka_isporuke)
                       PROJECT(ROK:Datum_roka_isporuke)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ROK:Sifra_roka_isporuke LIKE(ROK:Sifra_roka_isporuke) !List box control field - type derived from field
ROK:Datum_roka_isporuke LIKE(ROK:Datum_roka_isporuke) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Rokova Isporuke'),AT(0,0,247,140),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI, |
  SYSTEM,WALLPAPER('Backgrounds\angryimg.png'),IMM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('71L(2)|M~Sifra Roka Isporuke~C(0)@s6@4' & |
  '0L(2)|M~Datum roka isporuke~C(0)@D6B@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END


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
  GlobalErrors.SetProcedureName('PregledRokovaIsporuke')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:ROK_ISPORUKE.SetOpenRelated()
  Relate:ROK_ISPORUKE.Open                                 ! File ROK_ISPORUKE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ROK_ISPORUKE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(ROK:Sifra_roka_isporuke,BRW1.Q.ROK:Sifra_roka_isporuke) ! Field ROK:Sifra_roka_isporuke is a hot field or requires assignment from browse
  BRW1.AddField(ROK:Datum_roka_isporuke,BRW1.Q.ROK:Datum_roka_isporuke) ! Field ROK:Datum_roka_isporuke is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledRokovaIsporuke',BrowseWindow)       ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjeRokovaIsporuke
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PregledRokovaIsporuke',BrowseWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeRokovaIsporuke
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledNacinaOtpreme PROCEDURE 

BRW1::View:Browse    VIEW(NACIN_OTPREME)
                       PROJECT(NAC:Sifra_nacina_otpreme)
                       PROJECT(NAC:Naziv_nacina_otpreme)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
NAC:Sifra_nacina_otpreme LIKE(NAC:Sifra_nacina_otpreme) !List box control field - type derived from field
NAC:Naziv_nacina_otpreme LIKE(NAC:Naziv_nacina_otpreme) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Nacina Otpreme'),AT(0,0,247,140),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI, |
  SYSTEM,WALLPAPER('Backgrounds\angryimg.png'),IMM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('87L(2)|M~Sifra Nacina Otpreme~C(0)@s6@' & |
  '76L(2)|M~Naziv Nacina Otpreme~C(0)@s19@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
                       BUTTON('&Unos'),AT(5,110,40,12),USE(?Insert)
                       BUTTON('&Izmjena'),AT(50,110,40,12),USE(?Change),DEFAULT
                       BUTTON('&Brisanje'),AT(95,110,40,12),USE(?Delete)
                       BUTTON('&Odabir'),AT(145,110,40,12),USE(?Select)
                       BUTTON('Zatvori'),AT(200,110,40,12),USE(?Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::EIPManager     BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List
EditInPlace::NAC:Sifra_nacina_otpreme EditEntryClass       ! Edit-in-place class for field NAC:Sifra_nacina_otpreme
EditInPlace::NAC:Naziv_nacina_otpreme EditEntryClass       ! Edit-in-place class for field NAC:Naziv_nacina_otpreme

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
  GlobalErrors.SetProcedureName('PregledNacinaOtpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:NACIN_OTPREME.Open                                ! File NACIN_OTPREME used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:NACIN_OTPREME,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(NAC:Sifra_nacina_otpreme,BRW1.Q.NAC:Sifra_nacina_otpreme) ! Field NAC:Sifra_nacina_otpreme is a hot field or requires assignment from browse
  BRW1.AddField(NAC:Naziv_nacina_otpreme,BRW1.Q.NAC:Naziv_nacina_otpreme) ! Field NAC:Naziv_nacina_otpreme is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledNacinaOtpreme',BrowseWindow)        ! Restore window settings from non-volatile store
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PregledNacinaOtpreme',BrowseWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    AzuriranjeNacinaOtpreme
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW1::EIPManager                             ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::NAC:Sifra_nacina_otpreme,1)
  SELF.AddEditControl(EditInPlace::NAC:Naziv_nacina_otpreme,2)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END

