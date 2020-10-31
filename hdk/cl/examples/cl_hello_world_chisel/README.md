# Chiselで、Hello World CL を動かしてみた例です。

Hello World CLの説明については、[こちら](../cl_hello_world)を参照してください。

オリジナルからの変更点は、以下の通りです。

1. [chisel_design](./chisel_design)にChiselのプロジェクトを作成
2. Chiselから生成されたVerilogファイルを[design](./design)に拡張子を.svにしてコピー
3. [ビルドスクリプト](./build/scripts/encrypt.tcl)の `file copy -force `にコピーしたファイルの記述を追加

SystemVerilogのコードを全て排除するのはできないようです。`cl_hello_world`のmoduleのポート定義に、以下の例のような要素数1の配列が定義されていて、このようなコードはChiselからは出力できないためです。

```
output [0:0] XXXX
```
