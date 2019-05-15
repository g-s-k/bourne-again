fn=$1;
pn=${fn%.*}.png;
ffmpeg -i "$fn" -lavfi showspectrumpic=s=hd720 "$pn";
okular "$pn";
rm "$pn";
