  MEMBER('Narudzbenica.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
Narudzbenica_BC0:DctInit    PROCEDURE()
Narudzbenica_BC0:DctKill    PROCEDURE()
Narudzbenica_BC0:FilesInit  PROCEDURE()
  END

Hide:Access:NARUDZBENICA CLASS(FileManager),TYPE           ! FileManager for NARUDZBENICA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:NARUDZBENICA CLASS(RelationManager),TYPE       ! RelationManager for NARUDZBENICA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FIRMA    CLASS(FileManager),TYPE               ! FileManager for FIRMA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:FIRMA    CLASS(RelationManager),TYPE           ! RelationManager for FIRMA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:MJESTO   CLASS(FileManager),TYPE               ! FileManager for MJESTO
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:MJESTO   CLASS(RelationManager),TYPE           ! RelationManager for MJESTO
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ROK_ISPORUKE CLASS(FileManager),TYPE           ! FileManager for ROK_ISPORUKE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:ROK_ISPORUKE CLASS(RelationManager),TYPE       ! RelationManager for ROK_ISPORUKE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:NACIN_OTPREME CLASS(FileManager),TYPE          ! FileManager for NACIN_OTPREME
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:NACIN_OTPREME CLASS(RelationManager),TYPE      ! RelationManager for NACIN_OTPREME
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:PLACANJE CLASS(FileManager),TYPE               ! FileManager for PLACANJE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:PLACANJE CLASS(RelationManager),TYPE           ! RelationManager for PLACANJE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:DJELATNIK CLASS(FileManager),TYPE              ! FileManager for DJELATNIK
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:DJELATNIK CLASS(RelationManager),TYPE          ! RelationManager for DJELATNIK
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ROBA     CLASS(FileManager),TYPE               ! FileManager for ROBA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:ROBA     CLASS(RelationManager),TYPE           ! RelationManager for ROBA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:JEDINICA_MJERE CLASS(FileManager),TYPE         ! FileManager for JEDINICA_MJERE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:JEDINICA_MJERE CLASS(RelationManager),TYPE     ! RelationManager for JEDINICA_MJERE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ULOGA    CLASS(FileManager),TYPE               ! FileManager for ULOGA
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:ULOGA    CLASS(RelationManager),TYPE           ! RelationManager for ULOGA
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:STAVKE   CLASS(FileManager),TYPE               ! FileManager for STAVKE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:STAVKE   CLASS(RelationManager),TYPE           ! RelationManager for STAVKE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:POTPISUJE CLASS(FileManager),TYPE              ! FileManager for POTPISUJE
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
ValidateFieldServer    PROCEDURE(UNSIGNED Id,BYTE HandleErrors),BYTE,PROC,DERIVED
                     END


Hide:Relate:POTPISUJE CLASS(RelationManager),TYPE          ! RelationManager for POTPISUJE
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:NARUDZBENICA &Hide:Access:NARUDZBENICA,AUTO,THREAD
_Hide:Relate:NARUDZBENICA &Hide:Relate:NARUDZBENICA,AUTO,THREAD
_Hide:Access:FIRMA   &Hide:Access:FIRMA,AUTO,THREAD
_Hide:Relate:FIRMA   &Hide:Relate:FIRMA,AUTO,THREAD
_Hide:Access:MJESTO  &Hide:Access:MJESTO,AUTO,THREAD
_Hide:Relate:MJESTO  &Hide:Relate:MJESTO,AUTO,THREAD
_Hide:Access:ROK_ISPORUKE &Hide:Access:ROK_ISPORUKE,AUTO,THREAD
_Hide:Relate:ROK_ISPORUKE &Hide:Relate:ROK_ISPORUKE,AUTO,THREAD
_Hide:Access:NACIN_OTPREME &Hide:Access:NACIN_OTPREME,AUTO,THREAD
_Hide:Relate:NACIN_OTPREME &Hide:Relate:NACIN_OTPREME,AUTO,THREAD
_Hide:Access:PLACANJE &Hide:Access:PLACANJE,AUTO,THREAD
_Hide:Relate:PLACANJE &Hide:Relate:PLACANJE,AUTO,THREAD
_Hide:Access:DJELATNIK &Hide:Access:DJELATNIK,AUTO,THREAD
_Hide:Relate:DJELATNIK &Hide:Relate:DJELATNIK,AUTO,THREAD
_Hide:Access:ROBA    &Hide:Access:ROBA,AUTO,THREAD
_Hide:Relate:ROBA    &Hide:Relate:ROBA,AUTO,THREAD
_Hide:Access:JEDINICA_MJERE &Hide:Access:JEDINICA_MJERE,AUTO,THREAD
_Hide:Relate:JEDINICA_MJERE &Hide:Relate:JEDINICA_MJERE,AUTO,THREAD
_Hide:Access:ULOGA   &Hide:Access:ULOGA,AUTO,THREAD
_Hide:Relate:ULOGA   &Hide:Relate:ULOGA,AUTO,THREAD
_Hide:Access:STAVKE  &Hide:Access:STAVKE,AUTO,THREAD
_Hide:Relate:STAVKE  &Hide:Relate:STAVKE,AUTO,THREAD
_Hide:Access:POTPISUJE &Hide:Access:POTPISUJE,AUTO,THREAD
_Hide:Relate:POTPISUJE &Hide:Relate:POTPISUJE,AUTO,THREAD


Narudzbenica_BC0:DctInit PROCEDURE()
  CODE
  _Hide:Access:NARUDZBENICA &= NEW(Hide:Access:NARUDZBENICA)
  _Hide:Relate:NARUDZBENICA &= NEW(Hide:Relate:NARUDZBENICA)
  _Hide:Access:FIRMA &= NEW(Hide:Access:FIRMA)
  _Hide:Relate:FIRMA &= NEW(Hide:Relate:FIRMA)
  _Hide:Access:MJESTO &= NEW(Hide:Access:MJESTO)
  _Hide:Relate:MJESTO &= NEW(Hide:Relate:MJESTO)
  _Hide:Access:ROK_ISPORUKE &= NEW(Hide:Access:ROK_ISPORUKE)
  _Hide:Relate:ROK_ISPORUKE &= NEW(Hide:Relate:ROK_ISPORUKE)
  _Hide:Access:NACIN_OTPREME &= NEW(Hide:Access:NACIN_OTPREME)
  _Hide:Relate:NACIN_OTPREME &= NEW(Hide:Relate:NACIN_OTPREME)
  _Hide:Access:PLACANJE &= NEW(Hide:Access:PLACANJE)
  _Hide:Relate:PLACANJE &= NEW(Hide:Relate:PLACANJE)
  _Hide:Access:DJELATNIK &= NEW(Hide:Access:DJELATNIK)
  _Hide:Relate:DJELATNIK &= NEW(Hide:Relate:DJELATNIK)
  _Hide:Access:ROBA &= NEW(Hide:Access:ROBA)
  _Hide:Relate:ROBA &= NEW(Hide:Relate:ROBA)
  _Hide:Access:JEDINICA_MJERE &= NEW(Hide:Access:JEDINICA_MJERE)
  _Hide:Relate:JEDINICA_MJERE &= NEW(Hide:Relate:JEDINICA_MJERE)
  _Hide:Access:ULOGA &= NEW(Hide:Access:ULOGA)
  _Hide:Relate:ULOGA &= NEW(Hide:Relate:ULOGA)
  _Hide:Access:STAVKE &= NEW(Hide:Access:STAVKE)
  _Hide:Relate:STAVKE &= NEW(Hide:Relate:STAVKE)
  _Hide:Access:POTPISUJE &= NEW(Hide:Access:POTPISUJE)
  _Hide:Relate:POTPISUJE &= NEW(Hide:Relate:POTPISUJE)
  Relate:NARUDZBENICA &= _Hide:Relate:NARUDZBENICA
  Relate:FIRMA &= _Hide:Relate:FIRMA
  Relate:MJESTO &= _Hide:Relate:MJESTO
  Relate:ROK_ISPORUKE &= _Hide:Relate:ROK_ISPORUKE
  Relate:NACIN_OTPREME &= _Hide:Relate:NACIN_OTPREME
  Relate:PLACANJE &= _Hide:Relate:PLACANJE
  Relate:DJELATNIK &= _Hide:Relate:DJELATNIK
  Relate:ROBA &= _Hide:Relate:ROBA
  Relate:JEDINICA_MJERE &= _Hide:Relate:JEDINICA_MJERE
  Relate:ULOGA &= _Hide:Relate:ULOGA
  Relate:STAVKE &= _Hide:Relate:STAVKE
  Relate:POTPISUJE &= _Hide:Relate:POTPISUJE


Narudzbenica_BC0:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:NARUDZBENICA.Init
  _Hide:Relate:FIRMA.Init
  _Hide:Relate:MJESTO.Init
  _Hide:Relate:ROK_ISPORUKE.Init
  _Hide:Relate:NACIN_OTPREME.Init
  _Hide:Relate:PLACANJE.Init
  _Hide:Relate:DJELATNIK.Init
  _Hide:Relate:ROBA.Init
  _Hide:Relate:JEDINICA_MJERE.Init
  _Hide:Relate:ULOGA.Init
  _Hide:Relate:STAVKE.Init
  _Hide:Relate:POTPISUJE.Init


Narudzbenica_BC0:DctKill PROCEDURE()
  CODE
  _Hide:Relate:NARUDZBENICA.Kill
  DISPOSE(_Hide:Relate:NARUDZBENICA)
  _Hide:Relate:FIRMA.Kill
  DISPOSE(_Hide:Relate:FIRMA)
  _Hide:Relate:MJESTO.Kill
  DISPOSE(_Hide:Relate:MJESTO)
  _Hide:Relate:ROK_ISPORUKE.Kill
  DISPOSE(_Hide:Relate:ROK_ISPORUKE)
  _Hide:Relate:NACIN_OTPREME.Kill
  DISPOSE(_Hide:Relate:NACIN_OTPREME)
  _Hide:Relate:PLACANJE.Kill
  DISPOSE(_Hide:Relate:PLACANJE)
  _Hide:Relate:DJELATNIK.Kill
  DISPOSE(_Hide:Relate:DJELATNIK)
  _Hide:Relate:ROBA.Kill
  DISPOSE(_Hide:Relate:ROBA)
  _Hide:Relate:JEDINICA_MJERE.Kill
  DISPOSE(_Hide:Relate:JEDINICA_MJERE)
  _Hide:Relate:ULOGA.Kill
  DISPOSE(_Hide:Relate:ULOGA)
  _Hide:Relate:STAVKE.Kill
  DISPOSE(_Hide:Relate:STAVKE)
  _Hide:Relate:POTPISUJE.Kill
  DISPOSE(_Hide:Relate:POTPISUJE)


Hide:Relate:NARUDZBENICA.Init PROCEDURE()
  CODE
  _Hide:Access:NARUDZBENICA.Init
  SELF.Init(Access:NARUDZBENICA,1)


Hide:Access:NARUDZBENICA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= NAR:Record
  SELF.FileNameValue = 'NARUDZBENICA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= NARUDZBENICA
  PARENT.Init
  Access:NARUDZBENICA &= SELF


Hide:Access:NARUDZBENICA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:NARUDZBENICA &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:NARUDZBENICA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(NARUDZBENICA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(NAR:PK_BrojNarudzbenice,'NAR:PK_BrojNarudzbenice',0)
    SELF.AddKey(NAR:VK_SifraRokaIsporuke,'NAR:VK_SifraRokaIsporuke',0)
    SELF.AddKey(NAR:VK_SifraNacinaOtpreme,'NAR:VK_SifraNacinaOtpreme',0)
    SELF.AddKey(NAR:VK_SifraPlacanja,'NAR:VK_SifraPlacanja',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:NARUDZBENICA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:ROK_ISPORUKE3 USHORT,AUTO
Save:NACIN_OTPREME4 USHORT,AUTO
Save:PLACANJE5     USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('NAR:Sifra_roka_isporuke')
    Save:ROK_ISPORUKE3 = Access:ROK_ISPORUKE.SaveFile()
    ROK:Sifra_roka_isporuke = NAR:Sifra_roka_isporuke
    ReturnValue = Access:ROK_ISPORUKE.TryFetch(ROK:PK_SifraRokaIsporuke)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'ROK_ISPORUKE')
      END
    END
    Access:ROK_ISPORUKE.RestoreFile(Save:ROK_ISPORUKE3)
  OF 4
    GlobalErrors.SetField('NAR:Sifra_nacina_otpreme')
    Save:NACIN_OTPREME4 = Access:NACIN_OTPREME.SaveFile()
    NAC:Sifra_nacina_otpreme = NAR:Sifra_nacina_otpreme
    ReturnValue = Access:NACIN_OTPREME.TryFetch(NAC:PK_SifraNacinaOtpreme)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'NACIN_OTPREME')
      END
    END
    Access:NACIN_OTPREME.RestoreFile(Save:NACIN_OTPREME4)
  OF 5
    GlobalErrors.SetField('NAR:Sifra_placanja')
    Save:PLACANJE5 = Access:PLACANJE.SaveFile()
    PLA:Sifra_placanja = NAR:Sifra_placanja
    ReturnValue = Access:PLACANJE.TryFetch(PLA:PK_SifraPlacanja)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'PLACANJE')
      END
    END
    Access:PLACANJE.RestoreFile(Save:PLACANJE5)
  END
  RETURN ReturnValue


Hide:Relate:NARUDZBENICA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ROK_ISPORUKE)

  SELF.AddRelation(Relate:NACIN_OTPREME)

  SELF.AddRelation(Relate:PLACANJE)

  SELF.AddRelation(Relate:ULOGA,RI:CASCADE,RI:CASCADE,ULO:PK_Uloga)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,ULO:Broj_narudzbenice)

  SELF.AddRelation(Relate:STAVKE,RI:CASCADE,RI:CASCADE,STA:PK_Stavke)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,STA:Broj_narudzbenice)

  SELF.AddRelation(Relate:POTPISUJE,RI:CASCADE,RI:CASCADE,POT:PK_Potpisuje)
  SELF.AddRelationLink(NAR:Broj_narudzbenice,POT:Broj_narudzbenice)


Hide:Relate:NARUDZBENICA.Kill PROCEDURE

  CODE
  _Hide:Access:NARUDZBENICA.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:NARUDZBENICA &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:NARUDZBENICA)                       ! destroy the file manager


Hide:Relate:FIRMA.Init PROCEDURE()
  CODE
  _Hide:Access:FIRMA.Init
  SELF.Init(Access:FIRMA,1)


Hide:Access:FIRMA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= FIR:Record
  SELF.FileNameValue = 'FIRMA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FIRMA
  PARENT.Init
  Access:FIRMA &= SELF


Hide:Access:FIRMA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FIRMA &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FIRMA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FIRMA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(FIR:VK_PostanskiBroj,'FIR:VK_PostanskiBroj',0)
    SELF.AddKey(FIR:PK_MaticniBrojFirme,'FIR:PK_MaticniBrojFirme',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:FIRMA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:MJESTO4       USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 4
    GlobalErrors.SetField('FIR:Postanski_broj')
    Save:MJESTO4 = Access:MJESTO.SaveFile()
    MJE:Postanski_broj = FIR:Postanski_broj
    ReturnValue = Access:MJESTO.TryFetch(MJE:PK_PostanskiBroj)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'MJESTO')
      END
    END
    Access:MJESTO.RestoreFile(Save:MJESTO4)
  END
  RETURN ReturnValue


Hide:Relate:FIRMA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:MJESTO)

  SELF.AddRelation(Relate:ULOGA,RI:CASCADE,RI:CASCADE,ULO:RK_Uloga)
  SELF.AddRelationLink(FIR:Maticni_broj_firme,ULO:Maticni_broj_firme)


Hide:Relate:FIRMA.Kill PROCEDURE

  CODE
  _Hide:Access:FIRMA.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:FIRMA &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FIRMA)                              ! destroy the file manager


Hide:Relate:MJESTO.Init PROCEDURE()
  CODE
  _Hide:Access:MJESTO.Init
  SELF.Init(Access:MJESTO,1)


Hide:Access:MJESTO.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= MJE:Record
  SELF.FileNameValue = 'MJESTO'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= MJESTO
  PARENT.Init
  Access:MJESTO &= SELF


Hide:Access:MJESTO.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:MJESTO &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:MJESTO.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(MJESTO,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(MJE:PK_PostanskiBroj,'MJE:PK_PostanskiBroj',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:MJESTO.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:FIRMA,RI:CASCADE,RI:RESTRICT,FIR:VK_PostanskiBroj)
  SELF.AddRelationLink(MJE:Postanski_broj,FIR:Postanski_broj)


Hide:Relate:MJESTO.Kill PROCEDURE

  CODE
  _Hide:Access:MJESTO.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:MJESTO &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:MJESTO)                             ! destroy the file manager


Hide:Relate:ROK_ISPORUKE.Init PROCEDURE()
  CODE
  _Hide:Access:ROK_ISPORUKE.Init
  SELF.Init(Access:ROK_ISPORUKE,1)


Hide:Access:ROK_ISPORUKE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ROK:Record
  SELF.FileNameValue = 'ROK_ISPORUKE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ROK_ISPORUKE
  PARENT.Init
  Access:ROK_ISPORUKE &= SELF


Hide:Access:ROK_ISPORUKE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ROK_ISPORUKE &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ROK_ISPORUKE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ROK_ISPORUKE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ROK:PK_SifraRokaIsporuke,'ROK:PK_SifraRokaIsporuke',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:ROK_ISPORUKE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA,RI:CASCADE,RI:RESTRICT,NAR:VK_SifraRokaIsporuke)
  SELF.AddRelationLink(ROK:Sifra_roka_isporuke,NAR:Sifra_roka_isporuke)


Hide:Relate:ROK_ISPORUKE.Kill PROCEDURE

  CODE
  _Hide:Access:ROK_ISPORUKE.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:ROK_ISPORUKE &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ROK_ISPORUKE)                       ! destroy the file manager


Hide:Relate:NACIN_OTPREME.Init PROCEDURE()
  CODE
  _Hide:Access:NACIN_OTPREME.Init
  SELF.Init(Access:NACIN_OTPREME,1)


Hide:Access:NACIN_OTPREME.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= NAC:Record
  SELF.FileNameValue = 'NACIN_OTPREME'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= NACIN_OTPREME
  PARENT.Init
  Access:NACIN_OTPREME &= SELF


Hide:Access:NACIN_OTPREME.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:NACIN_OTPREME &= NULL                             ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:NACIN_OTPREME.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(NACIN_OTPREME,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(NAC:PK_SifraNacinaOtpreme,'NAC:PK_SifraNacinaOtpreme',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:NACIN_OTPREME.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA,RI:CASCADE,RI:RESTRICT,NAR:VK_SifraNacinaOtpreme)
  SELF.AddRelationLink(NAC:Sifra_nacina_otpreme,NAR:Sifra_nacina_otpreme)


Hide:Relate:NACIN_OTPREME.Kill PROCEDURE

  CODE
  _Hide:Access:NACIN_OTPREME.Kill                          ! Kill the file manager
  PARENT.Kill
  Relate:NACIN_OTPREME &= NULL                             ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:NACIN_OTPREME)                      ! destroy the file manager


Hide:Relate:PLACANJE.Init PROCEDURE()
  CODE
  _Hide:Access:PLACANJE.Init
  SELF.Init(Access:PLACANJE,1)


Hide:Access:PLACANJE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= PLA:Record
  SELF.FileNameValue = 'PLACANJE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= PLACANJE
  PARENT.Init
  Access:PLACANJE &= SELF


Hide:Access:PLACANJE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:PLACANJE &= NULL                                  ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:PLACANJE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(PLACANJE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(PLA:PK_SifraPlacanja,'PLA:PK_SifraPlacanja',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:PLACANJE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA,RI:CASCADE,RI:RESTRICT,NAR:VK_SifraPlacanja)
  SELF.AddRelationLink(PLA:Sifra_placanja,NAR:Sifra_placanja)


Hide:Relate:PLACANJE.Kill PROCEDURE

  CODE
  _Hide:Access:PLACANJE.Kill                               ! Kill the file manager
  PARENT.Kill
  Relate:PLACANJE &= NULL                                  ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:PLACANJE)                           ! destroy the file manager


Hide:Relate:DJELATNIK.Init PROCEDURE()
  CODE
  _Hide:Access:DJELATNIK.Init
  SELF.Init(Access:DJELATNIK,1)


Hide:Access:DJELATNIK.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= DJE:Record
  SELF.FileNameValue = 'DJELATNIK'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= DJELATNIK
  PARENT.Init
  Access:DJELATNIK &= SELF


Hide:Access:DJELATNIK.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DJELATNIK &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:DJELATNIK.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(DJELATNIK,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(DJE:SK_OIB,'DJE:SK_OIB',0)
    SELF.AddKey(DJE:SK_Ime,'DJE:SK_Ime',0)
    SELF.AddKey(DJE:PK_OIB,'DJE:PK_OIB',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:DJELATNIK.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:POTPISUJE,RI:CASCADE,RI:RESTRICT,POT:VK_OIB)
  SELF.AddRelationLink(DJE:OIB,POT:OIB)


Hide:Relate:DJELATNIK.Kill PROCEDURE

  CODE
  _Hide:Access:DJELATNIK.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:DJELATNIK &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:DJELATNIK)                          ! destroy the file manager


Hide:Relate:ROBA.Init PROCEDURE()
  CODE
  _Hide:Access:ROBA.Init
  SELF.Init(Access:ROBA,1)


Hide:Access:ROBA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ROB:Record
  SELF.FileNameValue = 'ROBA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ROBA
  PARENT.Init
  Access:ROBA &= SELF


Hide:Access:ROBA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ROBA &= NULL                                      ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ROBA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ROBA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ROB:VK_SifraJediniceMjere,'ROB:VK_SifraJediniceMjere',0)
    SELF.AddKey(ROB:PK_SifraRobe,'ROB:PK_SifraRobe',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:ROBA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:JEDINICA_MJERE4 USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 4
    GlobalErrors.SetField('ROB:Sifra_jedinice_mjere')
    Save:JEDINICA_MJERE4 = Access:JEDINICA_MJERE.SaveFile()
    JED:Sifra_jedinice_mjere = ROB:Sifra_jedinice_mjere
    ReturnValue = Access:JEDINICA_MJERE.TryFetch(JED:PK_SifraJediniceMjere)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'JEDINICA_MJERE')
      END
    END
    Access:JEDINICA_MJERE.RestoreFile(Save:JEDINICA_MJERE4)
  END
  RETURN ReturnValue


Hide:Relate:ROBA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:JEDINICA_MJERE)

  SELF.AddRelation(Relate:STAVKE,RI:CASCADE,RI:RESTRICT,STA:VK_SifraRobe)
  SELF.AddRelationLink(ROB:Sifra_robe,STA:Sifra_robe)


Hide:Relate:ROBA.Kill PROCEDURE

  CODE
  _Hide:Access:ROBA.Kill                                   ! Kill the file manager
  PARENT.Kill
  Relate:ROBA &= NULL                                      ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ROBA)                               ! destroy the file manager


Hide:Relate:JEDINICA_MJERE.Init PROCEDURE()
  CODE
  _Hide:Access:JEDINICA_MJERE.Init
  SELF.Init(Access:JEDINICA_MJERE,1)


Hide:Access:JEDINICA_MJERE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= JED:Record
  SELF.FileNameValue = 'JEDINICA_MJERE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= JEDINICA_MJERE
  PARENT.Init
  Access:JEDINICA_MJERE &= SELF


Hide:Access:JEDINICA_MJERE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:JEDINICA_MJERE &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:JEDINICA_MJERE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(JEDINICA_MJERE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(JED:PK_SifraJediniceMjere,'JED:PK_SifraJediniceMjere',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:JEDINICA_MJERE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ROBA,RI:CASCADE,RI:RESTRICT,ROB:VK_SifraJediniceMjere)
  SELF.AddRelationLink(JED:Sifra_jedinice_mjere,ROB:Sifra_jedinice_mjere)


Hide:Relate:JEDINICA_MJERE.Kill PROCEDURE

  CODE
  _Hide:Access:JEDINICA_MJERE.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:JEDINICA_MJERE &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:JEDINICA_MJERE)                     ! destroy the file manager


Hide:Relate:ULOGA.Init PROCEDURE()
  CODE
  _Hide:Access:ULOGA.Init
  SELF.Init(Access:ULOGA,1)


Hide:Access:ULOGA.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= ULO:Record
  SELF.FileNameValue = 'ULOGA'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= ULOGA
  PARENT.Init
  Access:ULOGA &= SELF


Hide:Access:ULOGA.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ULOGA &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:ULOGA.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(ULOGA,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(ULO:PK_Uloga,'ULO:PK_Uloga',0)
    SELF.AddKey(ULO:RK_Uloga,'ULO:RK_Uloga',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:ULOGA.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:NARUDZBENICA1 USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 1
    GlobalErrors.SetField('ULO:Broj_narudzbenice')
    Save:NARUDZBENICA1 = Access:NARUDZBENICA.SaveFile()
    NAR:Broj_narudzbenice = ULO:Broj_narudzbenice
    ReturnValue = Access:NARUDZBENICA.TryFetch(NAR:PK_BrojNarudzbenice)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'NARUDZBENICA')
      END
    END
    Access:NARUDZBENICA.RestoreFile(Save:NARUDZBENICA1)
  END
  RETURN ReturnValue


Hide:Relate:ULOGA.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:NARUDZBENICA)

  SELF.AddRelation(Relate:FIRMA)


Hide:Relate:ULOGA.Kill PROCEDURE

  CODE
  _Hide:Access:ULOGA.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:ULOGA &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:ULOGA)                              ! destroy the file manager


Hide:Relate:STAVKE.Init PROCEDURE()
  CODE
  _Hide:Access:STAVKE.Init
  SELF.Init(Access:STAVKE,1)


Hide:Access:STAVKE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= STA:Record
  SELF.FileNameValue = 'STAVKE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= STAVKE
  PARENT.Init
  Access:STAVKE &= SELF


Hide:Access:STAVKE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:STAVKE &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:STAVKE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(STAVKE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(STA:PK_Stavke,'STA:PK_Stavke',2)
    SELF.AddKey(STA:VK_SifraRobe,'STA:VK_SifraRobe',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:STAVKE.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:ROBA5         USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 5
    GlobalErrors.SetField('STA:Sifra_robe')
    Save:ROBA5 = Access:ROBA.SaveFile()
    ROB:Sifra_robe = STA:Sifra_robe
    ReturnValue = Access:ROBA.TryFetch(ROB:PK_SifraRobe)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'ROBA')
      END
    END
    Access:ROBA.RestoreFile(Save:ROBA5)
  END
  RETURN ReturnValue


Hide:Relate:STAVKE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ROBA)

  SELF.AddRelation(Relate:NARUDZBENICA)


Hide:Relate:STAVKE.Kill PROCEDURE

  CODE
  _Hide:Access:STAVKE.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:STAVKE &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:STAVKE)                             ! destroy the file manager


Hide:Relate:POTPISUJE.Init PROCEDURE()
  CODE
  _Hide:Access:POTPISUJE.Init
  SELF.Init(Access:POTPISUJE,1)


Hide:Access:POTPISUJE.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= POT:Record
  SELF.FileNameValue = 'POTPISUJE'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= POTPISUJE
  PARENT.Init
  Access:POTPISUJE &= SELF


Hide:Access:POTPISUJE.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:POTPISUJE &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:POTPISUJE.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(POTPISUJE,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(POT:PK_Potpisuje,'POT:PK_Potpisuje',2)
    SELF.AddKey(POT:VK_OIB,'POT:VK_OIB',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Access:POTPISUJE.ValidateFieldServer PROCEDURE(UNSIGNED Id,BYTE HandleErrors)

ReturnValue          BYTE,AUTO

Save:DJELATNIK3    USHORT,AUTO
  CODE
  ReturnValue = PARENT.ValidateFieldServer(Id,HandleErrors)
  CASE Id
  OF 3
    GlobalErrors.SetField('POT:OIB')
    Save:DJELATNIK3 = Access:DJELATNIK.SaveFile()
    DJE:OIB = POT:OIB
    ReturnValue = Access:DJELATNIK.TryFetch(DJE:PK_OIB)
    IF ReturnValue <> Level:Benign
      IF HandleErrors                                      ! Display message if handling errors
        ReturnValue = GlobalErrors.ThrowMessage(Msg:FieldNotInFile,'DJELATNIK')
      END
    END
    Access:DJELATNIK.RestoreFile(Save:DJELATNIK3)
  END
  RETURN ReturnValue


Hide:Relate:POTPISUJE.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:DJELATNIK)

  SELF.AddRelation(Relate:NARUDZBENICA)


Hide:Relate:POTPISUJE.Kill PROCEDURE

  CODE
  _Hide:Access:POTPISUJE.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:POTPISUJE &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:POTPISUJE)                          ! destroy the file manager

