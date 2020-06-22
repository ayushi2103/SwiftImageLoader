# Swift library for Image Loading
## GSoC-2020

### MILESTONE 1: 
* Benchmark the image loading libraries using subset of imagenette to figure out the fastest and the most stable library.

  - For Benchmarking, we used: https://github.com/google/swift-benchmark  
  - For Image Dataset, we used: https://github.com/fastai/imagenette  
  Created a seeded random subset of 1000 images by selecting 100 images from each class (10 classes) to have a balanced dataset.

#### STEPS

#### LIBRARIES

#### RESULTS

##### Results when benchmarked using all 5 steps

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|:------------------:|:--------------:|:---------------:|
|   160 x 160       | PIL Image Loading Function |  54628854796.0 ns (50 s) | ±   3.68 %    |       5  |
|   320 x 320       | PIL Image Loading Function |  145838154204.0 ns (145 s)| ±  12.74 %     |       5  |
|   160 x 160       | STB_image Image Loading Function |  56738903198.0 ns (50 s) | ±   2.81 %    |       5  |
|   320 x 320       | STB_image Image Loading Function | 144975640171.0 ns (144 s) | ±  3.34 %     |       5  |
|   160 x 160       | JPEGTurbo Image Load operation | 739530998.0 ns (0.74 s) | ±   1.99 %   |       5  |
|   320 x 320       | JPEGTurbo Image Load operation | 1862042453.0 ns (1.9 s) | ±   3.88 %    |       5  |
|   160 x 160       | JPEG Image Load operation | 56629216030.0 ns (50 s) | ±  13.59 %   |       5  |
|   320 x 320       | JPEG Image Load operation | 152135858180.0 ns (150 s) | ±   8.56 %    |       5  |

##### Results when benchmarked using first 3 steps

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|:------------------:|:--------------:|:---------------:|
|   160 x 160       | PIL Image Load operation | 1119275437.5 ns (1.1 s) | ±   10.5 %    |       200  |
|   320 x 320       | PIL Image Load operation | 3745457027.0 ns (3.7 s) | ±   7.97 %    |       25  |
|   160 x 160       | STBImage Image Load operation | 944071793.0 ns (0.9 s) | ±   0.74 %    |       5  |
|   320 x 320       | STBImage Image Load operation | 2840012321.0 ns (2.8 s) | ±   0.95 %    |       5  |
|   160 x 160       | JPEGTurbo Image Load operation | 748089979.5 ns (0.75 s) | ±   2.85 %   |       50  |
|   320 x 320       | JPEGTurbo Image Load operation | 1985243526.50 ns (2.0 s) | ±   3.11 %    |       50  |
|   160 x 160       | JPEG Image Load operation | 52044369008.0 ns (52 s) | ±   1.99 %   |       5 |
|   320 x 320       | JPEG Image Load operation | 195361269887.0 ns (195 s) | ±   1.4 %    |       5  |
