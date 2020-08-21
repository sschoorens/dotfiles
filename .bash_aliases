alias ls='ls -alh --color'
alias edit='subl'
alias sedit='sudo subl'
alias addtogroup='sudo usermod -a -G'
alias full-upgrade='sudo yay -Syu'
alias gitpushskipci='git push -o ci.skip'
function resettouchpad() {
    sudo modprobe -r psmouse
    sudo modprobe psmouse
}
function slugify() {
    echo "$1" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z
}
function compress() {
    time tar -c $1 | pigz -c > `slugify $1`.tar.gz
}
function repair_media() {
    echo "ffmpeg -i $1 -r 30 -vcodec copy -acodec copy repaired_$1"
    ffmpeg -i $1 -vcodec copy -acodec copy repaired_$1
}
function show_fps() {
    echo "ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 $1"
    ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 $1
}
function convert_wav_mp3() {
    for i in *.WAV; do lame -b 320 -h "${i}" "${i%.WAV}.mp3"; done
}
function gitautoprune() {
    git fetch -p && for branch in `LANG=C git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done
}
function compress_mp4_video() {
    ffmpeg -i $1 -copy_unknown -map_metadata 0 -map 0 -codec copy \
    -codec:v libx264 -pix_fmt yuv420p -crf 23 \
    -preset fast compressed_$1
}
function compress_webm_video() {
    ffmpeg -i $1 -copy_unknown -map_metadata 0 -map 0 -codec copy \
    -codec:v libvpx -pix_fmt yuv420p -crf 23 \
    -preset fast compressed_$1
}