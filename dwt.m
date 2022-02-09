%%DWT
clear;clc;
[audioIn, fs] = audioread('Lelah1.wav');
        [c1,s1] = wavedec2 (audioIn, 1, 'db2'); %level1
        [cH1, cV1, cD1] = detcoef2('all', c1, s1, 1);

        [c2,s2] = wavedec2 (audioIn, 2, 'db2'); %level2
        [cH2, cV2, cD2] = detcoef2('all', c2, s2, 2);

        [c3,s3] = wavedec2 (audioIn, 3, 'db2'); %level3
        [cH3, cV3, cD3] = detcoef2('all', c3, s3, 3);
        

        %Mean
        meancD1 = mean2(cD1);
        meancD2 = mean2(cD2);
        meancD3 = mean2(cD3);
        %Standard Deviation
        stdcD1 = std2(cD1);
        stdcD2 = std2(cD2);
        stdcD3 = std2(cD3);
        %range
        rcD1 = range(cD1);
        rcD2 = range(cD2);
        rcD3 = range(cD3);
        %max value
        maxcD1 = max(cD1);
        maxcD2 = max(cD2);
        maxcD3 = max(cD3);
        %min value
        mincD1 = min(cD1);
        mincD2 = min(cD2);
        mincD3 = min(cD3);
        %Feature Vector DWT
        fvDWT = [meancD1, meancD2, meancD3, stdcD1, stdcD2, stdcD3,rcD1, rcD2, rcD3, maxcD1, maxcD2, maxcD3, mincD1, mincD2, mincD3];
        