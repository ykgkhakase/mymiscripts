#!/bin/bash

function urlencode() {
    local data="$1"
    echo -n "$data" | xxd -plain | sed 's/../%&/g' | tr -d '\n'
}


# 初期値設定
DURATION=1  # デフォルトの会議時間は1時間
DESCRIPTION=""  # デフォルトのDESCRIPTIONは空
URL_GOOGLE_CAL=0 # Google カレンダー追加用URLの生成、長い..

# オプション解析
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d)
            DURATION=$2
            shift 2
            ;;
        --desc)
            DESC_FILE=$2
            if [ ! -f "$DESC_FILE" ]; then
                echo "Error: File $DESC_FILE does not exist."
                exit 1
            fi
            #TODO; GNU sed trick?? https://takuya-1st.hatenablog.jp/entry/2015/03/19/020000
            DESCRIPTION=$(sed ':a;N;$!ba;s/\n/\\n/g' "$DESC_FILE")
            shift 2
            ;;
        --google-cal)
            URL_GOOGLE_CAL=1
            shift
            ;;
        -*)
            echo "Invalid option: $1"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# 残りの引数の確認
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [-d DURATION_HR] [--desc DESCRIPTION_FILE] [--google-cal] <YYYY-MM-DD> <HH:MM> <TITLE>"
    exit 1
fi

# 引数の取得
DATE=$1
START_TIME=$2
TITLE=$3

PROGNAME=$(basename $0)

# DESCRIPTIONが未設定の場合はTITLEを使用
if [ -z "$DESCRIPTION" ]; then
    DESCRIPTION=$TITLE
fi

# タイムゾーンをJSTに設定
export TZ=JST-9

# 日付と時間をJST形式で計算
START_DATETIME=$(date -d "${DATE}T${START_TIME}" +%Y%m%dT%H%M%S)
END_DATETIME=$(date -d "${DATE}T${START_TIME} ${DURATION} hours" +%Y%m%dT%H%M%S)
TIMESTAMP=$(date -u +%Y%m%dT%H%M%SZ)

# イベントUIDの生成（ランダムID）
EVENT_UID=$(uuidgen)

# ICSファイル名
FILENAME="${TITLE// /_}.ics"

# ICS内容を作成
cat <<EOF > $FILENAME
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//$PROGNAME//NONSGML v1.0//EN
BEGIN:VEVENT
UID:${EVENT_UID}
DTSTAMP:${TIMESTAMP}
DTSTART;TZID=Asia/Tokyo:${START_DATETIME}
DTEND;TZID=Asia/Tokyo:${END_DATETIME}
SUMMARY:${TITLE}
DESCRIPTION:${DESCRIPTION//$/\\n}
LOCATION:Online
END:VEVENT
END:VCALENDAR
EOF

echo "ICS file created: $FILENAME" >&2

# Optionally, a URL for adding data to Google calender is made
function url_for_google_calender(){
   local text=$(urlencode "$TITLE")
   # "<br>" tag is available although "\n" don't work.
   local br_detail=$(echo "$DESCRIPTION" | sed 's,\\n,<br>,g')
   local details=$(urlencode "$br_detail")

   echo "https://www.google.com/calendar/render?action=TEMPLATE&text=$text&details=$details&dates=${START_DATETIME}/${END_DATETIME}&UID=${EVENT_UID}&location=Online"
}

if [ $URL_GOOGLE_CAL -eq 1 ]
then
  echo "Generate a url for google calender" >&2
  url_for_google_calender
fi

