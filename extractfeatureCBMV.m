clc,clear; 
filepath = './testdata/';
dirOutput = dir(fullfile(filepath,'*.ply'));
plyName = {dirOutput.name}';
% onlyName = strrep(plyName,'.ply','');
contentNum = size(plyName,1);
for level = [64 32 16 8]
    AverageStd = zeros(contentNum,1);
    
    for index = 1:contentNum
        filename = [filepath,plyName{index}];
        AverageStd(index) = BlockAverageStd(level,filename);
    end
    
    sheetName = ['Block',mat2str(level)];
    xlswrite('AverageStd_16.xlsx',plyName,sheetName,'A');
    xlswrite('AverageStd_16.xlsx',AverageStd,sheetName,'B');
end

        