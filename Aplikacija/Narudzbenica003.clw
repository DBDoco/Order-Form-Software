

   MEMBER('Narudzbenica.clw')                              ! This is a MEMBER module


   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('NARUDZBENICA003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('NARUDZBENICA001.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Form
!!! </summary>
AzuriranjePotpisa PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::POT:Record  LIKE(POT:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Potpisa...'),AT(,,289,81),CENTER,COLOR(COLOR:White),ICON('Icons\list' & |
  '_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10 cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(5,54,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(50,54,40,12),USE(?Cancel)
                       PROMPT('Redni Broj Potpisa:'),AT(4,8),USE(?POT:Redni_broj_potpisa:Prompt)
                       ENTRY(@n-7),AT(74,8,60,10),USE(POT:Redni_broj_potpisa),RIGHT(1)
                       PROMPT('OIB:'),AT(5,33,,8),USE(?POT:OIB:Prompt)
                       ENTRY(@s11),AT(74,32,60,8),USE(POT:OIB)
                       STRING(@s19),AT(146,31),USE(DJE:Ime_djelatnika)
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
  GlobalErrors.SetProcedureName('AzuriranjePotpisa')
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
  SELF.AddHistoryFile(POT:Record,History::POT:Record)
  SELF.AddHistoryField(?POT:Redni_broj_potpisa,1)
  SELF.AddHistoryField(?POT:OIB,3)
  SELF.AddUpdateFile(Access:POTPISUJE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:DJELATNIK.SetOpenRelated()
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:POTPISUJE
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
  INIMgr.Fetch('AzuriranjePotpisa',FormWindow)             ! Restore window settings from non-volatile store
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
    INIMgr.Update('AzuriranjePotpisa',FormWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  DJE:OIB = POT:OIB                                        ! Assign linking field value
  Access:DJELATNIK.Fetch(DJE:PK_OIB)
  DJE:OIB = POT:OIB                                        ! Assign linking field value
  Access:DJELATNIK.Fetch(DJE:PK_OIB)
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
    PregledDjelatnika
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
    OF ?POT:OIB
      IF Access:POTPISUJE.TryValidateField(3)              ! Attempt to validate POT:OIB in POTPISUJE
        SELECT(?POT:OIB)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?POT:OIB
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?POT:OIB{PROP:FontColor} = FieldColorQueue.OldColor
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
    OF ?POT:OIB
      DJE:OIB = POT:OIB
      IF Access:DJELATNIK.TryFetch(DJE:PK_OIB)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          POT:OIB = DJE:OIB
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
AzuriranjeUloge PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::ULO:Record  LIKE(ULO:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Uloge...'),AT(,,169,121),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       BUTTON('OK'),AT(9,98,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(54,98,40,12),USE(?Cancel)
                       PROMPT('Broj Narudžbenice:'),AT(6,8),USE(?ULO:Broj_narudzbenice:Prompt)
                       ENTRY(@s6),AT(70,8,60,10),USE(ULO:Broj_narudzbenice),RIGHT(1)
                       OPTION('Uloga'),AT(9,28,81),USE(ULO:Dobavljac_narucitelj),BOXED
                         RADIO('Dobavljac'),AT(19,38),USE(?OPTION1:RADIO1),VALUE('Dobavljac')
                         RADIO('Narucitelj'),AT(19,59),USE(?OPTION1:RADIO2),VALUE('Narucitelj')
                       END
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
  GlobalErrors.SetProcedureName('AzuriranjeUloge')
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
  SELF.AddHistoryFile(ULO:Record,History::ULO:Record)
  SELF.AddHistoryField(?ULO:Broj_narudzbenice,1)
  SELF.AddHistoryField(?ULO:Dobavljac_narucitelj,3)
  SELF.AddUpdateFile(Access:ULOGA)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:NARUDZBENICA.SetOpenRelated()
  Relate:NARUDZBENICA.Open                                 ! File NARUDZBENICA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:ULOGA
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
  INIMgr.Fetch('AzuriranjeUloge',FormWindow)               ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeUloge',FormWindow)            ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  NAR:Broj_narudzbenice = ULO:Broj_narudzbenice            ! Assign linking field value
  Access:NARUDZBENICA.Fetch(NAR:PK_BrojNarudzbenice)
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
    PregledNarudzbenica
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
    OF ?ULO:Broj_narudzbenice
      IF Access:ULOGA.TryValidateField(1)                  ! Attempt to validate ULO:Broj_narudzbenice in ULOGA
        SELECT(?ULO:Broj_narudzbenice)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?ULO:Broj_narudzbenice
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?ULO:Broj_narudzbenice{PROP:FontColor} = FieldColorQueue.OldColor
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
    OF ?ULO:Broj_narudzbenice
      NAR:Broj_narudzbenice = ULO:Broj_narudzbenice
      IF Access:NARUDZBENICA.TryFetch(NAR:PK_BrojNarudzbenice)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          ULO:Broj_narudzbenice = NAR:Broj_narudzbenice
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
AzuriranjeStavki PROCEDURE 

ActionMessage        CSTRING(40)                           ! 
History::STA:Record  LIKE(STA:RECORD),THREAD
FormWindow           WINDOW('Ažuriranje Stavki...'),AT(,,256,107),FONT('Arial',,,FONT:bold,CHARSET:DEFAULT),CENTER, |
  COLOR(COLOR:White),ICON('Icons\list_122348 (1).ico'),CURSOR('Cursor\Modern Windows 10' & |
  ' cursor 1.cur'),GRAY,MDI,SYSTEM,IMM
                       PROMPT('Sifra Robe:'),AT(8,6),USE(?STA:Sifra_robe:Prompt)
                       ENTRY(@s6),AT(58,6,60,10),USE(STA:Sifra_robe)
                       STRING(@s29),AT(121,6,116),USE(ROB:Naziv_robe)
                       PROMPT('Kolicina:'),AT(8,30),USE(?STA:Kolicina:Prompt)
                       ENTRY(@n-7),AT(58,30,60,10),USE(STA:Kolicina),RIGHT(1)
                       PROMPT('Iznos:'),AT(8,56),USE(?STA:Iznos:Prompt:2)
                       ENTRY(@n-7),AT(58,56,60,10),USE(STA:Iznos),RIGHT(1)
                       BUTTON('OK'),AT(8,78,40,12),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(52,78,40,12),USE(?Cancel)
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
  GlobalErrors.SetProcedureName('AzuriranjeStavki')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?STA:Sifra_robe:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(STA:Record,History::STA:Record)
  SELF.AddHistoryField(?STA:Sifra_robe,5)
  SELF.AddHistoryField(?STA:Kolicina,4)
  SELF.AddHistoryField(?STA:Iznos,3)
  SELF.AddUpdateFile(Access:STAVKE)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:ROBA.SetOpenRelated()
  Relate:ROBA.Open                                         ! File ROBA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:STAVKE
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
  INIMgr.Fetch('AzuriranjeStavki',FormWindow)              ! Restore window settings from non-volatile store
  SELF.AddItem(ToolbarForm)
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
    INIMgr.Update('AzuriranjeStavki',FormWindow)           ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF FormWindow{Prop:AcceptAll} THEN RETURN.
  ROB:Sifra_robe = STA:Sifra_robe                          ! Assign linking field value
  Access:ROBA.Fetch(ROB:PK_SifraRobe)
  ROB:Sifra_robe = STA:Sifra_robe                          ! Assign linking field value
  Access:ROBA.Fetch(ROB:PK_SifraRobe)
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
    PregledRobe
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
    OF ?STA:Sifra_robe
      IF Access:STAVKE.TryValidateField(5)                 ! Attempt to validate STA:Sifra_robe in STAVKE
        SELECT(?STA:Sifra_robe)
        FormWindow{PROP:AcceptAll} = False
        CYCLE
      ELSE
        FieldColorQueue.Feq = ?STA:Sifra_robe
        GET(FieldColorQueue, FieldColorQueue.Feq)
        IF ERRORCODE() = 0
          ?STA:Sifra_robe{PROP:FontColor} = FieldColorQueue.OldColor
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
    CASE FIELD()
    OF ?STA:Iznos
      STA:Iznos=STA:Kolicina*ROB:Cijena
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?STA:Sifra_robe
      ROB:Sifra_robe = STA:Sifra_robe
      IF Access:ROBA.TryFetch(ROB:PK_SifraRobe)
        IF SELF.Run(1,SelectRecord) = RequestCompleted
          STA:Sifra_robe = ROB:Sifra_robe
        END
      END
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisNarudzbenica PROCEDURE 

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
                         STRING('Datum Izvještaja: '),AT(31,729),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1344,729),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
BreakOIB               BREAK(POT:OIB),USE(?BREAK1)
BreakUloga               BREAK(ULO:Dobavljac_narucitelj),USE(?BREAK2)
BreakBrojNarudzbenice      BREAK(NAR:Broj_narudzbenice),USE(?BREAK3)
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
Detail                       DETAIL,AT(0,0,6250,260),USE(?Detail)
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
  GlobalErrors.SetProcedureName('IspisNarudzbenica')
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
  INIMgr.Fetch('IspisNarudzbenica',ProgressWindow)         ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:NARUDZBENICA, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
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
    INIMgr.Update('IspisNarudzbenica',ProgressWindow)      ! Save window data to non-volatile store
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
IspisFirmi PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(FIRMA)
                       PROJECT(FIR:Adresa_firme)
                       PROJECT(FIR:Maticni_broj_firme)
                       PROJECT(FIR:Naziv_firme)
                       PROJECT(FIR:Postanski_broj)
                       JOIN(MJE:PK_PostanskiBroj,FIR:Postanski_broj)
                         PROJECT(MJE:Naziv_mjesta)
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
                         STRING('Popis Firmi'),AT(-10,-10,2948),USE(?STRING4),FONT(,30,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja:'),AT(31,708),USE(?ReportDatePrompt:3),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1396,708),USE(?ReportDateStamp:2),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,1271),USE(?Detail)
                         STRING('Maticni Broj Firme:'),AT(31,62),USE(?STRING1),FONT(,,,FONT:regular)
                         STRING(@s7),AT(1396,73),USE(FIR:Maticni_broj_firme,,?FIR:Maticni_broj_firme:2)
                         STRING('Naziv Firme:'),AT(31,323),USE(?STRING2),FONT(,,,FONT:regular)
                         STRING(@s29),AT(1396,333),USE(FIR:Naziv_firme,,?FIR:Naziv_firme:2)
                         STRING('Adresa Firme'),AT(31,583),USE(?STRING3),FONT(,,,FONT:regular)
                         STRING(@s29),AT(1396,594),USE(FIR:Adresa_firme,,?FIR:Adresa_firme:2)
                         STRING('Poštanski Broj:'),AT(31,844),USE(?STRING5),FONT(,,,FONT:regular)
                         STRING(@s5),AT(1396,854),USE(FIR:Postanski_broj,,?FIR:Postanski_broj:2)
                         STRING(@s29),AT(3094,854),USE(MJE:Naziv_mjesta)
                         STRING('Naziv Mjesta'),AT(2250,854),USE(?STRING6)
                         LINE,AT(-489,1156,7240,0),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                       END
                       FOOTER,AT(1000,9688,6250,687),USE(?Footer)
                         STRING(@N3),AT(3281,229),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice:'),AT(2365,219,771,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
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
  GlobalErrors.SetProcedureName('IspisFirmi')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:FIRMA.SetOpenRelated()
  Relate:FIRMA.Open                                        ! File FIRMA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisFirmi',ProgressWindow)                ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:FIRMA, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:FIRMA.SetQuickScan(1,Propagate:OneMany)
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
    Relate:FIRMA.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisFirmi',ProgressWindow)             ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.OpenReport PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.OpenReport()
  IF ReturnValue = Level:Benign
    SELF.Report $ ?ReportDateStamp:2{PROP:Text} = FORMAT(TODAY(),@D17)
  END
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

!!! <summary>
!!! Generated from procedure template - Report
!!! </summary>
IspisMjesta PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(MJESTO)
                       PROJECT(MJE:Naziv_mjesta)
                       PROJECT(MJE:Postanski_broj)
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
                         STRING('Popis Mjesta'),AT(-10,-10,2948),USE(?STRING4),FONT(,30,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja: '),AT(31,708),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1354,708),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,833),USE(?Detail)
                         STRING(@s5),AT(1073,31),USE(MJE:Postanski_broj,,?MJE:Postanski_broj:2)
                         STRING(@s29),AT(1073,292),USE(MJE:Naziv_mjesta)
                         STRING('Poštanski Broj: '),AT(31,31),USE(?STRING1)
                         STRING('Naziv Mjesta:'),AT(31,292),USE(?STRING2)
                         LINE,AT(-416,656,8115,0),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                       END
                       FOOTER,AT(1000,9688,6250,656),USE(?Footer)
                         STRING(@N3),AT(3260,333),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice: '),AT(2354,333,844,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
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
  GlobalErrors.SetProcedureName('IspisMjesta')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:MJESTO.SetOpenRelated()
  Relate:MJESTO.Open                                       ! File MJESTO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisMjesta',ProgressWindow)               ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:MJESTO, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:MJESTO.SetQuickScan(1,Propagate:OneMany)
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
    Relate:MJESTO.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisMjesta',ProgressWindow)            ! Save window data to non-volatile store
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
IspisRobe PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(ROBA)
                       PROJECT(ROB:Cijena)
                       PROJECT(ROB:Naziv_robe)
                       PROJECT(ROB:Sifra_jedinice_mjere)
                       PROJECT(ROB:Sifra_robe)
                       JOIN(JED:PK_SifraJediniceMjere,ROB:Sifra_jedinice_mjere)
                         PROJECT(JED:Naziv_jedinice_mjere)
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
                         STRING('Popis Robe'),AT(-10,-10,2135),USE(?STRING4),FONT(,30,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja: '),AT(31,729),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1354,740),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,1375),USE(?Detail)
                         STRING(@s6),AT(1375,31),USE(ROB:Sifra_robe,,?ROB:Sifra_robe:2)
                         STRING(@s29),AT(1375,292),USE(ROB:Naziv_robe)
                         STRING(@n-10.2),AT(1375,552),USE(ROB:Cijena),DECIMAL(12)
                         STRING(@s6),AT(1375,812),USE(ROB:Sifra_jedinice_mjere)
                         LINE,AT(-457,1187,7177,-20),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                         STRING('Šifra Robe:'),AT(31,31,729),USE(?STRING1)
                         STRING('Naziv Robe:'),AT(31,292,844,198),USE(?STRING1:2)
                         STRING('Cijena:'),AT(31,552,604,198),USE(?STRING1:3)
                         STRING('Šifra Jedinice Mjere:'),AT(31,812,1281,198),USE(?STRING1:4)
                         STRING(@s19),AT(3552,812),USE(JED:Naziv_jedinice_mjere)
                         STRING('Naziv Jedinice Mjere:'),AT(2208,812,1281,198),USE(?STRING1:5)
                       END
                       FOOTER,AT(1000,9688,6250,771),USE(?Footer)
                         STRING(@s6),AT(115,1562),USE(ROB:Sifra_robe)
                         STRING(@N3),AT(3552,490),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj stranice:'),AT(2510,490,896,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
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
  GlobalErrors.SetProcedureName('IspisRobe')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:ROBA.SetOpenRelated()
  Relate:ROBA.Open                                         ! File ROBA used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisRobe',ProgressWindow)                 ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:ROBA, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:ROBA.SetQuickScan(1,Propagate:OneMany)
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
    Relate:ROBA.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisRobe',ProgressWindow)              ! Save window data to non-volatile store
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
IspisDjelatnika PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(DJELATNIK)
                       PROJECT(DJE:Ime_djelatnika)
                       PROJECT(DJE:OIB)
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
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Popis Djelatnika'),AT(-10,-10),USE(?STRING4),FONT(,30,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         STRING('Datum Izvještaja:'),AT(31,708),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1469,708),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,937),USE(?Detail)
                         STRING(@s11),AT(1000,31),USE(DJE:OIB)
                         STRING(@s19),AT(1000,292),USE(DJE:Ime_djelatnika)
                         STRING('OIB:'),AT(31,31),USE(?STRING2),FONT(,,,FONT:regular)
                         STRING('Ime Djelatnika:'),AT(31,292),USE(?STRING3),FONT(,,,FONT:regular)
                         LINE,AT(-593,677,7198,0),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                       END
                       FOOTER,AT(1000,9688,6250,708),USE(?Footer)
                         STRING(@N3),AT(3302,323),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
                         STRING('Broj Stranice:'),AT(2406,323),USE(?STRING1),FONT(,,,FONT:regular+FONT:underline)
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
  GlobalErrors.SetProcedureName('IspisDjelatnika')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:DJELATNIK.SetOpenRelated()
  Relate:DJELATNIK.Open                                    ! File DJELATNIK used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisDjelatnika',ProgressWindow)           ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:DJELATNIK, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:DJELATNIK.SetQuickScan(1,Propagate:OneMany)
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
    Relate:DJELATNIK.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisDjelatnika',ProgressWindow)        ! Save window data to non-volatile store
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
IspisJedinicaMjere PROCEDURE 

Progress:Thermometer BYTE                                  ! 
Process:View         VIEW(JEDINICA_MJERE)
                       PROJECT(JED:Naziv_jedinice_mjere)
                       PROJECT(JED:Sifra_jedinice_mjere)
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
                         STRING('Popis Jedinica Mjere'),AT(-10,-10,3823),USE(?STRING4),FONT(,27,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT)
                         IMAGE('Backgrounds\logo.png'),AT(3833,-10,2406,635),USE(?IMAGE1)
                         STRING('Datum Izvještaja:'),AT(31,708),USE(?ReportDatePrompt),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                         STRING('<<-- Date Stamp -->'),AT(1312,708),USE(?ReportDateStamp),FONT(,12,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),TRN
                       END
Detail                 DETAIL,AT(0,0,6250,687),USE(?Detail)
                         STRING(@s6),AT(1604,31),USE(JED:Sifra_jedinice_mjere,,?JED:Sifra_jedinice_mjere:3)
                         STRING(@s19),AT(1604,292),USE(JED:Naziv_jedinice_mjere)
                         STRING('Šifra Jedinice Mjere'),AT(31,31,1510),USE(?STRING1),FONT(,,,FONT:regular)
                         STRING('Naziv Jedinice Mjere'),AT(31,292,1510,198),USE(?STRING1:2),FONT(,,,FONT:regular)
                         LINE,AT(-197,573,6833,0),USE(?LINE1),COLOR(00400000h),LINEWIDTH(2)
                       END
                       FOOTER,AT(1000,9688,6250,635),USE(?Footer)
                         STRING(@s6),AT(781,2615),USE(JED:Sifra_jedinice_mjere)
                         STRING('Broj stranice:'),AT(2302,333,833,198),USE(?ReportDatePrompt:2),FONT(,,,FONT:regular+FONT:underline), |
  TRN
                         STRING(@N3),AT(3219,333),USE(ReportPageNumber),FONT(,,,FONT:regular+FONT:underline)
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
  GlobalErrors.SetProcedureName('IspisJedinicaMjere')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Progress:Thermometer
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Relate:JEDINICA_MJERE.SetOpenRelated()
  Relate:JEDINICA_MJERE.Open                               ! File JEDINICA_MJERE used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(ProgressWindow)                                ! Open window
  Do DefineListboxStyle
  INIMgr.Fetch('IspisJedinicaMjere',ProgressWindow)        ! Restore window settings from non-volatile store
  ThisReport.Init(Process:View, Relate:JEDINICA_MJERE, ?Progress:PctText, Progress:Thermometer)
  ThisReport.AddSortOrder()
  SELF.AddItem(?Progress:Cancel,RequestCancelled)
  SELF.Init(ThisReport,Report,Previewer)
  ?Progress:UserString{PROP:Text} = ''
  Relate:JEDINICA_MJERE.SetQuickScan(1,Propagate:OneMany)
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
    Relate:JEDINICA_MJERE.Close
  END
  IF SELF.Opened
    INIMgr.Update('IspisJedinicaMjere',ProgressWindow)     ! Save window data to non-volatile store
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

