#sail graphic functions
print("Loading Sail_Handling.nas");

var active_sails = getprop("surface-positions/sails/number-of-sails");

#scales sails  when deploying or reefing
var deploy_sails = func(direction){

  for(var i=0; i < active_sails; i = i+1){
      if(getprop("surface-positions/sails/sail["~i~"]/sail-selected") == 1)
      {
        var current = getprop("surface-positions/sails/sail["~i~"]/sail-reef-norm") + direction;

        if(current >  1){current = 1;}
        else if(current < 0){current = 0;}

        setprop("surface-positions/sails/sail["~i~"]/sail-reef-norm", current);

        #get the inverse of the reef in order to display/hide the furled sail in opposition to the sail sheet
        var furled = 1 - getprop("surface-positions/sails/sail["~i~"]/sail-reef-norm");
        setprop("surface-positions/sails/sail["~i~"]/sail-furl-reef", furled);

      } # end of if selected
  } # end of for each sail loop
} #end of deploy_sails function

#rotates sails when trimming direction
var trim_sails = func(direction){

  for(var i=0; i < active_sails; i = i+1){

    #set bearing trim (used by external forces)
    setprop("surface-positions/sails/sail["~i~"]/sail-bearing-norm",
      getprop("surface-positions/sails/sail["~i~"]/sail-bearing-deg")/getprop("surface-positions/sails/sail["~i~"]/sail-trim-max")
    );

    if(getprop("surface-positions/sails/sail["~i~"]/sail-selected") == 1)
    {
       var current = getprop("surface-positions/sails/sail["~i~"]/sail-bearing-deg") + direction;
       var max = getprop("surface-positions/sails/sail["~i~"]/sail-trim-max");

       if(current >  max){current = max;}
       else if(current < -max){current = -max;}

       setprop("surface-positions/sails/sail["~i~"]/sail-bearing-deg", current);

    } # end of if selected
  } # end of for loop
} #end of trim_sails function



# Dispatches sail to either square sail or stay sail tacking routines
sail_tack = func(sail, hdg, wind_deg){

    #dispatch the sail to the square/stay sail tacking routines
    if(getprop("surface-positions/sails/sail["~sail~"]/sail-type") == "square")
      {square_sail_tack(sail, hdg, wind_deg)}
      else
      {stay_sail_tack(sail, hdg, wind_deg)};

} # end of sail_tack function


#UPDATE SAIL APPEARANCE ##########################################
square_sail_tack = func(sail, hdg, wind_deg){

    #Determine the degree the sail is facing (bearing is based on bow of ship being zero)
    var sail_facing = getprop("surface-positions/sails/sail["~sail~"]/sail-bearing-deg");

    #adjust for boom_deg being 180+/- on either side instead of 360 around
    if(sail_facing < 0)
      {sail_facing = 360 - math.abs(sail_facing)}

    #offset sail facing by the number of degrees hdg has rotated and its type offset (square sails are rotated 90 degrees to start with)
    if(hdg < sail_facing)
      {sail_facing = sail_facing + hdg}
    else
      {sail_facing = sail_facing - (360 - hdg)};
    if(sail_facing > 360)
      {sail_facing = sail_facing - 360};
    #at this point both ship heading (hdg) and sail facing (sail_facing) are 0 to 360

    #difference between sail facing and wind degree
    var diff = math.mod((wind_deg - sail_facing), 360); #normDeg = mod(a-b,360);
        diff = math.min(360 - diff, diff);              # absDiffDeg = min(360-normDeg, normDeg);

    #determine whether to show port or stbd sail set depending on which side of sail facing the wind is coming from
    if(diff > 90)
      {setprop("surface-positions/sails/sail["~sail~"]/sail-set", "stbd");
       setprop("surface-positions/sails/sail["~sail~"]/sail-set-norm", 1)
      }
    else
      {setprop("surface-positions/sails/sail["~sail~"]/sail-set", "port");
       setprop("surface-positions/sails/sail["~sail~"]/sail-set-norm", -1)
      };

    #fill the sail
    sail_fill(sail, diff);

} #end of sail_tack function

################################################################
stay_sail_tack = func(sail, hdg, wind_deg){
  #Determine the degree the sail is facing (bearing is based on bow of ship being zero)
   var sail_facing = getprop("surface-positions/sails/sail["~sail~"]/sail-bearing-deg");

   #adjust for boom_deg being 180+/- on either side instead of 360 around
   if(sail_facing < 0)
     {sail_facing = math.abs(sail_facing) + 180}
   else
     {sail_facing = 180 - math.abs(sail_facing)};

   #offset sail facing by the number of degrees hdg has rotated
   if(hdg < sail_facing)
     {sail_facing = sail_facing + hdg}
   else
     {sail_facing = sail_facing - (360 - hdg)};
   if(sail_facing > 360)
     {sail_facing = sail_facing - 360};


   setprop("surface-positions/sails/sail["~sail~"]/sail-beta-deg", math.abs(sail_facing - wind_deg)); #angle of sail from wind, 0 to 360 (I think!)

var sail_data = "Sail Facing: "~ sail_facing ~
                 "\nWind Dir: " ~ wind_deg ~
                 "\nDiff: "~  getprop("surface-positions/sails/sail["~sail~"]/sail-beta-deg") ~
                 "\nSail2 D: " ~ getprop("/fdm/jsbsim/aero/force/D_sail-1-lbs");
 #gui.popupTip(sail_data);

     #offset stay sail facing by 90
     if(90 < sail_facing)
       {sail_facing = sail_facing + 90}
     else
       {sail_facing = sail_facing - (360 - 90)};

     if(sail_facing > 360)
       {sail_facing = sail_facing - 360};
   #at this point both ship heading (hdg) and sail facing (sail_facing) are 0 to 360

   #difference between sail facing and wind degree
   var diff = math.mod((wind_deg - sail_facing), 360); #normDeg = mod(a-b,360);
       diff = math.min(360 - diff, diff);              # absDiffDeg = min(360-normDeg, normDeg);

   #determine whether to show port or stbd sail set depending on which side of sail facing the wind is coming from
   if(diff > 90)
     {setprop("surface-positions/sails/sail["~sail~"]/sail-set", "port")}
   else
     {setprop("surface-positions/sails/sail["~sail~"]/sail-set", "stbd")};

   #fill the sail
    sail_fill(sail, diff);

} # end of stay_sail_tack function

################################################################
sail_fill = func(sail, diff){

  # set the fill factor of the sails - needs to range from 0 (flat) to 2 (filled)
  var fill = math.abs(2 - (math.abs(180 - diff) * 0.022));
  setprop("surface-positions/sails/sail["~sail~"]/sail-fill", fill);

} #end of sail_fill function
