package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	ret, _, err := syscall.Syscall(syscall.SYS_FORK, 0, 0, 0)
	if err != 0 {
		fmt.Fprintf(os.Stderr, "Fork failed: %v\n", err)
		os.Exit(1)
	}

	if ret == 0 {
		// 子プロセス
		pid := syscall.Getpid()
		ppid := syscall.Getppid()
		fmt.Printf("子プロセス：pid=%d, 親プロセスのpid=%d\n", pid, ppid)

		binary, lookErr := exec.LookPath("echo")
		if lookErr != nil {
			panic(lookErr)
		}
		args := []string{"echo", fmt.Sprintf("pid=%dからこんにちは", pid)}

		env := os.Environ()                        // 環境変数をそのまま引き継ぐ
		execErr := syscall.Exec(binary, args, env) // ここで子プロセスが置き換わる
		if execErr != nil {
			panic(execErr)
		}
	} else {
		// 親プロセス
		pid := syscall.Getpid()
		fmt.Printf("親プロセス：pid=%d, 子プロセスのpid=%d\n", pid, ret)
	}
}
