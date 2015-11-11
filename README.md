# Count Shell
ターミナル上で動く、シンプルなタイマー

Count Up と Count Down ができる


## Count Up
やり方
```
# count
```
`Ctrl-c` で止めてね


## Count Down
やり方
```
# count -t 3m
```
* hour  を指定:  `-h 1 ` 
* minuteを指定:  `-m 2 ` 
* secondを指定:  `-s 3 `
* まとめて指定:  `-t 1h2m3s`


## その他
* Count Down 終了時に音( `/a` )をならす
```
# count -t 1s -a
```
