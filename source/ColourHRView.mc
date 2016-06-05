using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ColourHRView extends Ui.DataField {

    function initialize() {
        DataField.initialize();
    }

    hidden var mHeartRate = 0;

    //! Set your layout here. Anytime the size of obscurity of
    //! the draw context is changed this will be called.
    function onLayout(dc) {
        var obscurityFlags = DataField.getObscurityFlags();

        // Top left quadrant so we'll use the top left layout
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

        // Top right quadrant so we'll use the top right layout
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

        // Bottom left quadrant so we'll use the bottom left layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

        // Bottom right quadrant so we'll use the bottom right layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            labelView.locY = labelView.locY - 22;
        	labelView.setJustification(Gfx.TEXT_JUSTIFY_RIGHT);
        	labelView.setColor(Gfx.COLOR_BLACK);

            var valueView = View.findDrawableById("value");
            valueView.locY = valueView.locY + 0;
            valueView.setFont(Gfx.FONT_NUMBER_MEDIUM);
        }

        View.findDrawableById("label").setText(Rez.Strings.label);
        return true;
    }

    //! The given info object contains all the current workout
    //! information. Calculate a value and save it locally in this method.
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        if (info.currentHeartRate != null)
        {
        	mHeartRate = info.currentHeartRate;
        }
    }

    //! Display the value you computed here. This will be called
    //! once a second when the data field is visible.
    function onUpdate(dc) {
        var bgColor = Gfx.COLOR_WHITE;
        var fgColor = Gfx.COLOR_BLACK;

        if( mHeartRate > 172)
        { 
        	bgColor = Gfx.COLOR_RED;
        }
        else if( mHeartRate > 159)
        {
        	bgColor = Gfx.COLOR_ORANGE;
        }
        else if( mHeartRate > 147)
        {
        	bgColor = Gfx.COLOR_YELLOW;
        }
        else if( mHeartRate > 135)
        {
        	bgColor = Gfx.COLOR_GREEN;
        }
        else if( mHeartRate > 123)
        {
        	bgColor = Gfx.COLOR_BLUE;
        }


        // Set the background color
        View.findDrawableById("Background").setColor(bgColor);

        // Set the foreground color and value
        var value = View.findDrawableById("value");
        value.setColor(fgColor);

        value.setText(mHeartRate.format("%d"));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
