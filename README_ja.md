ChromaPack
==========

ChromaPack は Unity で不可逆テクスチャ圧縮を行うプラグインです。[色差サブサンプリング][Wikipedia]のテクニックを用いることにより、人の目に顕著なアーティファクトを生じること無く、画像のメモリ消費量をピクセルあたり 12 bit まで減らすことができます（32 bit フルカラーと比較して 2.67 倍の圧縮率）。アルゴリズムは非常にシンプルなため、前世代のモバイル GPU でもオンザフライでデコードが可能です。

![Main Screenshot][Screenshot]

*上のスクリーンショットは ChromaPack の画質を検証したものです。上の列はオリジナルの画像、下の列は圧縮後の画像です。注意深く見れば２つめの画像の頬の辺りに色の滲みを見つけることができるかもしれませんが、その影響はほぼ無視できるものです。*

## 基本的な使い方

ChromaPackProcessor スクリプトは、ファイル名の末尾に “CP” というサフィックスを持つ画像を自動的に変換します。既存のファイルにサフィックスを追加するか、サフィックの付いた画像をインポートすると、その画像は ChromaPack エンコードされたテクスチャアセットへと変換されます。

![Converted Image][Converted]

この画像を描画するには “ChromaPack/Opaque” シェーダーを使用します。このシェーダーは画像をオンザフライでデコードし、不透明要素として描画します。

## 1 ビットアルファ透過

ChromaPack は 1 ビットアルファ透過をサポートしています。アルファチャンネルを持つ画像をインポートすると、ChromaPackProcessor はそれを検出し、コンバートされた画像に 1 ビットアルファ情報を埋め込みます。この画像を透過付きで描画するには “ChromaPack/Cutout” シェーダーを使用します。

[Wikipedia]: http://en.wikipedia.org/wiki/Chroma_subsampling
[Screenshot]: http://keijiro.github.io/ChromaPack/screenshot.png
[Converted]: http://keijiro.github.io/ChromaPack/converted.png

License
-------

Copyright (C) 2015 Keijiro Takahashi

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
