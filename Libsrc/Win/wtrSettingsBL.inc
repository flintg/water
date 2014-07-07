!Category(wtr)
!-----------------------------------------------------------------------
! Business Layor Class - wtrWaterSettingsBL.inc
!
! Include for water project settings business layer.
!-----------------------------------------------------------------------
OMIT('_EndOfInclude', _wtrSettingsBLPresent_)
_wtrSettingsBLPresent_    EQUATE(1)
!-----------------------------------------------------------------------
! Miscellaneous definitions required by class
!-----------------------------------------------------------------------


wtrStationQueue       QUEUE,TYPE
StationAbbr             CSTRING(20),NAME('StationAbbreviation')
StationName             CSTRING(256),NAME('StationName')
                      END
                      
!-----------------------------------------------------------------------
! Source constants
!-----------------------------------------------------------------------
STANDARD_PROFILE      EQUATE('%APPDATA%')
STANDARD_DATADIR      EQUATE('\N0FHG\Water')
!-----------------------------------------------------------------------
! Class specification
!-----------------------------------------------------------------------
wtrSettingsBL     CLASS,MODULE('wtrSettingsBL.clw'),TYPE,LINK('wtrSettingsBL.clw',_wtrLinkMode_),DLL(_wtrDllMode_)

!---------------------------------------
! Public properties - These values
! should be set before object is used.
!---------------------------------------

!---------------------------------------
! Private and protected properties
!---------------------------------------
stationQ            &wtrStationQueue,PROTECTED    ! Queue of saved stations
DataDir             CSTRING(256),PROTECTED        ! Data directory
ErrCode             LONG,PRIVATE                  ! Error code 
Err                 CSTRING(256),PRIVATE          ! Error text
ProfileDir          CSTRING(256),PROTECTED        ! User profile directory
!-----------------------------------------------------------------------
! Virtual methods  - Derived for proper processing
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! Public methods - Available for use by the user
!-----------------------------------------------------------------------
Construct           PROCEDURE()
Destruct            PROCEDURE()
GetError            PROCEDURE(), STRING
GetStationQueue     PROCEDURE(),*wtrStationQueue
InError             PROCEDURE(), LONG
Load                PROCEDURE()
Save                PROCEDURE(), LONG, PROC
!-----------------------------------------------------------------------
! Private methods - Internal, not to be used
!-----------------------------------------------------------------------
                  END
  _EndOfInclude_