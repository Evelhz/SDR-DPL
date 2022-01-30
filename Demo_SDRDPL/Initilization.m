function [ DataMatX, DataMatY, DictMat, P_Mat, DataInvMat, RlxA, RlxB, Sal_Mat ,DataC ] = Initilization( Data , Label, DictSize, tau, lambda, gamma )
% In this intilization function, we do the following things:
% 1. Random initialization of dictioanry pair D and P for each class
% 2. Precompute the class-specific inverse matrix used in Eq. (10)
% 3. Compute matrix class-specific code matrix A by Eq. (8) 
%    with the random initilized D and P
%
% The randn seeds are setted to make sure the results in our paper are
% reproduceable. The randn seed setting can be removed, our algorithm is 
% not sensitive to the initilization of D and P. In most cases, different 
% initilization will lead to the same recognition accuracy on a wide randge
% of testing databases.
% Sal - Saliant matirx d-by-d

ClassNum = max(Label);
Dim      = size(Data,1);
I_Mat    = eye(Dim,Dim);

for i=1:ClassNum
    TempDataX      = Data(:,Label==i);
    TempDataY      = fliplr(TempDataX);
    DataMatX{i}    = TempDataX;
    DataMatY{i}    = TempDataY;
    randn('seed',i);                        
    DictMat{i}    = normcol_equal(randn(Dim, DictSize));
    randn('seed',2*i);
    P_Mat{i}      = normcol_equal(randn(Dim, DictSize))';
    randn('seed',3*i);
    Sal_Mat{i}    = normcol_equal(randn(Dim, Dim));
    
    TempDataC     = Data(:,Label~=i);
    DataC{i}      = TempDataC;
    DataInvMat{i} = inv(tau*TempDataX*TempDataX'+tau*TempDataY*TempDataY'+lambda*TempDataC*TempDataC'+gamma*I_Mat);
end

RlxA = UpdateA(  DictMat, DataMatX, P_Mat, Sal_Mat,  tau, DictSize  );
RlxB = UpdateB(  DictMat, DataMatX, DataMatY, P_Mat, Sal_Mat, tau, DictSize ); 

