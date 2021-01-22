$PBExportHeader$nvo_restclient.sru
forward
global type nvo_restclient from nvo_restclient_master
end type
end forward

global type nvo_restclient from nvo_restclient_master
event ue_retrieve_error ( long al_error )
end type
global nvo_restclient nvo_restclient

forward prototypes
public function long retrieve (datastore ds, string urlname)
public function long retrieve (datawindow dw, string urlname)
end prototypes

event ue_retrieve_error(long al_error);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**  	Object:				nvo_RESTClient
**		Type: 				User Object
**		Event Name:		ue_Retrieval_Error()
**		Brief Description: 	User Event that notifies the user of a RESTClient Retrieval error
**  	Parent: 				nvo_RESTClient_Master
**		Created by:			Govinda Lopez
**  	Date Created:		Jan/22/2021
**		Modified by:	
**		Date Modified:
**  	Description:			User Event that notifies the user of a RESTClient Retrieval error
**
**		Parameters:			LONG		al_error	// The error number
**           					
**		Returns:           	LONG		al_error
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************************************
//		Variable Declarations and Initialization
//************************************************************
STRING	ls_error		// Used to store the error message



//************************************************************
//		Logic of the Script
//************************************************************
// Choose the error message
CHOOSE CASE al_error
	CASE -1
		ls_error = "General error"
	CASE -2
		ls_error = "Invalid URL"
	CASE -3
		ls_error = "Cannot connect to the Internet"
	CASE -4
		ls_error = "Timed out"
	CASE -5
		ls_error = "Get token error"
	CASE -7
		ls_error = "Failed to automatically decompress the response body"
	CASE -10
		ls_error = "The token is invalid or has expired"
	CASE -15
		ls_error = "Unsupported character sets"
	CASE -16
		ls_error = "The JSON is not a plain JSON with two-level structure"
	CASE -17
		ls_error = "No data is inserted into the DataWindow because no key in the JSON matches any column name in it"
	CASE ELSE
		ls_error = "Undefined error message"
END CHOOSE

// Notify the user about the error message
MessageBox("Web API Retrieval Error", "[" + STRING(al_error) + "] " + ls_error)
end event

public function long retrieve (datastore ds, string urlname);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**  	Object:				nvo_RESTClient
**		Type: 				RESTClient
**		Function Name:	Retrieve(datastore ds, string urlname)
**		Brief Description: 	Retrieves data from a Web API and places the data into the datastore
**  	Parent: 				User Object
**		Created by:			Govinda Lopez
**  	Date Created:		Jan/22/2021
**		Modified by:	
**		Date Modified:
**  	Description:			Retrieves data from a Web API and places the data into the datastore
**
**		Parameters:			DATASTORE 	ds				// The datastore used to return data to
**								STRING			urlname		// The URL from which to retrieve the data from
**           					
**		Returns:           	LONG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************************************
//		Variable Declarations and Initialization
//************************************************************
// Used to catch the return value
LONG	ll_rtc



//************************************************************
//		Logic of the Script
//************************************************************
// Calling the ancestor script. This is done to get the Return value of the retrieval
ll_rtc = nvo_restclient_master::Retrieve(ds, urlname)

// Check if there was a retrieval error
IF ll_rtc < 0 THEN
	// Call the Retrieval Error User Event
	THIS.EVENT ue_Retrieve_Error(ll_rtc)
END IF

// Return the Return code
RETURN ll_rtc
end function

public function long retrieve (datawindow dw, string urlname);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**  	Object:				nvo_RESTClient
**		Type: 				RESTClient
**		Function Name:	Retrieve(datawindow dw, string urlname)
**		Brief Description: 	Retrieves data from a Web API and places the data into the datawindow
**  	Parent: 				User Object
**		Created by:			Govinda Lopez
**  	Date Created:		Jan/22/2021
**		Modified by:	
**		Date Modified:
**  	Description:			Retrieves data from a Web API and places the data into the datawindow
**
**		Parameters:			DATAWINDOW 	ds				// The datawindow used to return data to
**								STRING			urlname		// The URL from which to retrieve the data from
**           					
**		Returns:           	LONG
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************************************
//		Variable Declarations and Initialization
//************************************************************
// Used to catch the return value
LONG	ll_rtc



//************************************************************
//		Logic of the Script
//************************************************************
// Calling the ancestor script. This is done to get the Return value of the retrieval
ll_rtc = nvo_restclient_master::Retrieve(dw, urlname)

// Check if there was a retrieval error
IF ll_rtc < 0 THEN
	// Call the Retrieval Error User Event
	THIS.EVENT ue_Retrieve_Error(ll_rtc)
END IF

// Return the Return code
RETURN ll_rtc
end function

on nvo_restclient.create
call super::create
end on

on nvo_restclient.destroy
call super::destroy
end on

