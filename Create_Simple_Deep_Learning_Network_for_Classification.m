digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDatasetCoffeebeans');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
%figure;
%perm = randperm(10000,20);
%for i = 1:20
%    subplot(4,5,i);
%    imshow(imds.Files{perm(i)});
%end
labelCount = countEachLabel(imds)
img = readimage(imds,1);
size(img)
numTrainFiles = 80;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
layers = [
    imageInputLayer([160 160 3])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer]; % Define Network Architecture 
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',32, ...  %count round
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress'); % Specify Training Options
net = trainNetwork(imdsTrain,layers,options);

YPred = classify(net,imdsValidation)
YValidation = imdsValidation.Labels

accuracy = sum(YPred == YValidation)/numel(YValidation)
