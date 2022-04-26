%Program to calculate proability density of velocity fluctuations in HW
clc;clear all;
uflc=dlmread('uflc_10.218_FST_R24_500_600.txt');temp=size(uflc);yloc=temp(2);clear temp;
columns=yloc;
B=100;
for i=1:yloc
    [N(:,i),edges(:,i)] = histcounts(uflc(:,i)/10.146,B,'Normalization','Probability');
    temp=movmean(edges(:,i),2); bins(:,i)=temp(2:end);
end



fid=fopen('pdf_FST_R24_500_600.dat','w');
fprintf(fid,'TITLE     = "2C PIV DATASET" \n');
fprintf(fid,'VARIABLES = "X" \n');
fprintf(fid,'"PDF" \n');
fprintf(fid,'ZONE T="PDF" \n');
fprintf(fid,'I=100, J=29, K=1, ZONETYPE=Ordered \n');        %J has to modified according to number of columns. I always remains 100%
fprintf(fid,'DATAPACKING=POINT \n');
fprintf(fid,'DT=(SINGLE DOUBLE ) \n');
for j=1:yloc
    for i=1:B
        fprintf(fid,'%.9f \t %.9f',bins(i,j),N(i,j));    
        fprintf(fid,'\n');
    end
    fprintf(fid,'\n');
end
fclose(fid);

y=dlmread('y.txt');
fid=fopen('y_by_delta.dat','w');
fprintf(fid,'TITLE     = "2C PIV DATASET" \n');
fprintf(fid,'VARIABLES = "y/delta" \n');
fprintf(fid,'ZONE T="Simple Zone" \n');
fprintf(fid,'I=100, J=29, K=1, ZONETYPE=Ordered \n');        %J has to modified according to number of columns. I always remains 100%
fprintf(fid,'DATAPACKING=POINT \n');
fprintf(fid,'DT=(SINGLE DOUBLE ) \n');
for j=1:yloc
    for i=1:B
        fprintf(fid,'%.9f',y(j));    
        fprintf(fid,'\n');
    end
    fprintf(fid,'\n');
end
fclose(fid);