#!/usr/bin/env bash

#convert obj to ac and adjust texture directory

input=/home/jeff/models/3d_models/ships/Kathryn/kathryn.obj
output=/home/jeff/FlightGear/Aircraft/Kathryn/Models/Kathryn.ac
echo "CONVERTING:";
echo $input;
echo $output;

#convert file
ruby /home/jeff/models/UVF-7-original/convert2.rb $input $output;

#change texture path to FGFS airplane livery directory
echo 'EDITING TEXTURE PATH:'
find $output -type f -exec sed -i 's/texture "/texture "Liveries\//g' {} \;

echo "FINISHED CONVERSION.";
