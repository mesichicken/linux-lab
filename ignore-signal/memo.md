# プログラムの停止方法

このプログラムはctrl + cでは停止できない

よってctrl + zで一度バックグラウンドに追いやる

jobsコマンドでジョブ一覧を表示して

```bash
kill %[job番号]
```
でkillする