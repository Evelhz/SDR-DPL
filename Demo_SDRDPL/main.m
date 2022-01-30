clc;clear
ModeSelect = 1; % 1--Normal; 2--Specific Frame
dataName = 'Classroom2';
%--------------------I. prepare data---------------------------------------
load(['features_' dataName '.mat']);
load(['labels_' dataName '.mat'])
Data = normcol_equal(Feature); clear Feature
Label = Label';
TrNum = 2000;
for il = 1:length(unique(Label))
    npool = unique(Label);
    Label(Label==npool(il))=il;
end

if ModeSelect == 1
    TrialNum = 10;
else
    TrialNum = 1;
end
%--------------------II. run experiments-----------------------------------
for iTrial = 1 : TrialNum
    clc
    disp('*******************************')
    fprintf('Method: SDR-DPL\n');
    fprintf('Dataset: %s\n', upper(dataName));
    fprintf('Feature: Gist\n');
    fprintf('Start training... Trial(%d/%d)\n',iTrial,TrialNum);
    disp('*******************************')
    
    switch ModeSelect
        case 1 % normal
            Tot = 1:size(Data,2);
            ranTot = randperm(size(Data,2));
            ranTra = ranTot(1:TrNum);
            indTra = sort(ranTra);
            indTest = Tot;
            indTest(indTra)=[];
        case 2 % specific frame
            load(['ExtractFramesInd_' dataName '.mat']);
    end
    
    TrData = Data(:,indTra);
    TrLabel = Label(indTra);
    TtData = Data(:,indTest);
    TtLabel = Label(indTest);

    %Parameter setting
    DictSize = 30;
    tau    = 0.1;
    lambda = 0.1;
    gamma  = 0.0001;
    
    % DPL trainig
    tic
    [ DictMat , P_Mat ,Sal_Mat,Coef ] = TrainSDRDPL(  TrData, TrLabel, DictSize, tau, lambda, gamma );
    TrTime = toc;
       
    %DPL testing
    tic
    [~,PredictLabel] = ClassificationSDRDPL( TtData , DictMat,P_Mat,Sal_Mat);
    TtTime = toc;
    
    MAE = mae(abs(PredictLabel-TtLabel));
    MSE = (PredictLabel-TtLabel)*(PredictLabel-TtLabel)'/length(PredictLabel);

    MAE_DPL(iTrial) = MAE;
    MSE_DPL(iTrial) = MSE;
    TrTimeDPL(iTrial) = TrTime;
    TtTimeDPL(iTrial) = TtTime;
end
if ModeSelect==2
    PredictionComparisonForCrowdCounting
end
meanMAE = mean(MAE_DPL);
meanMSE = mean(MSE_DPL);
std_MAE = std(MAE_DPL);
std_MSE = std(MSE_DPL);
meanTrTime = mean(TrTimeDPL);
meanTtTime = mean(TtTimeDPL);
params.DictSize = DictSize;
params.tau = tau;
params.lambda = lambda;

fprintf('MAE:%.2f +- %.3f\n',meanMAE,std_MAE);
fprintf('MSE:%.2f +- %.3f\n',meanMSE,std_MSE);

save(['Results_SDR-DPL_' dataName '.mat'], 'MAE_DPL','MSE_DPL','meanMAE',  ...
    'meanMSE', 'std_MAE','std_MSE','meanTrTime','meanTtTime', ...
    'params','-v7.3');


