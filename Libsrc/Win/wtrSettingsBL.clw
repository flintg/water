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
!! -----------------------------------------------------------------------
!!! <summary>Allocate dynamic memory needed for class</summary>
!! -----------------------------------------------------------------------
wtrSettingsBL.Construct           PROCEDURE()
  CODE
  SELF.stationQ      &= NEW(wtrStationQueue)
  
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
  xml.Load(SELF.stationQ,'.\Stations.xml','SavedStations','Station')
  
!! -----------------------------------------------------------------------
!!! <summary>Save current project settings</summary>
!!! <remarks>File paths are currently hard-coded. This should be changed
!!! to use equates, instead.</remarks>
!! -----------------------------------------------------------------------
wtrSettingsBL.Save                PROCEDURE()
xml             xFileXML
  CODE
  SELF.ErrCode = xml.Save(SELF.stationQ,'.\Stations.xml','SavedStations','Station')
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