print("Loading wind-wave.nas");

var title = "Wind-Wave Settings";

    #rgb values for panel, last value is maximum alpha for panel
    var rgb = [0.45, 0.63, 0.79, 1.0];

    ## create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar) allowfocus: 0
    var window = canvas.Window.new(size:[658,258], type:"dialog")
       .set('title',title)
       .clearFocus();

    #hide the panel window and set the showing flag to indicate it is not showing
    window.hide();
    setprop("/sim/gui/canvas/window[2]/showing", 0);

    # adding a canvas to the new window and setting up background colors/transparency
    var myCanvas = window.createCanvas().setColorBackground(rgb[0],rgb[1],rgb[2], rgb[3]);

    # creating the top-level/root group which will contain all other elements/group

    var root = myCanvas.createGroup();

    ####DISPLAYS####

# create a new vertical layout for the canvas
var vbox = canvas.VBoxLayout.new();
myCanvas.setLayout(vbox);


##################################################################################
#var wind_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});

var wind_label = root.createChild("text")
        .setText("Wind")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0,0,0,1)             # green, fully opaque
        .setAlignment("left-center") # how the text is aligned to where you place it
        .setTranslation(40, 10);     # where to place the text

#vbox.addItem(wind_label);

#create and fill a horizontal layout for the wind widgets
var windLayout = canvas.HBoxLayout.new();

var windDirectionLayout = canvas.VBoxLayout.new();

var wind_direction_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25)
  .setText("Direction");
windDirectionLayout.addItem(wind_direction_label);

var wind_direction_value = canvas.gui.widgets.LineEdit.new(root, canvas.style, {})
  .setFixedSize(75,25)
  .setText(sprintf("%.2f",getprop("/environment/wind-from-heading-deg")));
windDirectionLayout.addItem(wind_direction_value);

windLayout.addItem(windDirectionLayout);


var windSpeedLayout = canvas.VBoxLayout.new();

var wind_speed_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25)
  .setText("Speed");
windSpeedLayout.addItem(wind_speed_label);
var wind_speed_value = canvas.gui.widgets.LineEdit.new(root, canvas.style, {})
  .setFixedSize(75,25)
  .setText(sprintf("%.2f",getprop("/environment/wind-speed-kt")));
windSpeedLayout.addItem(wind_speed_value);

windLayout.addItem(windSpeedLayout);

var spacer = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25);
windLayout.addItem(spacer);

windLayout.addItem(spacer);


var wind_button = canvas.gui.widgets.Button.new(root, canvas.style, {})
	.setText("Apply")
	.setFixedSize(75, 35);
wind_button.listen("clicked", func {
  # add code here to react on click on button.
  gui.popupTip("Wind Direction: " ~ wind_direction_value.text() ~"\nWind Speed: " ~ wind_speed_value.text());
});
windLayout.addItem(wind_button);

#add the wind h-layout to the canvas v-layout
vbox.addItem(windLayout);



##################################################################################

var wave_label = root.createChild("text")
        .setText("Waves")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0,0,0,1)             # green, fully opaque
        .setAlignment("left-center") # how the text is aligned to where you place it
        .setTranslation(40, 130);     # where to place the text


#var wave_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
#  .setFixedSize(75,35)
#  .setText("Wave");
#vbox.addItem(wave_label);

#create and fill a horizontal layout for the wave widgets
var waveLayout = canvas.HBoxLayout.new();

var waveDirectionLayout = canvas.VBoxLayout.new();
var wave_direction_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25)
  .setText("Direction");
waveDirectionLayout.addItem(wave_direction_label);
var wave_direction_value = canvas.gui.widgets.LineEdit.new(root, canvas.style, {})
  .setFixedSize(75,25)
  .setText(sprintf("%.2f",getprop("fdm/jsbsim/hydro/environment/waves-from-deg")));


waveDirectionLayout.addItem(wave_direction_value);

waveLayout.addItem(waveDirectionLayout);

var waveAmplitudeLayout = canvas.VBoxLayout.new();
var wave_amplitude_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25)
  .setText("Amplitude");
waveAmplitudeLayout.addItem(wave_amplitude_label);
var wave_amplitude_value = canvas.gui.widgets.LineEdit.new(root, canvas.style, {})
  .setFixedSize(75,25)
  .setText(sprintf("%.2f",getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft")));
waveAmplitudeLayout.addItem(wave_amplitude_value);

waveLayout.addItem(waveAmplitudeLayout);

var waveLengthLayout = canvas.VBoxLayout.new();
var wave_length_label = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0})
  .setFixedSize(75,25)
  .setText("Length");
waveLengthLayout.addItem(wave_length_label);
var wave_length_value = canvas.gui.widgets.LineEdit.new(root, canvas.style, {})
  .setFixedSize(75,25)
  .setText(sprintf("%.2f",getprop("fdm/jsbsim/hydro/environment/wave-length-ft")));
waveLengthLayout.addItem(wave_length_value);

waveLayout.addItem(waveLengthLayout);



var wave_button = canvas.gui.widgets.Button.new(root, canvas.style, {})
	.setText("Apply")
	.setFixedSize(75, 35);
wave_button.listen("clicked", func {
  # add code here to react on click on button.
  gui.popupTip("Wave Direction: " ~ wave_direction_value.text() ~"\nWave Amplitude: " ~ wave_amplitude_value.text());
  setprop("fdm/jsbsim/hydro/environment/wave-amplitude-ft",wave_amplitude_value.text());
  setprop("fdm/jsbsim/hydro/environment/waves-from-deg",wave_direction_value.text());
  setprop("fdm/jsbsim/hydro/environment/wave-length-ft",wave_length_value.text());
});
waveLayout.addItem(wave_button);

#add the wave h-layout to the canvas v-layout
vbox.addItem(waveLayout);



    ###KICK OFF THE UPDATES###
    window.update();


var hide = func(){
     window.del();
}

var show = func(){
#    myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], 1);
    window.show();
}


# the del() function is the destructor of the Window which will be called upon termination (dialog closing)
# use this to do resource management
window.del = func()
{
  print("Cleaning up wind-wave window:",title,"\n");
# explanation for the call() technique at: http://wiki.flightgear.org/Object_oriented_programming_in_Nasal#Making_safer_base-class_calls
  window.clearFocus();
  print("Stopping the wind-wave timer");
#  timer.stop();
  window.hide();
#  call(canvas.window.del, [], me);

};



####UPDATE DISPLAYS####
var update = func(){


    #update wind indicator/data
#    wind_direction_value.setText(sprintf("%.2f",getprop("/environment/wind-from-heading-deg")));
#    wind_speed_value.setText(sprintf("%.2f",getprop("/environment/wind-speed-kt")));


#    wave_amplitude_value.setText(sprintf("%.2f",getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft")));
#    wave_frequency_value.setText(sprintf("%.2f",getprop("/fdm/jsbsim/hydro/environment/wave-length-ft")));


} #end of update function
