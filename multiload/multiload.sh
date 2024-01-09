#!/bin/bash
MULTICPU=0
MULTIMEM=$0
SCRIPT_DIR=$(cd $(dirname $0) && pwd)
usage() {
  exec >&2
  echo "使い方: $PROGNAME [-m] <プロセス数>
  処的の時間動作する負荷処理プロセスを<プロセス数>で指定した数だけ動作させて、全ての終了を待つ。
  各プロセスにかかった時間を出力する。
  デフォルトでは全てのプロセスは1論理CPUで動作する。
オプションの意味:
  -m 各プロセスを複数CPU上で動かせるようにする。"
  exit 1
}

while getopts "m" OPT ; do
  case $OPT in
    m) MULTICPU=1
      ;;
    \?) usage
      ;;
  esac
done
shift $((OPTIND - 1))
if [ $# -lt 1 ] ; then
  usage
fi
CONCURRENCY=$1
if [ $MULTICPU -eq 0 ] ; then
  # 付加処理をCPU0でのみ実行できるようにする
  taskset -p -c 0 $$ > /dev/null
fi
for ((i=0; i< CONCURRENCY; i++)) do
  time "${SCRIPT_DIR}/load.py" &
done
for ((i=0; i< CONCURRENCY; i++)) do
  wait
done