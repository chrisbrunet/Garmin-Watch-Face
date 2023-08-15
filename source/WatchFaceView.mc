import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.ActivityMonitor;

class WatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var myStats = System.getSystemStats();
        var info = ActivityMonitor.getInfo();
        var today = Gregorian.info(Time.now(), Time.FORMAT_LONG);

        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var dateString = Lang.format(
            "$1$ $2$ $3$",
            [
                today.month,
                today.day,
                today.year
            ]
        );
        var weekDayString = Lang.format(
            "$1$",
            [
                today.day_of_week
            ]
        );
        var batteryString = myStats.battery.format("%d") + "%";
        var stepsString = info.steps.format("%d") + " Steps";

        var timeView = View.findDrawableById("TimeLabel") as Text;
        timeView.setText(timeString);

        var dateView = View.findDrawableById("DateLabel") as Text;
        dateView.setText(dateString);

        var weekDayView = View.findDrawableById("WeekDayLabel") as Text;
        weekDayView.setText(weekDayString);

        var batteryView = View.findDrawableById("BatteryLabel") as Text;
        batteryView.setText(batteryString);

        var stepsView = View.findDrawableById("StepsLabel") as Text;
        stepsView.setText(stepsString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
