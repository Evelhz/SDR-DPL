function [PredictLabel Error] = ClassificationDPL( TestData, DictMat , EncoderMat, DictSize )

%Projective representation coefficients estimation
ClassNum = size(DictMat,2);
PredictCoef = EncoderMat*TestData;

% Class-specific reconstruction error caculation
for i = 1:ClassNum
    Error(i,:)= sum((DictMat{i}*PredictCoef((i-1)*DictSize+1:i*DictSize,:)-TestData).^2);
end
[Distance PredictLabel] = min(Error);



