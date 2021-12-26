function AverageStd = BlockAverageStd(level,filename)

% level = 64 32 16 8 4 2 1....
% filanme = eg1 D:\0_StudyFiles\PointCloud\0RelatedFiles\PlyFiles\apple.ply
%           eg2 ../../PlyFiles/pineapple.ply
%           eg3 apple.ply

PC = pcread(filename);
xyz = PC.Location;
rgb = PC.Color;
num = PC.Count;
range = 1024/level;
xyz = floor(xyz/level)+1;
[Y,~,~] = rgb2yuv(rgb(:,1),rgb(:,2),rgb(:,3));
Y = double(Y);
data = cell(range,range,range,1);
% Put the Y value in the correct cell
for i = 1:num
    data{xyz(i,1),xyz(i,2),xyz(i,3)} = [data{xyz(i,1),xyz(i,2),xyz(i,3)};Y(i)];
end
index = ~cellfun('isempty', data);
notEmpty = sum(sum(sum(index)));

stdAll = 0;
count = 0;

for i = 1:range
    for j = 1:range
        for k = 1:range
            if ~isempty(data{i,j,k})
                stdAll = stdAll + std(data{i,j,k},0,1);
                count = count + 1;
            end
        end
    end
end
AverageStd = stdAll/notEmpty;
end
