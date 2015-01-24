#!/bin/zsh
netdisp=""
netcount="$(grep 'wlo1' /proc/net/dev | awk 'END {print $2}')"
netlevel=0
nettitles=(" b" "kb" "mb" "gb" "tb")
counter=0
musicartist=""
musictitle=""
musicsymbol=""

musicdata=""
cpudata=""
netdata=""
batdata=""

sunread="0"
dunread="0"

compton --config ~/.compton.conf -b

while true; do
#Battery Section----------------------------------------------------------------
	if (( $counter % 5 == 0 )); then
		batperc="$(acpi | cut -d, -f 2)"
        battime="$(acpi | cut -d, -f 3 | cut -c3-6)"
        batchg="$(acpi | cut -d, -f 1 | cut -d' ' -f 3)"
        if [ $batchg = "Discharging" ]; then
            if [[ "0:15" > $battime ]]; then
                batdata="<span bgcolor='#FF0000'> × $batperc, $battime</span>"
            else
                batdata="× $batperc $battime"
            fi
        else
            if [[ ( $batperc = " 100%" ) || ( $battime = "" ) ]]; then
                batdata=""
            else
                batdata="Ö $batperc $battime"
            fi
        fi

#Date Section-------------------------------------------------------------------
		time="Õ $(date +'%m/%d %H:%M')"
	fi
	
#Music Section------------------------------------------------------------------
	musicraw="$(cmus-remote -Q 2> /dev/null)"
    musicartist="$(echo $musicraw | awk '/tag artist/' | cut -d' ' -f 3- - | awk -F. '{str="";if ( length($1) > 15 ) str="...";print substr($1,0,15)str}' )"
	musictitle="$(echo $musicraw | awk '/tag title/' | cut -d' ' -f 3- - | awk -F. '{str="";if ( length($1) > 24 ) str="...";print substr($1,0,24)str}' )"
    musicfile="$(echo $musicraw | awk '/file/' | awk 'BEGIN {FS = "/"}; { print $(NF) }'| awk -F. '{str="";if ( length($1) > 24 ) str="...";print substr($1,0,24)str}' )"
	musicplay="$(echo $musicraw | awk '/status/' | cut -d' ' -f 2- -)"
    musicduration="$(echo $musicraw | grep 'position' | cut -d' ' -f 2 -)"
    musicposition="$(echo $musicraw | grep 'duration' | cut -d' ' -f 2 -)"

	
	if [[ $musicplay == "playing" ]]; then
		musicsymbol="Î"
	elif [[ $musicplay == "paused" ]] then
		musicsymbol="Ï"
	elif [[ $musicplay == "stopped" ]] then
		musicsymbol="" # to display
	else
		musicsymbol=""
	fi

    if [[ -z $musictitle ]]; then
        musictitle=$musicfile
    fi
	
	if [[ $musicsymbol == "" ]]; then
		musicdata="";
	else
		if [[ ($musicartist == "") || ($musictitle == "") ]]; then
			musicdata="$musicsymbol $musicartist $musictitle"
		else
			musicdata="$musicsymbol $musicartist - $musictitle"
		fi
	fi
    if [[ $musicduration == "" ]]; then
        musicdata="";
    else
        (( linept = $musicduration * (${#musicdata} + 2) / $musicposition ))
        (( lineend = $linept + 1 ))
        if [[ $linept -gt 1 ]]; then
            musicdata="<span underline='single' underline_color='#62f5c8'>$(echo $musicdata | cut -c-$linept -)</span>$(echo $musicdata | cut -c$lineend-)"
        fi
    fi

#Network Section----------------------------------------------------------------
	wnet="$(grep 'wlo1' /proc/net/dev | awk 'END {print $2}')"
	enet="$(grep 'eno1' /proc/net/dev | awk 'END {print $2}')"
    if [ $wnet = "0" ]; then
        wnet=$enet
    fi
	((netdisp=($wnet-$netcount)/5))
	netcount=$wnet
	netlevel=1
	while (($netdisp>999)); do
		((netdisp=$netdisp/1000))
		((netlevel=$netlevel+1))
	done
	netdisp="$(printf %03d $netdisp)"
	netdata="Ð $netdisp$nettitles[$netlevel]"

#News Section-------------------------------------------------------------------
    #if (( counter % 30 == 0 )); then
        #sunread="$(sqlite3 ~/.local/share/singularity/feeds.db 'SELECT COUNT(unread) FROM entries WHERE unread=1')"
        #dunread="$(sqlite3 ~/Documents/.Collections/singularity-dat/data.db 'SELECT COUNT(unread) FROM entries WHERE unread=1')"
    #fi
    #if (( counter % 450 == 0 )); then
        #exec singularity -n &
        #exec singularity -d ~/Documents/.Collections/singularity-dat/data.db -n &
    #fi
	
#Main Section-------------------------------------------------------------------
	topdisplay="Ý "
    if (( $sunread > 0 )); then
        topdisplay="$topdisplay<span fgcolor='#ffa77f'>Ø $sunread</span> Ý "
    fi
    if (( $dunread > 0 )); then
        topdisplay="$topdisplay<span fgcolor='#a77fff'>Ø $dunread</span> Ý "
    fi
	if [[ ! $musicdata == "" ]]; then
	  topdisplay="$topdisplay<span fgcolor='#b5d045'>$musicdata</span> Ý "
	fi
	topdisplay="$topdisplay<span fgcolor='#81c0c5'>$netdata</span> Ý "
	if [[ ! $batdata == "" ]]; then
	  topdisplay="$topdisplay<span fgcolor='#fff17e'>$batdata</span> Ý "
	fi
	topdisplay="$topdisplay<span fgcolor='#e0c7a8'>$time</span>"
	title="$(echo $topdisplay | sed 's/&/and/')"
	xsetroot -name $title

	((counter=$counter+1))
    if (( $counter > 450 )); then
        counter=0;
    fi
	sleep 2
done
