$PBExportHeader$nvo_restclient_master.sru
forward
global type nvo_restclient_master from restclient
end type
end forward

global type nvo_restclient_master from restclient
end type
global nvo_restclient_master nvo_restclient_master

event constructor;//
end event

on nvo_restclient_master.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_restclient_master.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

