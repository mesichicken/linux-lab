# 静的ライブラリであるlibc.aを使う場合

```bash
cc -static -o pause pause.c
ls -l pause
ldd pause
```

# 共有ライブラリであるlibc.soを使う場合

```bash
cc -o pause pause.c
ls -l pause
ldd pause
```
