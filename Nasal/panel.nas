print("Loading panel.nas");

var title = "Instruments";

    #rgb values for panel, last value is maximum alpha for panel
    var rgb = [0.45, 0.63, 0.79, 0.80];

    ## create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar) allowfocus: 0
    var window = canvas.Window.new(size:[258,1200], type:nil)
       .set('title',title)
       .clearFocus();

    #hide the panel window and set the showing flag to indicate it is not showing
    window.hide();
    setprop("/sim/gui/canvas/window[1]/showing", 0);

    # adding a canvas to the new window and setting up background colors/transparency
    var myCanvas = window.createCanvas().setColorBackground(rgb[0],rgb[1],rgb[2], 0);

    # creating the top-level/root group which will contain all other elements/group

    var root = myCanvas.createGroup();

    ####DISPLAYS####

    #Gyro Compass
    var filename = "Aircraft/Kathryn/Instruments/gyro.xml";
    var temp = io.read_properties(filename);
    var layers = temp.getValues().layers.layer;

    #create an image for the compass
    var child=root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/compass.png" )
        .setScale(1);
    child.setCenter(128,128);
    var compass = child;

   #create an image for the heading indicator
    var heading_indicator = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/heading_indicator.png" )
        .setScale(1.0)
        .setCenter(128,128);

   #create an image for the wind indicator on the compass
    var wind_indicator_compass = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/wind_indicator.png" )
        .setScale(1.0)
        .setCenter(128,128);


   #create an image for the course indicator
    var true_course_indicator = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/course_indicator.png" )
        .setScale(0.60)
        .setCenter(128,128)
        .setTranslation(50,50);

    var true_course_data = root.createChild("text")
        .setText("")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0.136,0.433,0.11,1)             # green, fully opaque
        .setAlignment("center-center") # how the text is aligned to where you place it
        .setTranslation(128, 143);     # where to place the text


    #show speed
    var groundspeed = root.createChild("text")
      .setText("")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,0,1)             # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 107);     # where to place the text




   #create an image for the vessel (used in sail indicator)
    var vessel = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/vessel.png" )
        .setScale(0.8)
        .setTranslation(108,270);

     var sail_jib_boom_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(50)             # font size (in texels) and font aspect ratio
      .setColor(0,0,0,0.2)         # black, 20% opaque
      .setAlignment("center-top")  # how the text is aligned to where you place it
      .setTranslation(126, 270);   # where to place the text

     var sail_jib_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(50)             # font size (in texels) and font aspect ratio
      .setColor(1,1,1,0.5)         # white, 50% opaque
      .setAlignment("center-top")  # how the text is aligned to where you place it
      .setTranslation(126, 270);   # where to place the text


     var sail_main_boom_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(50)             # font size (in texels) and font aspect ratio
      .setColor(0,0,0,0.2)         # black, 20% opaque
      .setAlignment("center-top")  # how the text is aligned to where you place it
      .setTranslation(126, 330);   # where to place the text

     var sail_main_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(50)             # font size (in texels) and font aspect ratio
      .setColor(1,1,1,0.5)         # white, 50% opaque
      .setAlignment("center-top")  # how the text is aligned to where you place it
      .setTranslation(126, 330);   # where to place the text




   #create an image for the anchor
    var anchor = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/anchor.png" )
        .setScale(.6)
        .setTranslation(96,300);

   #create an image for the grounding
    var ground = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/ground.png" )
        .setScale(.6)
        .setTranslation(136,300);



   #create an image for the wind indicator on hull diagram
    var wind_indicator = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/wind_indicator.png" )
        .setScale(0.75)
        .setCenter(128,128)
        .setTranslation(29,240);

    var wind_data = root.createChild("text")
        .setText("Wind\n0 : 0")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0,0,1,0.5)             # black, fully opaque
        .setAlignment("center-center") # how the text is aligned to where you place it
        .setTranslation(42, 425);     # where to place the text


   #create an image for the wave indicator
    var wave_indicator = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/wave_indicator.png" )
        .setScale(0.75)
        .setCenter(128,128)
        .setTranslation(29,240);

    var wave_data = root.createChild("text")
        .setText("Wave\n0 : 0")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0,0,1,0.5)             # black, fully opaque
        .setAlignment("center-center") # how the text is aligned to where you place it
        .setTranslation(204, 425);     # where to place the text


    #active sail label
    var active_sail_label = root.createChild("text")
        .setText("Active Sails")
        .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
        .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
        .setColor(0,0,0,1)             # black, fully opaque
        .setAlignment("center-top") # how the text is aligned to where you place it
        .setTranslation(128, 450);     # where to place the text

    #how many sails are we handling?
    var number_of_sails = getprop("surface-positions/sails/number-of-sails");

    #used later in update function to iterate through each sail for position and appearance
    var sails = setsize([], number_of_sails);

    #create indicators for sail selections in panel
    var sail_selections = setsize([], number_of_sails);
    for(var i=0; i<number_of_sails; i=i+1)
    { sails[i] = i;
      sail_selections[i] = root.createChild("text")
         .setText(i+1)
         .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
         .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
         .setColor(0,0,0,0.5)           # black, 50% opaque
         .setAlignment("center-center") # how the text is aligned to where you place it
         .setTranslation((i*20)+(127-(number_of_sails*10)), 480);   # where to place the text
    }

     #show rudder
     var rudder_label = root.createChild("text")
      .setText("Rudder\nP     |     |     |     |     |     S")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,0,1)             # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 530);     # where to place the text

     var rudder_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(40, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # green, 50% opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 550);     # where to place the text

     var rudder_value = root.createChild("text")
      .setText("")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(15, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 575);     # where to place the text



     #show heel angle
     var heel_label = root.createChild("text")
      .setText("Heel Degree\nP     |     |     |     |     |     S")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,0,1)             # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 610);     # where to place the text

     var heel_indicator = root.createChild("text")
      .setText("|")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(60, 1.5)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # green 50% opaque
      .setAlignment("center-bottom") # how the text is aligned to where you place it
      .setTranslation(128, 660);     # where to place the text

     var heel_value = root.createChild("text")
      .setText("")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(15, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 670);     # where to place the text


     #show pitch angle
     var pitch_label = root.createChild("text")
      .setText("Pitch Degree")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,0,1)             # black, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 725);     # where to place the text

     var pitch_indicator = root.createChild("text")
      .setText("stn -------- | -------- bow")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(20, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # blue 50% opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 755);     # where to place the text

     var pitch_value = root.createChild("text")
      .setText("")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(15, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # blue, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 775);     # where to place the text

    #Legend
      var legend_wind_text = root.createChild("text")
      .setText("^ Wind direction")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # blue, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 800);     # where to place the text

      var legend_course_text = root.createChild("text")
      .setText("^ True course")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0.136,0.433,0.11,1)
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 815);     # where to place the text

      var legend_heading_text = root.createChild("text")
      .setText("| Heading")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(1,0,0,0.5)           # blue, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 830);     # where to place the text



     #create an image for the texture
     var floatgear_logo = root.createChild("image")
        .setFile( "Aircraft/Kathryn/Instruments/FloatGear_logo.png" )
        .setScale(.4)
        .setTranslation(90,1100);

      var floatgear_text = root.createChild("text")
      .setText("FloatGear")
      .set("font", "LiberationFonts/LiberationSans-Bold.ttf")
      .setFontSize(12, 0.9)          # font size (in texels) and font aspect ratio
      .setColor(0,0,1,0.5)           # blue, fully opaque
      .setAlignment("center-center") # how the text is aligned to where you place it
      .setTranslation(128, 1190);     # where to place the text

    #adding a timer for updating the displays
    print("Making and starting the panel timer");
    var timer = maketimer(0.1, func update() );
    timer.start();

    #adding a timer for fading in and out
    print("Making and starting the fade timer");
    var fade_in_timer = maketimer(0.01, func panel_fade(0.03) );
    var fade_out_timer = maketimer(0.01, func panel_fade(-0.03) );




    ###KICK OFF THE UPDATES###
    window.update();

    var panel_fade = func(interval){
      var i = getprop("/sim/gui/canvas/window[1]/showing");
      i += interval;
      myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], i);
      setprop("/sim/gui/canvas/window[1]/showing", i);
    if(i > rgb[3] and interval > 0){
      fade_in_timer.stop();
      setprop("/sim/gui/canvas/window[1]/showing", 0.8);
      myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], rgb[3]);
    }
    if(i <= 0 and interval < 0){
      fade_out_timer.stop();
      window.hide();
      setprop("/sim/gui/canvas/window[1]/showing", 0);
      myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], 0);
    }
}

var hide = func(){
    fade_out_timer.start();
#    myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], 0);
}

var show = func(){
    myCanvas.setColorBackground(rgb[0],rgb[1],rgb[2], 0);
    window.show();
    fade_in_timer.start();
}


# the del() function is the destructor of the Window which will be called upon termination (dialog closing)
# use this to do resource management
window.del = func()
{
  print("Cleaning up window:",title,"\n");
# explanation for the call() technique at: http://wiki.flightgear.org/Object_oriented_programming_in_Nasal#Making_safer_base-class_calls

  print("Stopping the timer");
  timer.stop();

  call(canvas.window.del, [], me);
};



####UPDATE DISPLAYS####
var update = func(){

    #update compass
    var hdg=getprop("/orientation/heading-deg");
#    compass.setRotation(-hdg*D2R);
    heading_indicator.setRotation(hdg*D2R);

#print("SHIP HDG:" ~ hdg);

    #update groundspeed
    groundspeed.setText(sprintf("%.2f\nKts", getprop("/velocities/groundspeed-kt")));

    #update wind indicator/data
    var wind_deg=getprop("/environment/wind-from-heading-deg");
    var wind_kt=getprop("/environment/wind-speed-kt");

#print("-----------------------------------------------");
#print("WIND COMING FROM DEG:" ~ wind_deg);

    wind_indicator_compass.setRotation((wind_deg - 180)*D2R);

    #update the panel
    wind_indicator.setRotation((wind_deg - 180 - hdg)*D2R);
    wind_data.setText(sprintf("Wind\n%.0f : %.0f kts", wind_deg, wind_kt));

    #update wave indicator/data
    var wave=getprop("/fdm/jsbsim/hydro/environment/waves-from-deg");
    wave_indicator.setRotation((-wave - hdg)*D2R);
    #update wave data
    wave_data.setText(sprintf("Wave\n%.0f : ", wave));

    var true_course_deg = getprop("/orientation/track-deg");
    #rotate true course pointer on compass
    true_course_indicator.setRotation(true_course_deg * D2R);
    #update true course data display
    true_course_data.setText(sprintf("Deg\n%.2f", true_course_deg));



    #update jib reefing indicator
    var sail_jib_reef = 1 - getprop("/surface-positions/sails/sail[0]/sail-furl-reef");
    sail_jib_indicator.setScale(sail_jib_reef);
#    print("sail-jib-reef: " ~ getprop("/surface-positions/sails/sail[0]/sail-jib-reef"));


    #update jib boom angle indicator
    var sail_jib_boom_angle = getprop("/surface-positions/sails/sail[0]/sail-bearing-deg");
    sail_jib_boom_indicator.setRotation((-1 * sail_jib_boom_angle) * D2R);

    #update jib angle indicator
    var sail_jib_angle = getprop("/surface-positions/sails/sail[0]/sail-bearing-deg");
    sail_jib_indicator.setRotation((-1 * sail_jib_angle) * D2R);
#    print("sail-jib-angle: " ~ getprop("/surface-positions/sails/sail[0]/sail-jib-bearing-deg"));

    #update main reefing indicator
    var sail_main_reef = getprop("/surface-positions/sails/sail[1]/sail-reef-norm");
    sail_main_indicator.setScale(sail_main_reef);
#    print("sail-main-reef: " ~ getprop("/surface-positions/sails/sail[1]/sail-main-reef"));

    #update main boom angle indicator
    var sail_main_boom_angle = getprop("/surface-positions/sails/sail[1]/sail-bearing-deg");
    sail_main_boom_indicator.setRotation((-1 * sail_main_boom_angle) * D2R);

    #update main angle indicator
    var sail_main_angle = getprop("/surface-positions/sails/sail[1]/sail-bearing-deg");
    sail_main_indicator.setRotation((-1 * sail_main_angle) * D2R);
#    print("sail-bearing-deg: " ~ getprop("/surface-positions/sails/sail[1]/sail-bearing-deg"));

    #update anchor indicator
    if(getprop("/position/anchored")){
        anchor.set("fill", "rgba(255,255,255,1.0)");
    }
    else {
        anchor.set("fill", "rgba(255,255,255,0.0)");
    }

    #update ground indicator
    if(getprop("/position/aground")){
        ground.set("fill", "rgba(255,255,255,1.0)");
    }
    else {
        ground.set("fill", "rgba(255,255,255,0.0)");
    }

    #update sail sections
    for(i=0; i<number_of_sails; i=i+1)
    { var active = getprop("surface-positions/sails/sail["~i~"]/sail-selected");
      if(active){
        sail_selections[i].setColor(1,0,0,0.5);
      }
      else {
        sail_selections[i].setColor(0,0,0,0.5);
      }
    }

    #update rudder indicator
    var rudder_setting = 128 + 128 * -getprop("/fdm/jsbsim/fcs/rudder-cmd-norm");
    rudder_indicator.setText("|");
    rudder_indicator.setTranslation(rudder_setting, 550);
    rudder_value.setText(sprintf("%.3f", 30 * getprop("/fdm/jsbsim/fcs/rudder-pos-norm")));

    #update heel indicator
    var heel_setting = getprop("/fdm/jsbsim/hydro/hull/roll-deg");
    heel_value.setText(sprintf("%.3f", heel_setting));
    heel_indicator.setRotation(heel_setting*D2R);

    #update pitch indicator
    var pitch_setting = getprop("/fdm/jsbsim/hydro/hull/pitch-deg");
    pitch_value.setText(sprintf("%.3f", pitch_setting));
    pitch_indicator.setRotation(-pitch_setting*D2R);


    #UPDATE SAIL APPEARANCE ##########################################
    foreach(sail; sails){
      sail_handling.sail_tack(sail, hdg, wind_deg);
    }
} #end of update function
