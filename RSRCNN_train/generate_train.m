clear;close all;clc
% settings
folder = 'ILSVRC2015/Data/DET/test';
savepath = 'RSRCNN_train.h5';

size_input = 51;
size_label = 51;
down_scale = [50 50];
up_scale = [227 227];
stride = 17;
channel = 3;
count = 0;
data = zeros(size_input, size_input, channel, 1);
label = zeros(size_label, size_label, channel, 1);
% generate data
filepaths = dir(fullfile(folder,'*.JPEG'));

chosen = randperm(length(filepaths));
hei = 227;
wid = 227;
img_num = 500; % choose the number of images used for training RSRCNN
for j = 1 : img_num
    i = chosen(j);
    img = imread(fullfile(folder,filepaths(i).name));
    
    im_label = imresize(img, up_scale, 'bicubic');
    im_input = imresize(imresize(im_label, down_scale, 'bicubic'), up_scale, 'bicubic');
    
    for x = 1 : stride : hei-size_input+1
        for y = 1 :stride : wid-size_input+1
            
            subim_input = im_input(x : x+size_input-1, y : y+size_input-1,:);
            subim_label = im_label(x: x+size_label-1, y: y+size_label-1,:);

            count=count+1;
            if size(img, 3) == 3
                data(:, :, :, count) = subim_input;
                label(:, :, :, count) = subim_label;
            else
                data(:, :, 1, count) = subim_input;
                label(:, :, 1, count) = subim_label;
            end
        end
    end
end

%%
order = randperm(count);
data = data(:, :, :, order);
label = label(:, :, :, order); 

%% writing to HDF5
chunksz = 128;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,:,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,:,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end
h5disp(savepath);
