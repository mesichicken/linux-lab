#!/usr/bin/env ruby
require 'English' # 特殊なグローバル変数に対してより読みやすいエイリアスを提供するためのライブラリ
# $PROCESS_ID または $PID: 現在のプロセスのIDを参照します。これはRubyの標準的なグローバル変数 $0 のエイリアス

parent_pid = $PID  # 親プロセスのPIDを取得

pid = Process.fork
if pid.nil?
  # 子プロセス
  puts "子プロセス：pid=#{$PROCESS_ID}, 親プロセスのpid=#{parent_pid}"
  exec("/bin/echo", "pid=#{$PROCESS_ID}からこんにちは, 親プロセスのpid=#{parent_pid}")
elsif pid > 0
  # 親プロセス
  puts "親プロセス：pid=#{$PROCESS_ID}, 子プロセスのpid=#{pid}"
  Process.wait(pid)
else
  # forkに失敗
  abort("forkに失敗しました")
end
