# Swift library for Image Loading
## GSoC-2020

### MILESTONE 1: 
* Benchmark the image loading libraries using subset of imagenette to figure out the fastest and the most stable library.

  - For Benchmarking, we used: https://github.com/google/swift-benchmark  
  - For Image Dataset, we used: https://github.com/fastai/imagenette  
  Created a seeded random subset of 1000 images by selecting 100 images from each class (10 classes) to have a balanced dataset.

#### STEPS
1.) First we get the paths of images in the datasetType  
2.) Load the image using that library  
3.) Convert and resize it to appropriate tensor  
4.) Calculate its label  
5.) Append it to final list lof tensors and labels  


#### LIBRARIES
PIL: https://github.com/python-pillow/Pillow  
STBImage: https://github.com/nothings/stb  
JPEGTurbo: https://github.com/libjpeg-turbo/libjpeg-turbo  
JPEG Library: https://github.com/kelvin13/jpeg 

#### RESULTS

##### Results when benchmarked using all 5 steps

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|:------------------:|:--------------:|:---------------:|
|   160 x 160       | PIL Image Loading Function |  54628854796.0 ns (50 s) | ±   3.68 %    |       5  |
|   320 x 320       | PIL Image Loading Function |  145838154204.0 ns (145 s)| ±  12.74 %     |       5  |
|   160 x 160       | STB_image Image Loading Function |  56738903198.0 ns (50 s) | ±   2.81 %    |       5  |
|   320 x 320       | STB_image Image Loading Function | 144975640171.0 ns (144 s) | ±  3.34 %     |       5  |
|   160 x 160       | JPEGTurbo Load operation |   55647521090.5 ns (55 s) |  ±   2.51 %     |          5
|   320 x 320       | JPEGTurbo Load operation |  139024297588.0 ns (139 s) |  ±   2.66 %      |         5
|   160 x 160       | JPEG Load operation  |  117379591932.5 ns (117 s) |  ±   6.97 %     |         5
|   320 x 320       | JPEG Load operation  |  349771842833.5 ns (349 s) |  ±   0.63 %    |         5
|   160 x 160       | Nvidia Dali Image Load operation | 1780533644 ns (1.78 s) | ±   1.99 %   |       5 |
|   320 x 320       | Nvidia Dali Image Load operation | 1166308317 ns (1.16 s)* | ±   0.8%   |    5     |

* Nvidia Dali was benchmarked in Python using a Tesla T4 GPU along with 8 CPUs and 30 Gb memory in Ubuntu 18.04 LTS
* *For 320 x 320 operation in Nvidia Dali, only 319 images can be loaded due to memory restrictions. The given time is for 319 images out of total 1000 i.e. for 1/3rd of the total dataset.



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
