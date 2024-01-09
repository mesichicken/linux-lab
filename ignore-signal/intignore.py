#!/usr/bin/python3
import signal
# SIGINTシグナルを無視するように設定
# 第一引数にはハンドラを設定するシグナルの番号(signal.SIGINT)を、
# 第二引数にはシグナルハンドラ(ここではsignal.SIG_IGN)を指定する
signal.signal(signal.SIGINT, signal.SIG_IGN)
while True:
  pass