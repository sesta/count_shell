# Count Shell
ターミナル上で動く、シンプルなタイマー

Count Up と Count Down ができる


## Count Up
やり方
```
# ./count.sh
```
![count_up](https://cloud.githubusercontent.com/assets/8287121/11087667/98e93304-889f-11e5-8fe4-346a15f2c5de.gif)

`Ctrl-c` で止めてね


## Count Down
やり方
```
# ./count.sh -t 3m
```
![count_down](https://cloud.githubusercontent.com/assets/8287121/11087835/f051418a-88a0-11e5-92e0-7ec5e20c2c25.gif)


* hour  を指定:  `-h 1 ` 
* minuteを指定:  `-m 2 ` 
* secondを指定:  `-s 3 `
* まとめて指定:  `-t 1h2m3s`


## その他
* Count Down 終了時に音( `/a` )をならす
```
# ./count.sh -t 1s -a
```
