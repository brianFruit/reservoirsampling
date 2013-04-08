clc,clear

%==========================================================================
%Generate a data set in text file for sampling
%==========================================================================

file = fopen('sample.txt','w');

for i = 1:300
    a = rand()*1000;
    fprintf(file,'%6.2f \r\n',a);
end

%==========================================================================
%Select 50 random samples from the data set generated above
%Assuming I do not know the size (30000) of the data set 
%==========================================================================

fileS = fopen('sample.txt');
frewind(file); %reset position indicator back to beginning of text file
for j = 1:50
    t = j; %t keeps track of the number of rows read
    S(j)= str2num(fgets(fileS)); %store initial the 50 rows
    TT(j) = t; %TT records row index that were sampled
end

flag = 0; %when reach EOF, flag will equal 1
while flag ~= 1
    t = t + 1;
    randNum = round((t-1) * rand()) + 1; 
    %generate a random number from 1 to t
    
    currentRow = fgets(fileS); %get one row at a time
    if currentRow > 0
        if randNum < 51 
            %if randNum is between 1-50, a random recorded sample will be 
            %replaced, probility of replacement decreases as t goes up
            S(randNum) = str2num(currentRow);
            TT(randNum) = t; %TT records row index that were sampled
        end
    end
    if currentRow == -1
        flag = 1; %change flag value to 1 when EOF reached
    end
end

