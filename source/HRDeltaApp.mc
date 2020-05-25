using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Graphics;
using Toybox.System as System;


//0.2.7 
// Look at adding check that ANT payload is at least 2 long
// Maybe update to HRV version of code
//0.2.8
// updated ANT code again

var _mApp;

class HRDeltaApp extends App.AppBase {
	
	var mAntSensor; 
	var mAntID = 0;

    function initialize() {
        AppBase.initialize();
        $._mApp = Application.getApp();
        mAntID = $._mApp.getProperty("pAuxHRAntID");
        System.println("STARTED");
    }

    // onStart() is called on application start up
    function onStart(state) {
    	try {
            //Create the sensor object and open it
            mAntSensor = new AuxHRSensor(mAntID);
            mAntSensor.open();
        } catch(e instanceof Ant.UnableToAcquireChannelException) {
            System.println(e.getErrorMessage());
            mAntSensor = null;
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	mAntSensor.closeSensor();
    	return false;
    }

   
    //! Return the initial view of your application here
    function getInitialView() {
        return [ new HRDeltaView() ];
    }

}