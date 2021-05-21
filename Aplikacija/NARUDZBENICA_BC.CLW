  MEMBER('Narudzbenica.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('Narudzbenica_BC0.CLW')
Narudzbenica_BC0:DctInit             PROCEDURE()
Narudzbenica_BC0:DctKill             PROCEDURE()
Narudzbenica_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  Narudzbenica_BC0:DctInit
  Narudzbenica_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  Narudzbenica_BC0:DctKill

