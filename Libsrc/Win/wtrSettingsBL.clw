                                  MEMBER()
                                  pragma('link(CLAWE.Lib)')
!-----------------------------------------------------------------------
! Business Layor Class - wtrSettingsBL.clw
!
! Source for water project settings class
!
! This object is a generic object used to maintain a list of settings.
! This is a configuration file and is stored as an XML file.!
!
! The following are added to the project:
!   * CLAWE.Lib - CapeSoft WinEvent
!-----------------------------------------------------------------------
  INCLUDE('wtrSettingsBL.inc'),ONCE
  INCLUDE('xFiles.inc'), ONCE
  INCLUDE('EventEqu.clw'), ONCE
  
  MAP
    INCLUDE('EventMap.clw'), ONCE
  END
!! -----------------------------------------------------------------------
!!! <summary>Allocate dynamic memory needed for class</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.Construct           PROCEDURE()
  CODE
  SELF.stationQ      &= NEW(wtrStationQueue)
  SELF.ProfileDir     = ds_GetFolderPath(WE::CSIDL_APPDATA)
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
!!! <returns>Error code encountered during save. 0 = No error.</returns>
!! -----------------------------------------------------------------------
wtrSettingsBL.Save                PROCEDURE()
xml             xFileXML
curStationsFile CSTRING(256)
  CODE
  curStationsFile = SELF.DataDir&'\Stations.xml'
  SELF.ErrCode    = xml.Save(SELF.stationQ,curStationsFile,'SavedStations','Station')
  SELF.Err        = xml.ErrorStr
  RETURN SELF.ErrCode
  
!! -----------------------------------------------------------------------
!!! <summary>Check for an error condition</summary>
!!! <returns>Current error code</returns>
!! -----------------------------------------------------------------------
wtrSettingsBL.InError             PROCEDURE()!,LONG
  CODE
  RETURN SELF.ErrCode
  
!! -----------------------------------------------------------------------
!!! <summary>Return error text</summary>
!!! <returns>Current error text</returns>
!! -----------------------------------------------------------------------
wtrSettingsBL.GetError            PROCEDURE()!,STRING
  CODE
  RETURN SELF.Err