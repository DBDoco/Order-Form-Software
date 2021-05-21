

   MEMBER('Narudzbenica.clw')                              ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('NARUDZBENICA002.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('NARUDZBENICA001.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('NARUDZBENICA003.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Browse
!!! </summary>
PregledPlacanja PROCEDURE 

BRW1::View:Browse    VIEW(PLACANJE)
                       PROJECT(PLA:Sifra_placanja)
                       PROJECT(PLA:Nacin_placanja)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
PLA:Sifra_placanja     LIKE(PLA:Sifra_placanja)       !List box control field - type derived from field
PLA:Nacin_placanja     LIKE(PLA:Nacin_placanja)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BrowseWindow         WINDOW('Pregled Placanja'),AT(0,0,247,140),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,WALLPAPER('Background' & |
  's\angryimg.png'),IMM
                       LIST,AT(5,5,235,100),USE(?List),HVSCROLL,FORMAT('62L(2)|M~Sifra Placanja~C(0)@s6@76L(2)' & |
  '|M~Nacin placanja~C(0)@s19@'),FROM(Queue:Browse),IMM,MSG('Browsing Records')
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
  GlobalErrors.SetProcedureName('PregledPlacanja')
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
  Relate:PLACANJE.Open                                     ! File PLACANJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:PLACANJE,SELF) ! Initialize the browse manager
  SELF.Open(BrowseWindow)                                  ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,)                                     ! Add the sort order for  for sort order 1
  BRW1.AddField(PLA:Sifra_placanja,BRW1.Q.PLA:Sifra_placanja) ! Field PLA:Sifra_placanja is a hot field or requires assignment from browse
  BRW1.AddField(PLA:Nacin_placanja,BRW1.Q.PLA:Nacin_placanja) ! Field PLA:Nacin_placanja is a hot field or requires assignment from browse
  INIMgr.Fetch('PregledPlacanja',BrowseWindow)             ! Restore window settings from non-volatile store
  BRW1.AskProcedure = 1                                    ! Will call: AzuriranjePlacanja
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('PregledPlacanja',BrowseWindow)          ! Save window data to non-volatile store
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
    AzuriranjePlacanja
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
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeDjelatnika PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::DJE:Record  LIKE(DJE:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Djelatnika...'),AT(,,207,72),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  CENTER,COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Win' & |
  'dows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(5,53,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(50,53,40,12),USE(?Cancel)
                       PROMPT('OIB:'),AT(5,10),USE(?DJE:OIB:Prompt)
                       ENTRY(@s11),AT(73,9,60,10),USE(DJE:OIB)
                       PROMPT('Ime Djelatnika:'),AT(5,32),USE(?DJE:Ime_djelatnika:Prompt)
                       ENTRY(@s19),AT(73,32,126,10),USE(DJE:Ime_djelatnika)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeDjelatnika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(DJE:Record,History::DJE:Record)
  SELF.AddHistoryField(?DJE:OIB,1)
  SELF.AddHistoryField(?DJE:Ime_djelatnika,2)
  SELF.AddUpdateFile(Access:DJELATNIK)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:DJELATNIK.SetOpenRelated()
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:DJELATNIK
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeDjelatnika',FormWindow)          ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeDjelatnika',FormWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeFirmi PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::FIR:Record  LIKE(FIR:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Firmi...'),AT(,,289,114),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(5,90,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(50,90,40,12),USE(?Cancel)
                       PROMPT('Maticni Broj Firme:'),AT(5,6),USE(?FIR:Maticni_broj_firme:Prompt:2)
                       ENTRY(@s7),AT(82,6,60,10),USE(FIR:Maticni_broj_firme,,?FIR:Maticni_broj_firme:2)
                       PROMPT('Naziv Firme:'),AT(5,26),USE(?FIR:Naziv_firme:Prompt:2)
                       ENTRY(@s29),AT(82,26,121,10),USE(FIR:Naziv_firme,,?FIR:Naziv_firme:2)
                       PROMPT('Adresa Firme:'),AT(6,48),USE(?FIR:Adresa_firme:Prompt:2)
                       ENTRY(@s29),AT(82,48,121,10),USE(FIR:Adresa_firme,,?FIR:Adresa_firme:2)
                       PROMPT('Poštanski Broj:'),AT(5,70),USE(?FIR:Postanski_broj:Prompt)
                       ENTRY(@s5),AT(82,70,34,10),USE(FIR:Postanski_broj)
                       STRING(@s29),AT(120,70),USE(MJE:Naziv_mjesta)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeFirmi')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(FIR:Record,History::FIR:Record)
  SELF.AddHistoryField(?FIR:Maticni_broj_firme:2,1)
  SELF.AddHistoryField(?FIR:Naziv_firme:2,2)
  SELF.AddHistoryField(?FIR:Adresa_firme:2,3)
  SELF.AddHistoryField(?FIR:Postanski_broj,4)
  SELF.AddUpdateFile(Access:FIRMA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:FIRMA.SetOpenRelated()
  Relate:FIRMA.Open                                        ! File FIRMA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:FIRMA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeFirmi',FormWindow)               ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeFirmi',FormWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  MJE:Postanski_broj = FIR:Postanski_broj                  ! Assign linking field value
  Access:MJESTO.Fetch(MJE:PK_PostanskiBroj)
  MJE:Postanski_broj = FIR:Postanski_broj                  ! Assign linking field value
  Access:MJESTO.Fetch(MJE:PK_PostanskiBroj)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PregledMjesta
    ReturnValue = GlobalResponse
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?FIR:Postanski_broj
      IF Access:FIRMA.TryValidateField(4)                  ! Attempt to validate FIR:Postanski_broj in FIRMA
        SELECT(?FIR:Postanski_broj)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?FIR:Postanski_broj
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?FIR:Postanski_broj{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?FIR:Postanski_broj
      MJE:Postanski_broj = FIR:Postanski_broj
      IF Access:MJESTO.TryFetch(MJE:PK_PostanskiBroj)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          FIR:Postanski_broj = MJE:Postanski_broj
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeJedinicaMjere PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::JED:Record  LIKE(JED:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Jedinica Mjere...'),AT(,,273,71),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  CENTER,COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Win' & |
  'dows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(4,48,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(48,48,40,12),USE(?Cancel)
                       PROMPT('Šifra Jedinice Mjere:'),AT(4,8),USE(?JED:Sifra_jedinice_mjere:Prompt)
                       ENTRY(@s6),AT(80,7,60,10),USE(JED:Sifra_jedinice_mjere)
                       PROMPT('Naziv Jedinice Mjere:'),AT(4,28),USE(?JED:Naziv_jedinice_mjere:Prompt)
                       ENTRY(@s19),AT(80,28,74,10),USE(JED:Naziv_jedinice_mjere)
                       CHECK('Komad'),AT(177,28),USE(JED:Naziv_jedinice_mjere,,?JED:Naziv_jedinice_mjere:2),VALUE('Komad', |
  '')
                       STRING('Ili'),AT(162,28),USE(?STRING1)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeJedinicaMjere')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(JED:Record,History::JED:Record)
  SELF.AddHistoryField(?JED:Sifra_jedinice_mjere,1)
  SELF.AddHistoryField(?JED:Naziv_jedinice_mjere,2)
  SELF.AddHistoryField(?JED:Naziv_jedinice_mjere:2,2)
  SELF.AddUpdateFile(Access:JEDINICA_MJERE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:JEDINICA_MJERE.SetOpenRelated()
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:JEDINICA_MJERE
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeJedinicaMjere',FormWindow)       ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeJedinicaMjere',FormWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeMjesta PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::MJE:Record  LIKE(MJE:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Mjesta...'),AT(,,207,77),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(5,50,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(50,50,40,12),USE(?Cancel)
                       PROMPT('Poštanski Broj:'),AT(5,8),USE(?MJE:Postanski_broj:Prompt)
                       ENTRY(@s5),AT(55,7,42,10),USE(MJE:Postanski_broj)
                       PROMPT('Naziv Mjesta:'),AT(5,29),USE(?MJE:Naziv_mjesta:Prompt)
                       ENTRY(@s29),AT(55,28,138,10),USE(MJE:Naziv_mjesta)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(MJE:Record,History::MJE:Record)
  SELF.AddHistoryField(?MJE:Postanski_broj,1)
  SELF.AddHistoryField(?MJE:Naziv_mjesta,2)
  SELF.AddUpdateFile(Access:MJESTO)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MJESTO
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeMjesta',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeMjesta',FormWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNacinaOtpreme PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::NAC:Record  LIKE(NAC:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Nacina Otpreme...'),AT(,,200,61),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  CENTER,ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'), |
  GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(6,43,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(51,43,40,12),USE(?Cancel)
                       PROMPT('Sifra Nacina Otpreme:'),AT(6,8),USE(?NAC:Sifra_nacina_otpreme:Prompt)
                       ENTRY(@s6),AT(84,8,60,10),USE(NAC:Sifra_nacina_otpreme)
                       PROMPT('Naziv Nacina Otpreme:'),AT(6,27),USE(?NAC:Naziv_nacina_otpreme:Prompt)
                       ENTRY(@s19),AT(84,26,109,10),USE(NAC:Naziv_nacina_otpreme)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeNacinaOtpreme')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(NAC:Record,History::NAC:Record)
  SELF.AddHistoryField(?NAC:Sifra_nacina_otpreme,1)
  SELF.AddHistoryField(?NAC:Naziv_nacina_otpreme,2)
  SELF.AddUpdateFile(Access:NACIN_OTPREME)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:NACIN_OTPREME.Open                                ! File NACIN_OTPREME used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:NACIN_OTPREME
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeNacinaOtpreme',FormWindow)       ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeNacinaOtpreme',FormWindow)    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeNarudzbenica PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
ukupno               CSTRING(20)                           ! 
BRW5::View:Browse    VIEW(STAVKE)
                       PROJECT(STA:Redni_broj_stavke)
                       PROJECT(STA:Sifra_robe)
                       PROJECT(STA:Kolicina)
                       PROJECT(STA:Iznos)
                       PROJECT(STA:Broj_narudzbenice)
                       JOIN(ROB:PK_SifraRobe,STA:Sifra_robe)
                         PROJECT(ROB:Naziv_robe)
                         PROJECT(ROB:Cijena)
                         PROJECT(ROB:Sifra_robe)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
STA:Redni_broj_stavke  LIKE(STA:Redni_broj_stavke)    !List box control field - type derived from field
STA:Sifra_robe         LIKE(STA:Sifra_robe)           !List box control field - type derived from field
ROB:Naziv_robe         LIKE(ROB:Naziv_robe)           !List box control field - type derived from field
ROB:Cijena             LIKE(ROB:Cijena)               !List box control field - type derived from field
STA:Kolicina           LIKE(STA:Kolicina)             !List box control field - type derived from field
STA:Iznos              LIKE(STA:Iznos)                !List box control field - type derived from field
STA:Broj_narudzbenice  LIKE(STA:Broj_narudzbenice)    !Primary key field - type derived from field
ROB:Sifra_robe         LIKE(ROB:Sifra_robe)           !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::NAR:Record  LIKE(NAR:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Narudžbenica...'),AT(,,487,292),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  CENTER,COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Win' & |
  'dows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(5,116,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(48,116,40,12),USE(?Cancel)
                       PROMPT('Broj Narudžbenice:'),AT(5,6),USE(?NAR:Broj_narudzbenice:Prompt),FONT('Arial',,,FONT:bold, |
  CHARSET:DEFAULT)
                       ENTRY(@s6),AT(100,6,60,10),USE(NAR:Broj_narudzbenice),RIGHT(1)
                       PROMPT('Datum Narudžbenice:'),AT(5,27),USE(?NAR:Datum_narudzbenice:Prompt)
                       ENTRY(@D6B),AT(100,26,60,10),USE(NAR:Datum_narudzbenice)
                       PROMPT(' Sifra Roka Isporuke:'),AT(4,48),USE(?NAR:Sifra_roka_isporuke:Prompt)
                       ENTRY(@s6),AT(100,48,60,10),USE(NAR:Sifra_roka_isporuke)
                       STRING(@D6B),AT(170,47),USE(ROK:Datum_roka_isporuke)
                       PROMPT('Sifra Nacina Otpreme:'),AT(5,70),USE(?NAR:Sifra_nacina_otpreme:Prompt)
                       ENTRY(@s6),AT(100,70,60,10),USE(NAR:Sifra_nacina_otpreme)
                       STRING(@s19),AT(170,70),USE(NAC:Naziv_nacina_otpreme)
                       PROMPT('Sifra Placanja:'),AT(5,93),USE(?NAR:Sifra_placanja:Prompt)
                       ENTRY(@s6),AT(100,92,60,10),USE(NAR:Sifra_placanja)
                       STRING(@s19),AT(170,93),USE(PLA:Nacin_placanja)
                       LIST,AT(6,153,428,100),USE(?List),RIGHT(1),FORMAT('80L(2)|M~Redni Broj Stavke~C(1)@n-7@' & |
  '[56L(2)|M~Sifra Robe~C(0)@s6@116L(2)|M~Naziv Robe~C(0)@s29@44L(2)|M~Cijena~C(12)@n-1' & |
  '0.2@](239)|~Podaci o Robi~59L(2)|M~Kolicina~C(1)@n-7@51L(2)|M~Iznos~C(1)@n-7@'),FROM(Queue:Browse), |
  IMM
                       BUTTON('&Insert'),AT(437,152,42,12),USE(?Insert)
                       BUTTON('&Change'),AT(437,167,42,12),USE(?Change)
                       BUTTON('&Delete'),AT(437,182,42,12),USE(?Delete)
                       PROMPT('Ukupno:'),AT(328,263),USE(?ukupno:Prompt:2)
                       STRING(@s19),AT(376,263),USE(ukupno,,?ukupno:3)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
BRW5                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
ResetFromView          PROCEDURE(),DERIVED
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeNarudzbenica')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(NAR:Record,History::NAR:Record)
  SELF.AddHistoryField(?NAR:Broj_narudzbenice,1)
  SELF.AddHistoryField(?NAR:Datum_narudzbenice,2)
  SELF.AddHistoryField(?NAR:Sifra_roka_isporuke,3)
  SELF.AddHistoryField(?NAR:Sifra_nacina_otpreme,4)
  SELF.AddHistoryField(?NAR:Sifra_placanja,5)
  SELF.AddUpdateFile(Access:NARUDZBENICA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:NACIN_OTPREME.SetOpenRelated()
  Relate:NACIN_OTPREME.Open                                ! File NACIN_OTPREME used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:NARUDZBENICA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  BRW5.Init(?List,Queue:Browse.ViewPosition,BRW5::View:Browse,Queue:Browse,Relate:STAVKE,SELF) ! Initialize the browse manager
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  BRW5.Q &= Queue:Browse
  BRW5.AddSortOrder(,STA:PK_Stavke)                        ! Add the sort order for STA:PK_Stavke for sort order 1
  BRW5.AddRange(STA:Broj_narudzbenice,Relate:STAVKE,Relate:NARUDZBENICA) ! Add file relationship range limit for sort order 1
  BRW5.AddLocator(BRW5::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,STA:Broj_narudzbenice,1,BRW5)  ! Initialize the browse locator using  using key: STA:PK_Stavke , STA:Broj_narudzbenice
  BRW5.AddField(STA:Redni_broj_stavke,BRW5.Q.STA:Redni_broj_stavke) ! Field STA:Redni_broj_stavke is a hot field or requires assignment from browse
  BRW5.AddField(STA:Sifra_robe,BRW5.Q.STA:Sifra_robe)      ! Field STA:Sifra_robe is a hot field or requires assignment from browse
  BRW5.AddField(ROB:Naziv_robe,BRW5.Q.ROB:Naziv_robe)      ! Field ROB:Naziv_robe is a hot field or requires assignment from browse
  BRW5.AddField(ROB:Cijena,BRW5.Q.ROB:Cijena)              ! Field ROB:Cijena is a hot field or requires assignment from browse
  BRW5.AddField(STA:Kolicina,BRW5.Q.STA:Kolicina)          ! Field STA:Kolicina is a hot field or requires assignment from browse
  BRW5.AddField(STA:Iznos,BRW5.Q.STA:Iznos)                ! Field STA:Iznos is a hot field or requires assignment from browse
  BRW5.AddField(STA:Broj_narudzbenice,BRW5.Q.STA:Broj_narudzbenice) ! Field STA:Broj_narudzbenice is a hot field or requires assignment from browse
  BRW5.AddField(ROB:Sifra_robe,BRW5.Q.ROB:Sifra_robe)      ! Field ROB:Sifra_robe is a hot field or requires assignment from browse
  INIMgr.Fetch('AzuriranjeNarudzbenica',FormWindow)        ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
  BRW5.AskProcedure = 4                                    ! Will call: AzuriranjeStavki
  BRW5.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
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
    INIMgr.Update('AzuriranjeNarudzbenica',FormWindow)     ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  ROK:Sifra_roka_isporuke = NAR:Sifra_roka_isporuke        ! Assign linking field value
  Access:ROK_ISPORUKE.Fetch(ROK:PK_SifraRokaIsporuke)
  NAC:Sifra_nacina_otpreme = NAR:Sifra_nacina_otpreme      ! Assign linking field value
  Access:NACIN_OTPREME.Fetch(NAC:PK_SifraNacinaOtpreme)
  PLA:Sifra_placanja = NAR:Sifra_placanja                  ! Assign linking field value
  Access:PLACANJE.Fetch(PLA:PK_SifraPlacanja)
  PLA:Sifra_placanja = NAR:Sifra_placanja                  ! Assign linking field value
  Access:PLACANJE.Fetch(PLA:PK_SifraPlacanja)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
      PregledRokovaIsporuke
      PregledNacinaOtpreme
      PregledPlacanja
      AzuriranjeStavki
    END
    ReturnValue = GlobalResponse
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?NAR:Sifra_roka_isporuke
      IF Access:NARUDZBENICA.TryValidateField(3)           ! Attempt to validate NAR:Sifra_roka_isporuke in NARUDZBENICA
        SELECT(?NAR:Sifra_roka_isporuke)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?NAR:Sifra_roka_isporuke
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?NAR:Sifra_roka_isporuke{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?NAR:Sifra_nacina_otpreme
      IF Access:NARUDZBENICA.TryValidateField(4)           ! Attempt to validate NAR:Sifra_nacina_otpreme in NARUDZBENICA
        SELECT(?NAR:Sifra_nacina_otpreme)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?NAR:Sifra_nacina_otpreme
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?NAR:Sifra_nacina_otpreme{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?NAR:Sifra_placanja
      IF Access:NARUDZBENICA.TryValidateField(5)           ! Attempt to validate NAR:Sifra_placanja in NARUDZBENICA
        SELECT(?NAR:Sifra_placanja)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?NAR:Sifra_placanja
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?NAR:Sifra_placanja{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?NAR:Sifra_roka_isporuke
      ROK:Sifra_roka_isporuke = NAR:Sifra_roka_isporuke
      IF Access:ROK_ISPORUKE.TryFetch(ROK:PK_SifraRokaIsporuke)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          NAR:Sifra_roka_isporuke = ROK:Sifra_roka_isporuke
        END
      END
      ThisWindow.Reset()
    OF ?NAR:Sifra_nacina_otpreme
      NAC:Sifra_nacina_otpreme = NAR:Sifra_nacina_otpreme
      IF Access:NACIN_OTPREME.TryFetch(NAC:PK_SifraNacinaOtpreme)
        IF SELF.Run(2,SelectRecord) = RequestCompleted
          NAR:Sifra_nacina_otpreme = NAC:Sifra_nacina_otpreme
        END
      END
      ThisWindow.Reset()
    OF ?NAR:Sifra_placanja
      PLA:Sifra_placanja = NAR:Sifra_placanja
      IF Access:PLACANJE.TryFetch(PLA:PK_SifraPlacanja)
        IF SELF.Run(3,SelectRecord) = RequestCompleted
          NAR:Sifra_placanja = PLA:Sifra_placanja
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW5.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW5.ResetFromView PROCEDURE

ukupno:Sum           REAL                                  ! Sum variable for browse totals
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:STAVKE.SetQuickScan(1)
  SELF.Reset
  IF SELF.UseMRP
     IF SELF.View{PROP:IPRequestCount} = 0
          SELF.View{PROP:IPRequestCount} = 60
     END
  END
  LOOP
    IF SELF.UseMRP
       IF SELF.View{PROP:IPRequestCount} = 0
            SELF.View{PROP:IPRequestCount} = 60
       END
    END
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      SETCURSOR()
      RETURN
    END
    SELF.SetQueueRecord
    ukupno:Sum += STA:Iznos
  END
  SELF.View{PROP:IPRequestCount} = 0
  ukupno = ukupno:Sum
  PARENT.ResetFromView
  Relate:STAVKE.SetQuickScan(0)
  SETCURSOR()

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePlacanja PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::PLA:Record  LIKE(PLA:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Placanja...'),AT(,,158,123),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(6,100,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(51,100,40,12),USE(?Cancel)
                       PROMPT('Sifra Placanja:'),AT(6,8),USE(?PLA:Sifra_placanja:Prompt)
                       ENTRY(@s6),AT(57,8,60,10),USE(PLA:Sifra_placanja)
                       OPTION('Nacin Placanja'),AT(6,34,74,48),USE(PLA:Nacin_placanja),BOXED
                         RADIO('Gotovina'),AT(16,46),USE(?OPTION1:RADIO1),VALUE('Gotovina')
                         RADIO('Kartica'),AT(17,64),USE(?OPTION1:RADIO2),VALUE('Kartica')
                       END
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjePlacanja')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(PLA:Record,History::PLA:Record)
  SELF.AddHistoryField(?PLA:Sifra_placanja,1)
  SELF.AddHistoryField(?PLA:Nacin_placanja,2)
  SELF.AddUpdateFile(Access:PLACANJE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:PLACANJE.Open                                     ! File PLACANJE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:PLACANJE
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjePlacanja',FormWindow)            ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjePlacanja',FormWindow)         ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeRobe PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ROB:Record  LIKE(ROB:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Robe...'),AT(,,252,116),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       PROMPT('Šifra Robe:'),AT(8,8),USE(?ROB:Sifra_robe:Prompt)
                       ENTRY(@s6),AT(84,8,60,10),USE(ROB:Sifra_robe)
                       PROMPT('Naziv Robe:'),AT(8,28),USE(?ROB:Naziv_robe:Prompt)
                       ENTRY(@s29),AT(84,28,60,10),USE(ROB:Naziv_robe)
                       PROMPT('Cijena:'),AT(8,49),USE(?ROB:Cijena:Prompt)
                       ENTRY(@n-10.2),AT(84,49,60,10),USE(ROB:Cijena),DECIMAL(12)
                       PROMPT('Šifra Jedinice Mjere:'),AT(8,71),USE(?ROB:Sifra_jedinice_mjere:Prompt)
                       ENTRY(@s6),AT(84,71,60,10),USE(ROB:Sifra_jedinice_mjere)
                       STRING(@s19),AT(148,71),USE(JED:Naziv_jedinice_mjere)
                       BUTTON('OK'),AT(8,92,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(53,92,40,12),USE(?Cancel)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeRobe')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?ROB:Sifra_robe:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ROB:Record,History::ROB:Record)
  SELF.AddHistoryField(?ROB:Sifra_robe,1)
  SELF.AddHistoryField(?ROB:Naziv_robe,2)
  SELF.AddHistoryField(?ROB:Cijena,3)
  SELF.AddHistoryField(?ROB:Sifra_jedinice_mjere,4)
  SELF.AddUpdateFile(Access:ROBA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:JEDINICA_MJERE.SetOpenRelated()
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ROBA
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeRobe',FormWindow)                ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeRobe',FormWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere      ! Assign linking field value
  Access:JEDINICA_MJERE.Fetch(JED:PK_SifraJediniceMjere)
  JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere      ! Assign linking field value
  Access:JEDINICA_MJERE.Fetch(JED:PK_SifraJediniceMjere)
  PARENT.Reset(Force)


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    PregledJedinicaMjere
    ReturnValue = GlobalResponse
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?ROB:Sifra_jedinice_mjere
      IF Access:ROBA.TryValidateField(4)                   ! Attempt to validate ROB:Sifra_jedinice_mjere in ROBA
        SELECT(?ROB:Sifra_jedinice_mjere)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?ROB:Sifra_jedinice_mjere
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?ROB:Sifra_jedinice_mjere{PROP:FontColor} = FieldColorQueue.OldColor
          DELETE(FieldColorQueue)
        END
      END
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?ROB:Sifra_jedinice_mjere
      JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere
      IF Access:JEDINICA_MJERE.TryFetch(JED:PK_SifraJediniceMjere)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          ROB:Sifra_jedinice_mjere = JED:Sifra_jedinice_mjere
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjeRokovaIsporuke PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ROK:Record  LIKE(ROK:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Rokova Isporuke...'),AT(,,160,76),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT), |
  CENTER,COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Win' & |
  'dows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(6,52,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(51,52,40,12),USE(?Cancel)
                       PROMPT(' Sifra Roka Isporuke:'),AT(6,10),USE(?ROK:Sifra_roka_isporuke:Prompt)
                       ENTRY(@s6),AT(88,9,60,10),USE(ROK:Sifra_roka_isporuke)
                       PROMPT('Datum roka isporuke:'),AT(8,32),USE(?ROK:Datum_roka_isporuke:Prompt)
                       ENTRY(@D6B),AT(88,32,60,10),USE(ROK:Datum_roka_isporuke)
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
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

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record will be Added'
  OF ChangeRecord
    ActionMessage = 'Record will be Changed'
  END
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AzuriranjeRokovaIsporuke')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(ROK:Record,History::ROK:Record)
  SELF.AddHistoryField(?ROK:Sifra_roka_isporuke,1)
  SELF.AddHistoryField(?ROK:Datum_roka_isporuke,2)
  SELF.AddUpdateFile(Access:ROK_ISPORUKE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ROK_ISPORUKE.SetOpenRelated()
  Relate:ROK_ISPORUKE.Open                                 ! File ROK_ISPORUKE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ROK_ISPORUKE
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(FormWindow)                                    ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('AzuriranjeRokovaIsporuke',FormWindow)      ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeRokovaIsporuke',FormWindow)   ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

