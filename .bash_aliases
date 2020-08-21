alias hibernate='sudo echo "ok" && xdg-screensaver activate && sleep 3 && sudo pm-hibernate'
alias ls='ls -alh --color'
alias edit='subl'
alias sedit='sudo subl'
alias addtogroup='sudo usermod -a -G'
alias remove_old_kernels='sudo apt-get purge $(dpkg --get-selections | grep -v deinstall | grep -E "linux-(headers|image)" | grep -v $(uname -r | cut -d- -f1,2) | grep $(uname -r | cut -d- -f1) | cut -f1)'
alias search='apt search'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias show='apt show'
alias update='sudo apt update'
alias upgrade='sudo apt update && sudo apt upgrade'
alias full-upgrade='sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove'
alias remove_old_kernels='sudo apt purge $(dpkg --get-selections | grep -v deinstall | grep -E "linux-(headers|image)" | grep -v $(uname -r | cut -d- -f1,2) | grep $(uname -r | cut -d- -f1) | cut -f1)'
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
function createdb() {
	sudo su - postgres -c "psql -w -q -c \"CREATE USER $1 WITH PASSWORD 'test';\""
	sudo su - postgres -c "psql -w -q -c \"CREATE DATABASE $1 OWNER $1;\""
	sudo su - postgres -c "psql -w -q -c \"REVOKE ALL ON DATABASE $1 FROM public;\""
	sudo su - postgres -c "psql -w -q -d $1 -c \"GRANT ALL ON SCHEMA public TO $1;\""
	sudo su - postgres -c "psql -w -q -c \"ALTER USER $1 SUPERUSER;\""
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