# GSoC-2020
## Swift library for Image Loading

### MILESTONE 1: 
* Benchmark the image loading libraries using subset of imagenette to figure out the fastest and the most stable library.

  - For Benchmarking, we used: https://github.com/google/swift-benchmark  
  - For Image Dataset, we used: https://github.com/fastai/imagenette  
  Created a seeded random subset of 1000 images by selecting 100 images from each class (10 classes) to have a balanced dataset.

#### Results

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|------------------:|--------------:|---------------:|
|   160 x 160       | PIL Image Loading Function |  54628854796.0 ns (50 s) | ±   3.68 %    |       5  |
|   320 x 320       | PIL Image Loading Function |  145838154204.0 ns (145 s)| ±  12.74 %     |       5  |

