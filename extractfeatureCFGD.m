clc;
clear;
filepath = './extrafeature/testdata/';
dirOutput = dir(fullfile(filepath,'*.ply'));
plyName = {dirOutput.name}';
onlyName = strrep(plyName,'.ply','');
contentNum = size(onlyName,1);
fid = fopen('colorgradientfeature.txt','wt');
ner_num=7;
for index = 1:contentNum
%     index=1;
    filename = [filepath,plyName{index}];
    P=pcread(filename);
    [Y,U,V]=rgb2yuv(P.Color(:,1),P.Color(:,2),P.Color(:,3));
    Y=double(Y);
    U=double(U);
    V=double(V);
    [idx,dist]=knnsearch(P.Location,P.Location,'dist','euclidean','k',7);
    pnum=length(idx);
    colgra=[];
    for p=1:pnum
         pcolsum=0;
         for n=1:ner_num
             coldistemp=double(abs(Y(p)-Y(idx(p,(n+1)))))/dist(p,(n+1));
             pcolsum=pcolsum+coldistemp;
         end 
         colgra(p)=pcolsum/ner_num;
    end 
    corgra_fea=mean(colgra);
    fprintf(fid,'File %s colorgradientfeature %1.6f \n',plyName{index},corgra_fea);
    clear filename P Y U V idx dist pnum p colgra corgra_fea;
end
fclose(fid);
