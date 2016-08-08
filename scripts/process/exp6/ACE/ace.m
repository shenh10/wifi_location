close all; 
clear all;
data_path='../../../data/exp6/';
file_folder=strcat(data_path,'mat/');
figure_folder=strcat(data_path, 'figure/');
mat_folder=strcat(data_path,'mat/');

% extract main features
empty_file=dir(strcat(file_folder,'m*_empty.mat'));

stand_file=dir(strcat(file_folder,'stand/*.mat'));
map = [-1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        -1, 1, -1, 1, -1, 1, -1 ...\
        1, 1, 1, 1, 1, 1, 1 ...\
        1, 1, 1, 1, 1, 1, 1 ...\
        1, 1, -1, -1, -1, 1, 1 ...\
];

[row, col] = size(map);
voxel_num = sum(map == 1);
pos = find(map == 1);
index = [mod(pos + row - 1, row) + 1, floor((pos + row - 1)/row)];
sample_len = 2000;
stream_num = 3;
subcarrier_num = 30;
M = zeros(voxel_num,stream_num, subcarrier_num,  sample_len*2);

for i= 1:numel(stand_file)
    fname = stand_file(i).name;
    tag = str2double(regexpi(fname, '[\d+]*', 'match');
    load(fname);
    voxel_id = find(ismember(index, [tag(2), tag(3)], 'rows'));
    h_avg_amp = amplitude(sample_csiM(:,:,:,1:sample_len));
    static = length(strfind(fname, 'static'));
    M( voxel_id, tag(1), :, ( static )* sample_len + 1: (staic + 1) *sample_len ) = h_avg_amp;
end
M = squeeze(mean(M, 3));
histo = fingerprint_builder(M); 


