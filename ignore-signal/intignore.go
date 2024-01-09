package main

import (
	"os/signal"
	"syscall"
)

func main() {
	// SIGINTシグナルを無視する
	signal.Ignore(syscall.SIGINT)
	// 無限ループ
	for {
	}
}
