echo "Cleaning output space"
rm 960x720_face_only/*
echo "Starting on input space"

total_start=`date +%s`
i=0
crop_total=0

for file in 960x720/*.jpg; do
  name=$(basename "$file")
  c_start=`date +%s`
  facedetect "$file" | while read x y w h; do
    convert "$file" -crop ${w}x${h}+${x}+${y} "960x720_face_only/${name%.*}_${i}.${name##*.}"
  done
  c_end=`date +%s`

  ((i++))
  temp=$((c_end-c_start))
  crop_total=$((crop_total+temp))
  echo "Crop total: $crop_total, #i: $i $c_end $c_start"
done

total_end=`date +%s`
runtime=$((end-start))

echo "Script Runtime: $runtime"
echo "Average Crop time: . $(($crop_total/$i)) ."
