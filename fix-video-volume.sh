input_file=$1
output_file=$2

volume=$(ffmpeg -i $input_file -af volumedetect -f null /dev/null 2>&1 | grep -oP 'max_volume: -?\K\d+\.\d+')

if [[ "$volume" == "0.0" ]];then
	cp $input_file $output_file
else
	ffmpeg -i $input_file -filter:a "volume="$volume"dB" -c:v copy $output_file -loglevel quiet -f null /dev/null 2>&1
fi
