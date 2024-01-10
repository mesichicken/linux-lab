#!/usr/bin/python3

import os
import subprocess
import sys
import mmap

ALLOC_SIZE = 100* 1024 * 1024 # 100MB
PAGE_SIZE = 4096

def access(data):
  for i in range(0, len(data), PAGE_SIZE):
    data[i] = 0

def show_meminfo(msg, process):
  print(msg)
  print("freeコマンドの実行結果:")
  subprocess.run("free")
  print("{}のメモリ関連情報:".format(process))
  subprocess.run(["ps", "-orss,maj_flt,min_flt", str(os.getpid())]) # プロセスのメモリ関連情報を表示
  print()

data = mmap.mmap(-1, ALLOC_SIZE, flags=mmap.MAP_PRIVATE) # mmapを使って100MBのメモリを確保
access(data) # メモリにアクセス
show_meminfo("*** 子プロセス生成前 ***", "親プロセス")

pid = os.fork() # 子プロセスを生成
if pid < 0:
  print("fork()に失敗しました", file=os.stderr)
elif pid == 0:
  show_meminfo("*** 子プロセス生成後 ***", "子プロセス")
  access(data)
  show_meminfo("*** 子プロセスによるメモリアクセス後 ***", "子プロセス")
  sys.exit(0)

os.wait()