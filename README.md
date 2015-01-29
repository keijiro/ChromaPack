ChromaPack
==========

ChromaPack is a lossy texture compression plugin for Unity. By using [chroma subsampling technique][Wikipedia], it reduces the memory requirements of an image to 12-bits per pixel (x2.67 compression for 32bit RGBA image) without introducing noticeable artifacts. The algorithm is quite simple and even previous-generation mobile GPUs can decode it on the fly.

![Main Screenshot][Screenshot]

*The screenshot above shows the compression quality of ChromaPack. The upper row shows the original images, and the bottom row shows the compressed images. You may notice that there is very little color bleeding at some parts of the image, although the difference is not significant.*

Basic Usage
-----------

The ChromaPackProcessor script automatically converts the image files which has the suffix “CP” at the end of the file name. After adding the suffix to an existing file or importing a new file with the suffix, it converts the file into a ChromaPack encoded texture asset.

![Converted Image][Converted]

Use the “ChromaPack/Opaque” shader to draw the image. It decodes and displays the image on the fly.

1-Bit Alpha Transparency
------------------------

ChromaPack supports 1-bit alpha transparency. When importing images with alpha channel, it adds transparency information to the converted texture asset. Use the “ChromaPack/Cutout” shader in order to display it with transparency.

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
