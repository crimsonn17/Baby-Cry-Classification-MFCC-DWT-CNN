clear;clc;

DataLatihPath = dir('F:\SKRIPSI\Dataset\data_training');

DataLatihPath = DataLatihPath(3:length(DataLatihPath));

DataLatihCategory = {DataLatihPath.name};

X_Train = {};
Y_Train = {};
X_TrainData = [];
z =1;

for i = 1 : numel(DataLatihCategory)
    audioFilePath = dir(strcat('F:\SKRIPSI\Dataset\data_training\', DataLatihCategory{i},'\*.wav'));
    fileName = {audioFilePath.name};
    
    for j = 1 : numel(fileName)
        [audioIn,fs] = audioread(strcat('F:\SKRIPSI\Dataset\data_training\', DataLatihCategory{i}, '\', fileName{j}));
        
        
        [audioIn,fs] = audioread(strcat('F:\SKRIPSI\Dataset\data_training\', DataLatihCategory{i}, '\', fileName{j}));
        %%MFCC
        coeffs = mfcc(audioIn, fs);
 
        fvMfcc = mean(coeffs,1); %normalisasi
        fvMfcc(isinf(fvMfcc)|isnan(fvMfcc))=0;
        %fvMfcc = transpose(norm);
        
        %%DWT
        [c1,s1] = wavedec2 (audioIn, 1, 'db1'); %level1
        [cH1, cV1, cD1] = detcoef2('all', c1, s1, 1);

        [c2,s2] = wavedec2 (audioIn, 2, 'db1'); %level2
        [cH2, cV2, cD2] = detcoef2('all', c2, s2, 2);

        [c3,s3] = wavedec2 (audioIn, 3, 'db1'); %level3
        [cH3, cV3, cD3] = detcoef2('all', c3, s3, 3);
        
        [c4,s4] = wavedec2 (audioIn, 4, 'db1'); %level4
        [cH4, cV4, cD4] = detcoef2('all', c4, s4, 4);

        %Mean
        meanTraincD1 = mean2(cD1);
        meanTraincD2 = mean2(cD2);
        meanTraincD3 = mean2(cD3);
        meanTraincD4 = mean2(cD4);
        %Standard Deviation
        stdTraincD1 = std2(cD1);
        stdTraincD2 = std2(cD2);
        stdTraincD3 = std2(cD3);
        stdTraincD4 = std2(cD4);
        %range
        rTraincD1 = mean(range(cD4));
        rTraincD2 = mean(range(cD4));
        rTraincD3 = mean(range(cD4));
        rTraincD4 = mean(range(cD4));
        %max value
        maxTraincD1 = max(max(cD1));
        maxTraincD2 = max(max(cD2));
        maxTraincD3 = max(max(cD3));
        maxTraincD4 = max(max(cD4));
        %min value
        minTraincD1 = min(min(cD1));
        minTraincD2 = min(min(cD2));
        minTraincD3 = min(min(cD3));
        minTraincD4 = min(min(cD4));
        %Feature Vector DWT
        fvDWT = [meanTraincD1, meanTraincD2, meanTraincD3,meanTraincD4,stdTraincD1,stdTraincD2,stdTraincD3,stdTraincD4,rTraincD1,rTraincD2,rTraincD3,rTraincD4,maxTraincD1,maxTraincD2,maxTraincD3,maxTraincD4,minTraincD1,minTraincD2,minTraincD3,minTraincD4];
           
        featureVector = [fvMfcc, fvDWT];
        
        X_Train = [X_Train; featureVector];
        Y_Train{z,1} = DataLatihCategory{i};
        z=z+1;
        
    end
end
        X_Train_1 = cell2mat(X_Train);
        featTrain = [X_Train_1];
        for ii = 1:61
            temp = featTrain(ii,:);
                for jj = 1:34
                    datas(jj,:) = temp;
                end
            X_TrainData(ii,:,:) = datas;
        end
save('trainFeature.mat', 'X_Train' , 'Y_Train', 'X_TrainData');
% save X_Train
% save Y_Train
% save X_TrainData

clear;clc
load('trainFeature.mat');

DataUjiPath = dir('F:\SKRIPSI\Dataset\data_testing');
DataUjiPath = DataUjiPath(3:length(DataUjiPath));
DataUjiCategory = {DataUjiPath.name};


%%%TESTING%%%
X_Test = {};
Y_Test = {};
X_TestData = [];
z=1;

for k = 1 : numel(DataUjiCategory)
    audioFilePath = dir(strcat('F:\SKRIPSI\Dataset\data_testing\', DataUjiCategory{k}, '\*.wav'));
    fileName = {audioFilePath.name};
    
    for m = 1 :numel(fileName)
        [audioIn, fs] = audioread(strcat('F:\SKRIPSI\Dataset\data_testing\', DataUjiCategory{k}, '\', fileName{m}));
                
        %%MFCC
        coeffs = mfcc(audioIn, fs);
 
        fvMfcc = mean(coeffs,1); %normalisasi
        fvMfcc(isinf(fvMfcc)|isnan(fvMfcc))=0;
        %fvMfcc = transpose(norm);
        
        %%DWT
        [c1,s1] = wavedec2 (audioIn, 1, 'db1'); %level1
        [cH1, cV1, cD1] = detcoef2('all', c1, s1, 1);

        [c2,s2] = wavedec2 (audioIn, 2, 'db1'); %level2
        [cH2, cV2, cD2] = detcoef2('all', c2, s2, 2);

        [c3,s3] = wavedec2 (audioIn, 3, 'db1'); %level3
        [cH3, cV3, cD3] = detcoef2('all', c3, s3, 3);
        
        [c4,s4] = wavedec2 (audioIn, 4, 'db1'); %level4
        [cH4, cV4, cD4] = detcoef2('all', c4, s4, 4);

        %Mean
        meanTestcD1 = mean2(cD1);
        meanTestcD2 = mean2(cD2);
        meanTestcD3 = mean2(cD3);
        meanTestcD4 = mean2(cD4);
        %Standard Deviation
        stdTestcD1 = std2(cD1);
        stdTestcD2 = std2(cD2);
        stdTestcD3 = std2(cD3);
        stdTestcD4 = std2(cD4);
        %range
        rTestcD1 = mean(range(cD4));
        rTestcD2 = mean(range(cD4));
        rTestcD3 = mean(range(cD4));
        rTestcD4 = mean(range(cD4));
%         %max value
        maxTestcD1 = max(max(cD1));
        maxTestcD2 = max(max(cD2));
        maxTestcD3 = max(max(cD3));
        maxTestcD4 = max(max(cD4));
%         %min value
        minTestcD1 = min(min(cD1));
        minTestcD2 = min(min(cD2));
        minTestcD3 = min(min(cD3));
        minTestcD4 = min(min(cD4));
        %Feature Vector DWT
        fvDWT = [meanTestcD1,meanTestcD2,meanTestcD3,meanTestcD4,stdTestcD1,stdTestcD2,stdTestcD3,stdTestcD4,rTestcD1,rTestcD2,rTestcD3,rTestcD4,maxTestcD1,maxTestcD2,maxTestcD3,maxTestcD4,minTestcD1,minTestcD2,minTestcD3,minTestcD4];
        
        featureVector = [fvMfcc, fvDWT];
        
        X_Test = [X_Test; featureVector];
        Y_Test{z,1} = DataUjiCategory{k};
        z=z+1;
        
    end
end
        X_Test_1 = cell2mat(X_Test);
        featTrain = [X_Test_1];
        for ii = 1:30
            temp = featTrain(ii,:);
                for jj = 1:34
                    datas(jj,:) = temp;
                end
            X_TestData(ii,:,:) = datas;
        end
        

save('testFeature.mat','X_Test','Y_Test','X_TestData');







