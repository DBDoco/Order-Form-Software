   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('NARUDZBENICA_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('NARUDZBENICA001.CLW')
Main                   PROCEDURE   !
     END
   END

SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
NARUDZBENICA         FILE,DRIVER('TOPSPEED'),PRE(NAR),CREATE,BINDABLE,THREAD !                     
PK_BrojNarudzbenice      KEY(NAR:Broj_narudzbenice),NOCASE,OPT,PRIMARY !                     
VK_SifraRokaIsporuke     KEY(NAR:Sifra_roka_isporuke),DUP,NOCASE,OPT !                     
VK_SifraNacinaOtpreme    KEY(NAR:Sifra_nacina_otpreme),DUP,NOCASE,OPT !                     
VK_SifraPlacanja         KEY(NAR:Sifra_placanja),DUP,NOCASE,OPT !                     
Record                   RECORD,PRE()
Broj_narudzbenice           CSTRING(7)                     !                     
Datum_narudzbenice          DATE                           !                     
Sifra_roka_isporuke         CSTRING(7)                     !                     
Sifra_nacina_otpreme        CSTRING(7)                     !                     
Sifra_placanja              CSTRING(7)                     !                     
                         END
                     END                       

FIRMA                FILE,DRIVER('TOPSPEED'),PRE(FIR),CREATE,BINDABLE,THREAD !                     
VK_PostanskiBroj         KEY(FIR:Postanski_broj),DUP,NOCASE,OPT !                     
PK_MaticniBrojFirme      KEY(FIR:Maticni_broj_firme),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Maticni_broj_firme          CSTRING(8)                     !                     
Naziv_firme                 CSTRING(30)                    !                     
Adresa_firme                CSTRING(30)                    !                     
Postanski_broj              CSTRING(6)                     !                     
                         END
                     END                       

MJESTO               FILE,DRIVER('TOPSPEED'),PRE(MJE),CREATE,BINDABLE,THREAD !                     
PK_PostanskiBroj         KEY(MJE:Postanski_broj),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Postanski_broj              CSTRING(6)                     !                     
Naziv_mjesta                CSTRING(30)                    !                     
                         END
                     END                       

ROK_ISPORUKE         FILE,DRIVER('TOPSPEED'),PRE(ROK),CREATE,BINDABLE,THREAD !                     
PK_SifraRokaIsporuke     KEY(ROK:Sifra_roka_isporuke),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_roka_isporuke         CSTRING(7)                     !                     
Datum_roka_isporuke         DATE                           !                     
                         END
                     END                       

NACIN_OTPREME        FILE,DRIVER('TOPSPEED'),PRE(NAC),CREATE,BINDABLE,THREAD !                     
PK_SifraNacinaOtpreme    KEY(NAC:Sifra_nacina_otpreme),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_nacina_otpreme        CSTRING(7)                     !                     
Naziv_nacina_otpreme        CSTRING(20)                    !                     
                         END
                     END                       

PLACANJE             FILE,DRIVER('TOPSPEED'),PRE(PLA),CREATE,BINDABLE,THREAD !                     
PK_SifraPlacanja         KEY(PLA:Sifra_placanja),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_placanja              CSTRING(7)                     !                     
Nacin_placanja              CSTRING(20)                    !                     
                         END
                     END                       

DJELATNIK            FILE,DRIVER('TOPSPEED'),PRE(DJE),CREATE,BINDABLE,THREAD !                     
SK_OIB                   KEY(DJE:OIB),DUP,NOCASE,OPT       !                     
SK_Ime                   KEY(DJE:Ime_djelatnika),DUP,NOCASE,OPT !                     
PK_OIB                   KEY(DJE:OIB),NOCASE,OPT,PRIMARY   !                     
Record                   RECORD,PRE()
OIB                         CSTRING(12)                    !                     
Ime_djelatnika              CSTRING(20)                    !                     
                         END
                     END                       

ROBA                 FILE,DRIVER('TOPSPEED'),PRE(ROB),CREATE,BINDABLE,THREAD !                     
VK_SifraJediniceMjere    KEY(ROB:Sifra_jedinice_mjere),DUP,NOCASE,OPT !                     
PK_SifraRobe             KEY(ROB:Sifra_robe),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_robe                  CSTRING(7)                     !                     
Naziv_robe                  CSTRING(30)                    !                     
Cijena                      DECIMAL(7,2)                   !                     
Sifra_jedinice_mjere        CSTRING(7)                     !                     
                         END
                     END                       

JEDINICA_MJERE       FILE,DRIVER('TOPSPEED'),PRE(JED),CREATE,BINDABLE,THREAD !                     
PK_SifraJediniceMjere    KEY(JED:Sifra_jedinice_mjere),NOCASE,OPT,PRIMARY !                     
Record                   RECORD,PRE()
Sifra_jedinice_mjere        CSTRING(7)                     !                     
Naziv_jedinice_mjere        CSTRING(20)                    !                     
                         END
                     END                       

ULOGA                FILE,DRIVER('TOPSPEED'),PRE(ULO),CREATE,BINDABLE,THREAD !                     
PK_Uloga                 KEY(ULO:Broj_narudzbenice,ULO:Maticni_broj_firme),NOCASE,PRIMARY !                     
RK_Uloga                 KEY(ULO:Maticni_broj_firme,ULO:Broj_narudzbenice),DUP,NOCASE !                     
Record                   RECORD,PRE()
Broj_narudzbenice           CSTRING(7)                     !                     
Maticni_broj_firme          CSTRING(8)                     !                     
Dobavljac_narucitelj        CSTRING(16)                    !                     
                         END
                     END                       

STAVKE               FILE,DRIVER('TOPSPEED'),PRE(STA),CREATE,BINDABLE,THREAD !                     
PK_Stavke                KEY(STA:Redni_broj_stavke,STA:Broj_narudzbenice),NOCASE,OPT,PRIMARY !                     
VK_SifraRobe             KEY(STA:Sifra_robe),DUP,NOCASE,OPT !                     
Record                   RECORD,PRE()
Redni_broj_stavke           SHORT                          !                     
Broj_narudzbenice           CSTRING(7)                     !                     
Iznos                       SHORT                          !                     
Kolicina                    SHORT                          !                     
Sifra_robe                  CSTRING(7)                     !                     
                         END
                     END                       

POTPISUJE            FILE,DRIVER('TOPSPEED'),PRE(POT),CREATE,BINDABLE,THREAD !                     
PK_Potpisuje             KEY(POT:Redni_broj_potpisa,POT:Broj_narudzbenice),NOCASE,OPT,PRIMARY !                     
VK_OIB                   KEY(POT:OIB),DUP,NOCASE,OPT       !                     
Record                   RECORD,PRE()
Redni_broj_potpisa          SHORT                          !                     
Broj_narudzbenice           CSTRING(7)                     !                     
OIB                         CSTRING(12)                    !                     
                         END
                     END                       

!endregion

Access:NARUDZBENICA  &FileManager,THREAD                   ! FileManager for NARUDZBENICA
Relate:NARUDZBENICA  &RelationManager,THREAD               ! RelationManager for NARUDZBENICA
Access:FIRMA         &FileManager,THREAD                   ! FileManager for FIRMA
Relate:FIRMA         &RelationManager,THREAD               ! RelationManager for FIRMA
Access:MJESTO        &FileManager,THREAD                   ! FileManager for MJESTO
Relate:MJESTO        &RelationManager,THREAD               ! RelationManager for MJESTO
Access:ROK_ISPORUKE  &FileManager,THREAD                   ! FileManager for ROK_ISPORUKE
Relate:ROK_ISPORUKE  &RelationManager,THREAD               ! RelationManager for ROK_ISPORUKE
Access:NACIN_OTPREME &FileManager,THREAD                   ! FileManager for NACIN_OTPREME
Relate:NACIN_OTPREME &RelationManager,THREAD               ! RelationManager for NACIN_OTPREME
Access:PLACANJE      &FileManager,THREAD                   ! FileManager for PLACANJE
Relate:PLACANJE      &RelationManager,THREAD               ! RelationManager for PLACANJE
Access:DJELATNIK     &FileManager,THREAD                   ! FileManager for DJELATNIK
Relate:DJELATNIK     &RelationManager,THREAD               ! RelationManager for DJELATNIK
Access:ROBA          &FileManager,THREAD                   ! FileManager for ROBA
Relate:ROBA          &RelationManager,THREAD               ! RelationManager for ROBA
Access:JEDINICA_MJERE &FileManager,THREAD                  ! FileManager for JEDINICA_MJERE
Relate:JEDINICA_MJERE &RelationManager,THREAD              ! RelationManager for JEDINICA_MJERE
Access:ULOGA         &FileManager,THREAD                   ! FileManager for ULOGA
Relate:ULOGA         &RelationManager,THREAD               ! RelationManager for ULOGA
Access:STAVKE        &FileManager,THREAD                   ! FileManager for STAVKE
Relate:STAVKE        &RelationManager,THREAD               ! RelationManager for STAVKE
Access:POTPISUJE     &FileManager,THREAD                   ! FileManager for POTPISUJE
Relate:POTPISUJE     &RelationManager,THREAD               ! RelationManager for POTPISUJE

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\Narudzbenica.INI', NVD_INI)               ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

