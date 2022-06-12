PROGRAM test_output_module_stn
!
! Modules
  USE CPT_formatV11
!
! Implicit declarations
  IMPLICIT NONE
!
! Parameters
  INTEGER, PARAMETER :: iin=11    ! - input unit number -
  INTEGER, PARAMETER :: nv= 6     ! - number of stations -
  INTEGER, PARAMETER :: nt=10     ! - number of years -
  INTEGER, PARAMETER :: iyr1=1960 ! - first year -
  INTEGER, PARAMETER :: imn1=1    ! - first month -
  INTEGER, PARAMETER :: idy1=0    ! - first day -
!
  REAL, PARAMETER :: rmiss=-2. ! - missing values -
!
! Scalar
  INTEGER :: i     ! - station index -
  INTEGER :: k     ! - year index -
  INTEGER :: ifail ! - error indicator -
!
  CHARACTER(LEN=512) :: ctag ! - CPT tag -
!
! Arrays
  REAL, DIMENSION(nv,nt) :: x ! - data -
  REAL, DIMENSION(nv) :: rlat ! - latitudes -
  REAL, DIMENSION(nv) :: rlng ! - longitudes -
!
  CHARACTER(LEN= 16), DIMENSION(nv) :: cstn ! - station names -
!
! Executable Statements
!
! Read index file
  OPEN (UNIT=iin,FILE='Example_stn.tsv',ACTION='read',FORM='formatted',STATUS='old')
! - read the names of the stations -
  READ (UNIT=iin,FMT=*) (cstn(i),i=1,nv)
! - read latitudes and longitudes -
  READ (UNIT=iin,FMT='(A)') ctag
  IF (INDEX(ctag,'cpt:X')>0) THEN
     BACKSPACE (UNIT=iin)
     READ (UNIT=iin,FMT=*) ctag,(rlng(i),i=1,nv)
     READ (UNIT=iin,FMT=*) ctag,(rlat(i),i=1,nv)
  ELSE IF (INDEX(ctag,'cpt:Y')>0) THEN
     BACKSPACE (UNIT=iin)
     READ (UNIT=iin,FMT=*) ctag,(rlat(i),i=1,nv)
     READ (UNIT=iin,FMT=*) ctag,(rlng(i),i=1,nv)
  END IF
! - read the data -
  DO k=1,nt
     READ (UNIT=iin,FMT=*) ctag,(x(i,k),i=1,nv)
  END DO
  CLOSE (UNIT=iin)
!
! Output data
  CALL write_cpt_stns_v11 ('CPT_stn.txt',nv,nt,1,x,rmiss,rlat,rlng,cstn,'rain','mm', &
                           iyr1,imn1,idy1,iyr1,imn1,idy1,ifail)
  PRINT *, ifail
END PROGRAM test_output_module_stn
