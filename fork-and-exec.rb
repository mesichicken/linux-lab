#!/usr/bin/env ruby
require 'English'

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
