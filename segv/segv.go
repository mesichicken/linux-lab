package main

import "fmt"

func main() {
	// nilは必ず失敗してページフォールトが発生する特殊なメモリ
	var p *int = nil
	fmt.Println("不正メモリアクセス前")
	*p = 0
	fmt.Println("不正メモリアクセス後")
}
