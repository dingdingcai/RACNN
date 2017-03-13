clear
clc
close all
test = 'dataset/high_test/';

% train = 'dataset/high_train/';
% low_train_100x100 = fopen('low_train_100x100.txt','w');
% low_test_100x100 = fopen('low_test_100x100.txt','w');
% low_train_50x50 = fopen('low_train_50x50.txt','w');
low_test_50x50 = fopen('low_test_50x50.txt','w');

% low_train_25x25 = fopen('low_train_25x25.txt','w');
% low_test_25x25 = fopen('low_test_25x25.txt','w');

path = test;
% path = train;

files = dir(path);

% down_scale = 100;
down_scale = 50;
% down_scale = 25;

for i = 3:length(files)
    class = [path files(i).name ];
    class_name = dir(class);
    for j=3:length(class_name)
        img = [path files(i).name '/' class_name(j).name];
        pic = imread(img);
        orig = imresize(pic,[227 227],'bicubic');
        low = imresize(orig,[down_scale down_scale],'bicubic');
        upscaled = imresize(low,[227 227],'bicubic');
        target_low_path = [low_path files(i).name];
        imwrite(upscaled, [target_low_path ]);
        fprintf(f1, [target_low_path ' ' num2str(i-2) '\n']);
        target_orig_path = [orig_path files(i).name];
        imwrite(orig, [target_orig_path '/' class_name(j).name]); 
        fprintf(f2, [target_orig_path '/' class_name(j).name ' ' num2str(i-2) '\n']);
    end
end









