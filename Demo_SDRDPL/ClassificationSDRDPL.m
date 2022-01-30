function [Error,PredictLabel] = ClassificationSLatDPL( TestData , D_Mat,L_Mat,P_Mat)

%Projective representation coefficients estimation
ClassNum = size(D_Mat,2);
% PredictCoef = EncoderMat*TestData;
Error = ones(ClassNum,size(TestData,2));
% Class-specific reconstruction error caculation
for i = 1:ClassNum
    Error(i,:)=sum((TestData - D_Mat{i}*L_Mat{i}*TestData-P_Mat{i}*TestData).^2);
%        Error(i,:)=sum((TestData - D_Mat{i}*L_Mat{i}*TestData).^2);
end
% [Distance PredictLabel] = min(Error);
[Error,PredictLabel] = min(Error);






