# mymiscripts
mymiscripts: A collection of my miscellaneous scripts for various purposes.

# ics.sh
カレンダー用のテキストファイル作成スクリプト
(Script for creating ics files for calendars)

Usage: ics.sh [-d DURATION_HR] [--desc DESCRIPTION_FILE] <YYYY-MM-DD> <HH:MM> <TITLE>

使い方
```
日付、開始時間、タイトルの３つを指定
$ ics.sh 2024-12-24 18:00 打ち合わせ

# オプション
# -d で打ち合わせ時間の長さ (hr)を指定。[デフォルト: 1時間]
# --desc ファイル名 で指定した内容の改行を変換して icsファイルに追加 [デフォルト: 空]
$ ics.sh -d 2 --desc url.txt 2024-12-24 18:00 打ち合わせ

# 実行例: icsファイルが作成される (Example of execution: An ics file is created.)
$ ics.sh 2024-12-24 18:00 打ち合わせ
ICS file created: 打ち合わせ.ics
$ ls   打ち合わせ.ics
打ち合わせ.ics
```
