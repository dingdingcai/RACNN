dataset_generate.m: for generating the varying low resolution dataset e.g. 25x25, 50x50 and 100x100,
from high resolution image set of Stanford Car and UCSD Birds 200-2011

dataset:  is for experimental dataset,like Stanford Cars, UCSD Birds-200-2011 amd Oxford Flowers 102 Categories, they need to be downloaded from http://ai.stanford.edu/~jkrause/cars/car_dataset.html, http://www.vision.caltech.edu/visipedia/CUB-200-2011.html and http://www.robots.ox.ac.uk/~vgg/data/flowers/102/index.html .
The first two fine-grained datasets should be croppedto obtain object-centered images according to provided boundboxes.

AlexNet: contains plain AlexNet, guassian weight RACNN for AlexNet and pre-trained weight RACNN for AlexNet

VGGNet: contains plain VGGNet, guassian weight RACNN for VGGNet and pre-trained weight RACNN for VGGNet

Similiarly, GoogLeNet can be modified for RACNN in the same way as AlexNet and VGGNet.

For convenience and visualisation of training process, jupyter notebook is recommended to use and run .ipynb training scripts


