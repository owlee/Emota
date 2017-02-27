echo "Cleaning output space"
rm 960x720_face_only/*
echo "Starting on input space"

total_start=`date +%s`
for file in 960x720/*.jpg; do
  name=$(basename "$file")
  i=0
  crop_total=0
  facedetect "$file" | while read x y w h; do
    c_start=`date +%s`
    convert "$file" -crop ${w}x${h}+${x}+${y} "960x720_face_only/${name%.*}_${i}.${name##*.}"
    c_end=`date +%s`
    i=$(($i+1))
    crop_total=$((crop_total+(c_end-c_start)))
    echo "Crop total: $crop_total, #i: $i"
  done
done
total_end=`date +%s`
runtime=$((end-start))

echo "Script Runtime: $runtime"
echo "Average Crop time: . $((crop_total/i)) .
