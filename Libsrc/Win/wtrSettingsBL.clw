                                  MEMBER()
!-----------------------------------------------------------------------
! Business Layor Class - wtrSettingsBL.clw
!
! Source for water project settings class
!
! This object is a generic object used to maintain a list of settings.
! This is a configuration file and is stored as an XML file.
!-----------------------------------------------------------------------
  INCLUDE('wtrSettingsBL.inc'),ONCE
  INCLUDE('xFiles.inc'), ONCE
  
  MAP
  END
!! -----------------------------------------------------------------------
!!! <summary>Allocate dynamic memory needed for class</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.Construct           PROCEDURE()
  CODE
  SELF.stationQ      &= NEW(wtrStationQueue)
  SELF.ProfileDir     = STANDARD_PROFILE
  SELF.DataDir        = SELF.ProfileDir & STANDARD_DATADIR
  
!! -----------------------------------------------------------------------
!!! <summary>Deallocate dynamic memory when class goes out of scope</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.Destruct            PROCEDURE()
  CODE
  DISPOSE(SELF.stationQ)

!! -----------------------------------------------------------------------
!!! <summary>Get reference to internal station queue</summary>
!!! <remarks>This should only be used by a supporting class and not
!!! directly by an application.</remarks>
!! -----------------------------------------------------------------------
wtrSettingsBL.GetStationQueue     PROCEDURE()
  CODE
  RETURN SELF.stationQ
  
!! -----------------------------------------------------------------------
!!! <summary>Load saved project settings</summary>
!!! <remarks>File paths are currently hard-coded. This should be changed
!!! to use equates, instead.</remarks>
!! -----------------------------------------------------------------------
wtrSettingsBL.Load                PROCEDURE()
xml             xFileXML
  CODE
  xml.Load(SELF.stationQ,SELF.DataDir&'\Stations.xml','SavedStations','Station')
  
!! -----------------------------------------------------------------------
!!! <summary>Save current project settings</summary>
!!! <remarks>File paths are currently hard-coded. This should be changed
!!! to use equates, instead.</remarks>
!! -----------------------------------------------------------------------
wtrSettingsBL.Save                PROCEDURE()
xml             xFileXML
curStationsFile CSTRING(256)
  CODE
  curStationsFile = SELF.DataDir&'\Stations.xml'
  IF NOT EXISTS(curStationsFile)
    CREATE(curStationsFile)
    IF ERRORCODE()
      SELF.ErrCode  = ERRORCODE()
      SELF.Err      = ERROR()
      RETURN SELF.ErrCode
    END
  END
  SELF.ErrCode    = xml.Save(SELF.stationQ,curStationsFile,'SavedStations','Station')
  SELF.Err        = xml.ErrorStr
  RETURN SELF.ErrCode
  
!! -----------------------------------------------------------------------
!!! <summary>Check for an error condition</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.InError             PROCEDURE()!,LONG
  CODE
  RETURN SELF.ErrCode
  
!! -----------------------------------------------------------------------
!!! <summary>Return error text</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.GetError            PROCEDURE()!,STRING
  CODE
  RETURN SELF.Err