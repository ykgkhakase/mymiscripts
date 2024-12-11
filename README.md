# mymiscripts
mymiscripts: A collection of my miscellaneous scripts for various purposes.

# ics.sh
カレンダー用のテキストファイル作成スクリプト
(Script for creating ics files for calendars)

```
Usage: ics.sh [-d DURATION_HR] [--desc DESCRIPTION_FILE] <YYYY-MM-DD> <HH:MM> <TITLE>
```

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

# pw.sh
ランダムな文字列を生成する。(Generate a random stirng)

```
# 19文字からなるランダムな文字列(0-9a-zA-Z)を生成する。(Generate a string which consists of a-zA-Z0-9)
$ pw.sh 19
4JAj2oQxgzPjTXrWM2V
# 4文字ごとにハイフンを含む19文字からなる文字列を生成
$ pw.sh -s 4 19
jQs3-dxcz-mX6R-KZb7
# dollar(by -d) and sharp(by -a ) will be included.
$ pw.sh -d -a 19 
p4#PdS6eN5f$YsvC4aG 
# more complex string.
$ pw.sh -d -a -s 4 19 
19Vv-LQXJ-jFcX-Y#$m
```

# fp
相対パスから絶対パスを生成する。(Generate an absolute path from a relative path.)

```
$ fp ./fp
/home/ykgkhakase/mymiscripts/fp
```